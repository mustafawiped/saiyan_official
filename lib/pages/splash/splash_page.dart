import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:saiyan_official/router/router.dart';
import 'package:saiyan_official/router/router.gr.dart';
import 'package:saiyan_official/utils/app_version_service.dart';
import 'package:saiyan_official/utils/shared_service.dart';
import '../../core/resources/app_assets.dart';
import '../../core/resources/app_colors.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String routeName = "splash_page_route_name";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  String appVersion = "";

  @override
  void initState() {
    super.initState();

    // logo animation adjusted
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // animation definition
    animation = Tween<double>(begin: 2, end: 2.2).animate(controller);

    // make the animation repeat continuously
    controller.repeat(reverse: true);

    // operations to be done in SplashScreen
    splashMethod(context);
  }

  Future<void> splashMethod(BuildContext context) async {
    appVersion = await AppVersionService.getAppVersion();
    setState(() {});

    String? username = await SharedUtils.getShared();

    if (username is String ? (username.isNotEmpty ? true : false) : false) {
      router.pushAndPopUntil(HomeRoute(), predicate: (route) => false);
    } else {
      router.pushAndPopUntil(LoginRoute(), predicate: (route) => false);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark(context),
      body: Column(
        children: [
          // animated company logo
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      scale: animation.value,
                      child: Image.asset(
                        AppAssets.app_logo_pr(context),
                        width: 150,
                        height: 150,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),

          // the company that developed the software
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "developed by mustafawiped © 2025",
              style: TextStyle(color: Colors.grey, fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }
}
