import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saiyan_official/core/resources/app_assets.dart';
import 'package:saiyan_official/core/resources/app_colors.dart';
import 'package:saiyan_official/utils/app_version_service.dart';
import 'package:saiyan_official/utils/extensions.dart';
import 'package:saiyan_official/viewmodel/auth/login/login_page_view_model.dart';
import 'package:suffadaemon/components/components.dart';
import 'package:suffadaemon/utils/utils.dart';

import '../../../core/shared/widgets/username_formatter.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = "login_page_route_name";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPageViewModel viewModel = LoginPageViewModel();
  String appVersion = "?";

  @override
  void initState() {
    super.initState();

    initComps();
  }

  @override
  void dispose() {
    super.dispose();

    viewModel.nameController.dispose();
    viewModel.passwordController.dispose();
  }

  void initComps() async {
    AppVersionService.getAppVersion().then((value) {
      setState(() {
        appVersion = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark(context),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) {
          return Consumer<LoginPageViewModel>(
            builder: (context, value, child) {
              return buildUI();
            },
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 25,
        child: Center(
          child: SuffaText(
            title:
                "${context.tr("appDeveloperInfo")} | ${context.tr("appVersion", args: [appVersion])}",
            textFont: TextStyle(
              fontSize: SuffaSizes.smallTextSize,
              color: AppColors.textSecondary(context),
              fontWeight: FontWeight.bold,
            ).headerFont,
          ),
        ),
      ),
    );
  }

  Widget buildUI() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // app logo
            buildLogo(),

            // sizedbox
            20.h,

            // username psw
            SuffaInput(
              controller: viewModel.nameController,
              borderColor: Colors.transparent,
              bgColor: AppColors.surfaceCenter(context),
              height: 55,
              focusNode: viewModel.usernameFocusNode,
              inputFormatter: [UsernameFormatter()],
              textFont: TextStyle(
                color: AppColors.textPrimary(context),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ).textFont,
              hintFont: TextStyle(
                color: AppColors.textSecondary(context),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ).textFont,
              hintText: context.tr("vUsername"),
              prefixIcon: Icons.person,
              keyboardType: TextInputType.text,
            ),

            // sizedbox
            20.h,

            // password psw
            SuffaInput(
              controller: viewModel.passwordController,
              borderColor: Colors.transparent,
              bgColor: AppColors.surfaceCenter(context),
              height: 55,
              maxLines: 1,
              focusNode: viewModel.passwwordFocusNode,
              textFont: TextStyle(
                color: AppColors.textPrimary(context),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ).textFont,
              hintFont: TextStyle(
                color: AppColors.textSecondary(context),
                fontSize: 20,
              ).textFont,
              hintText: context.tr("vPassword"),
              prefixIcon: Icons.password,
              pswFunc: () => viewModel.changePswState(),
              pswState: viewModel.pswState,
              keyboardType: TextInputType.visiblePassword,
            ),

            // sizedbox
            10.h,

            // login button
            SuffaButton(
              title: context.tr("vLogin"),
              onClick: () => viewModel.logIn(context),
              bgColor: AppColors.primary(context),
              titleSize: SuffaSizes.xxLargeTextSize,
            ),

            // sizedbox
            10.h,

            // divider
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Divider(color: AppColors.surfaceCenter(context)),
            ),

            // sizedbox
            20.h,

            // register
            buildRegister(),
          ],
        ),
      ),
    );
  }

  Center buildLogo() {
    return Center(
      child: Image.asset(
        AppAssets.app_logo_pr(context),
        width: 300,
        height: 250,
      ),
    );
  }

  Widget buildRegister() {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SuffaText(
            alignment: Alignment.centerRight,
            title: context.tr("vDontHaveAccountYet"),
            maxLines: 1,
            textFont: TextStyle(
              fontSize: SuffaSizes.xMediumTextSize,
              color: AppColors.textSecondary(context),
              fontWeight: FontWeight.w500,
            ).textFont,
          ),
          5.w,
          InkWell(
            onTap: () => viewModel.register(context),
            child: SuffaText(
              alignment: Alignment.center,
              title: context.tr("vRegister"),
              maxLines: 1,
              textFont: TextStyle(
                fontSize: SuffaSizes.mediumTextSize,
                color: AppColors.textPrimary(context),
                fontWeight: FontWeight.w600,
              ).textFont,
            ),
          ),
        ],
      ),
    );
  }
}
