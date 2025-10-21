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
        "Hesap oluşturabilmek için kullanıcı sözleşmesini okumak ve kabul etmek zorundasınız.",
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
          "Zaten böyle bir hesap kayıtlı. Farklı bir kullanıcı adı deneyin.",
        );
        return;
      }

      DateTime now = DateTime.now();
      String today = DateFormat('d MMMM yyyy', 'tr').format(now);

      LocalUserModel userData = LocalUserModel(
        username: username,
        joined: "$today'te Katıldı.",
        email: email,
        password: password,
        profilePicture: "",
      );

      bool dbState = await localDb.insertUser(userData);

      Navigator.pop(context);

      if (dbState) {
        AppPopupHelper.showPopup(
          context,
          "Giriş Yapmak İster Misin?",
          "Başarıyla hesap oluşturdun, hemen yeni oluşturduğun hesaba giriş yapmak ister misin?",
          "Giriş Yap",
          "Hayır",
          () async {
            await SharedUtils.addOrUpdateShared(username);

            ScreenMessage.showSuccessToast(
              context,
              "Başarıyla hesaba giriş yapıldı!",
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
        ScreenMessage.showErrorToast(
          context,
          "Bir şeyler ters gitti, hesap oluşturulamadı.",
        );
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
        "Lütfen bilgilerinizi eksiksiz bir şekilde doldurun.",
      );
      return false;
    }

    // username length control
    if (username.length < 3 || username.length > 25) {
      ScreenMessage.showErrorToast(
        context,
        "Kullanıcı adı minimum 3, maksimum 25 karakter olabilir.",
      );
      return false;
    }

    if (email.length > 35 ||
        !(email.contains("@")) ||
        !(email.contains(".com")) ||
        email == "@.com") {
      ScreenMessage.showErrorToast(
        context,
        "Lütfen geçerli bir e-posta adresi giriniz.",
      );
      return false;
    }

    if (password.length < 4) {
      ScreenMessage.showErrorToast(
        context,
        "Şifre minimum 4 karakter olabilir.",
      );
      return false;
    }

    if (password != passwordAgain) {
      ScreenMessage.showErrorToast(
        context,
        "Şifre ile şifre tekrarı birbiriyle uyuşmuyor.",
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
