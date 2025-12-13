import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saiyan_official/core/shared/helpers/loading.dart';
import 'package:saiyan_official/core/shared/helpers/popup.dart';
import 'package:saiyan_official/model/local/User/user_model.dart';
import 'package:saiyan_official/response/local/local_user_db.dart';
import 'package:saiyan_official/router/router.dart';
import 'package:saiyan_official/router/router.gr.dart';
import 'package:saiyan_official/utils/shared_service.dart';
import 'package:suffadaemon/utils/utils.dart';

class RegisterPageViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();

  bool pswState = true;

  bool userAgreement = false;

  void changePswState() {
    pswState = !pswState;
    notifyListeners();
  }

  void registerFunc(BuildContext context) async {
    if (!userAgreement) {
      ScreenMessage.showErrorToast(
        context,
        context.tr("vmUserAgreementRequired"),
      );
      return;
    }

    String username = nameController.text,
        email = mailController.text,
        password = passwordController.text,
        passwordAgain = passwordAgainController.text;

    bool inputControlState = inputControl(
      context,
      username,
      email,
      password,
      passwordAgain,
    );

    if (inputControlState) {
      // show loading
      loadingDialog.show(context);

      final localDb = LocalUserDb();

      List<LocalUserModel> usernameControl = await localDb.searchUsers(
        username,
      );

      if (usernameControl.isNotEmpty) {
        Navigator.pop(context);

        ScreenMessage.showErrorToast(
          context,
          context.tr("vmThisUsernameAlreadyExists"),
        );
        return;
      }

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      LocalUserModel userData = LocalUserModel(
        username: username,
        joined: formattedDate,
        email: email,
        password: password,
        profilePicture: "",
      );

      bool dbState = await localDb.insertUser(userData);

      Navigator.pop(context);

      if (dbState) {
        AppPopupHelper.showPopup(
          context,
          tr("vmDoYouWannaLogin"),
          tr("vmDoYouWannaLoginWithDesc"),
          tr("vLogin"),
          tr("vNo"),
          () async {
            await SharedUtils.addOrUpdateShared(username);

            ScreenMessage.showSuccessToast(
              context,
              tr("vmLoginWithSuccessful"),
            );

            router.pushAndPopUntil(HomeRoute(), predicate: (route) => false);
          },
          cancelBtnFunc: () {
            router.pop();
          },
          dismissState: false,
          type: PopupType.question,
        );
      } else {
        ScreenMessage.showErrorToast(context, tr("vmSomethingWentWrong"));
      }
    }
  }

  bool inputControl(
    BuildContext context,
    String username,
    String email,
    String password,
    String passwordAgain,
  ) {
    // empty control
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        passwordAgain.isEmpty) {
      ScreenMessage.showErrorToast(
        context,
        context.tr("vmFillInYourInformation"),
      );
      return false;
    }

    // username length control
    if (username.length < 3 || username.length > 25) {
      ScreenMessage.showErrorToast(
        context,
        context.tr("vmUsernameLengthError"),
      );
      return false;
    }

    if (email.length > 35 ||
        !(email.contains("@")) ||
        !(email.contains(".com")) ||
        email == "@.com") {
      ScreenMessage.showErrorToast(context, context.tr("vmIsNotValidEmail"));
      return false;
    }

    if (password.length < 4) {
      ScreenMessage.showErrorToast(
        context,
        context.tr("vmPasswordCharacterError"),
      );
      return false;
    }

    if (password != passwordAgain) {
      ScreenMessage.showErrorToast(
        context,
        context.tr("vmPasswordAndConfirmIsNotSameError"),
      );
      return false;
    }

    return true;
  }

  void changeUserAgreement(BuildContext context, bool newState) {
    userAgreement = newState;
    if (newState) {
      // router.push(UserAgreementRoute());
    }
    notifyListeners();
  }
}
