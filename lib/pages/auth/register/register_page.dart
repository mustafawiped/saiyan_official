import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saiyan_official/core/resources/app_colors.dart';
import 'package:saiyan_official/core/shared/widgets/username_formatter.dart';
import 'package:saiyan_official/utils/extensions.dart';
import 'package:saiyan_official/viewmodel/auth/register/register_page_view_model.dart';
import 'package:suffadaemon/components/components.dart';
import 'package:suffadaemon/utils/utils.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String routeName = "register_page_route_name";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterPageViewModel viewModel = RegisterPageViewModel();

  @override
  void dispose() {
    super.dispose();

    viewModel.mailController.dispose();
    viewModel.nameController.dispose();
    viewModel.passwordController.dispose();
    viewModel.passwordAgainController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark(context),
      body: ChangeNotifierProvider<RegisterPageViewModel>(
        create: (context) => viewModel,
        builder: (context, child) {
          return Consumer<RegisterPageViewModel>(
            builder: (context, value, child) {
              return buildUI();
            },
          );
        },
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Center(
          child: SuffaText(
            title:
                "Oluşturulan hesaplar sanallaştırılmadığı sürece yerel cihazınızda saklanır. Hesabınızı başka cihazlarda da kullanabilmek için Ayarlar kısmından sanallaştırmalısınız.",
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
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // sizedbox
              10.h,

              // header
              SuffaText(
                title: "Kayıt Ol",
                textFont: TextStyle(
                  color: AppColors.textPrimary(context),
                  fontSize: SuffaSizes.bigLargeTextSize,
                ).headerFont,
              ),

              // sizedbox
              30.h,

              // username
              SuffaInput(
                controller: viewModel.nameController,
                borderColor: Colors.transparent,
                bgColor: AppColors.surfaceCenter(context),
                height: 55,
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
                hintText: "Kullanıcı Adı",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.text,
              ),

              // sizedbox
              10.h,

              // mail address
              SuffaInput(
                controller: viewModel.mailController,
                borderColor: Colors.transparent,
                bgColor: AppColors.surfaceCenter(context),
                height: 55,
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
                hintText: "E-Posta Adresi",
                prefixIcon: Icons.mail,
                keyboardType: TextInputType.emailAddress,
              ),

              // sizedbox
              10.h,

              // password
              SuffaInput(
                controller: viewModel.passwordController,
                borderColor: Colors.transparent,
                bgColor: AppColors.surfaceCenter(context),
                height: 55,
                maxLines: 1,
                textFont: TextStyle(
                  color: AppColors.textPrimary(context),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ).textFont,
                hintFont: TextStyle(
                  color: AppColors.textSecondary(context),
                  fontSize: 20,
                ).textFont,
                hintText: "Şifre",
                prefixIcon: Icons.password,
                pswFunc: () => viewModel.changePswState(),
                pswState: viewModel.pswState,
                keyboardType: TextInputType.visiblePassword,
              ),

              // sizedbox
              10.h,

              // password again
              SuffaInput(
                controller: viewModel.passwordAgainController,
                borderColor: Colors.transparent,
                bgColor: AppColors.surfaceCenter(context),
                height: 55,
                maxLines: 1,
                textFont: TextStyle(
                  color: AppColors.textPrimary(context),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ).textFont,
                hintFont: TextStyle(
                  color: AppColors.textSecondary(context),
                  fontSize: 20,
                ).textFont,
                hintText: "Şifre Tekrarı",
                prefixIcon: Icons.password,
                pswFunc: () => viewModel.changePswState(),
                pswState: viewModel.pswState,
                keyboardType: TextInputType.visiblePassword,
              ),

              // sizedbox
              20.h,

              // info msg
              Row(
                children: [
                  SuffaCheckBox(
                    text: "Kullanıcı Sözleşmesini okudum, onaylıyorum.",
                    checkState: viewModel.userAgreement,
                    activeColor: AppColors.primary(context),
                    textFont: TextStyle(
                      color: AppColors.textSecondary(context),
                      fontSize: SuffaSizes.bigSmallText,
                      fontWeight: FontWeight.bold,
                    ).textFont,
                    onChanged: (newState) =>
                        viewModel.changeUserAgreement(context, newState),
                  ),
                ],
              ),

              // sizedbox
              20.h,

              // register button
              SuffaButton(
                title: "Kayıt Ol",
                onClick: () => viewModel.registerFunc(context),
                bgColor: AppColors.primary(context),
                titleSize: SuffaSizes.xxLargeTextSize,
              ),

              // sizedbox
              20.h,

              // allready have acc?
              buildLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogin() {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SuffaText(
            alignment: Alignment.centerRight,
            title: "Zaten bir hesabın var mı?",
            maxLines: 1,
            textFont: TextStyle(
              fontSize: SuffaSizes.xMediumTextSize,
              color: AppColors.textSecondary(context),
              fontWeight: FontWeight.w400,
            ).textFont,
          ),
          5.w,
          InkWell(
            onTap: () => Navigator.pop(context),
            child: SuffaText(
              alignment: Alignment.center,
              title: "Giriş Yap!",
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
