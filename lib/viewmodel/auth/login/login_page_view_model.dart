import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:saiyan_official/core/shared/helpers/loading.dart';
import 'package:saiyan_official/response/local/local_user_db.dart';
import 'package:saiyan_official/router/router.dart';
import 'package:saiyan_official/router/router.gr.dart';
import 'package:saiyan_official/utils/shared_service.dart';
import 'package:suffadaemon/utils/utils.dart';

class LoginPageViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool pswState = true;

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwwordFocusNode = FocusNode();

  void changePswState() {
    pswState = !pswState;
    notifyListeners();
  }

  void logIn(BuildContext context) async {
    String username = nameController.text, password = passwordController.text;

    usernameFocusNode.unfocus();
    passwwordFocusNode.unfocus();

    if (username.isEmpty || password.isEmpty) {
      ScreenMessage.showErrorToast(
        context,
        context.tr("vmUsernameOrPswCannotBeEmpity"),
      );
      return;
    }

    // loading
    loadingDialog.show(context);

    final localDb = LocalUserDb();

    String response = await localDb.loginControl(username, password);

    if (response == "success") {
      await SharedUtils.addOrUpdateShared(username);

      // close loading
      Navigator.pop(context);

      ScreenMessage.showSuccessToast(context, context.tr("vmSuccessfulLogin"));

      router.pushAndPopUntil(HomeRoute(), predicate: (route) => false);
    } else {
      // close loading
      Navigator.pop(context);

      ScreenMessage.showErrorToast(context, response);
    }
  }

  void register(BuildContext context) {
    usernameFocusNode.unfocus();
    passwwordFocusNode.unfocus();
    router.push(RegisterRoute());
  }
}
