import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppAssets {
  // app logo
  static const String app_logo = "assets/images/saiyan.jpg";

  // app logo without bg
  static String app_logo_pr(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? "assets/images/saiyan_pr.png"
      : "assets/images/saiyan_pr_black.png";

  static const String app_logo_pr_black = "assets/images/saiyan_pr_black.png";

  // default pp
  static const String default_pp = "assets/images/default_pp.jpg";

  // app banner
  static const String app_banner = "assets/images/banner.jpg";

  // pofuduk ayicik
  static const String pofuduk = "assets/images/pofudukayicik.png";

  // donate ayicik
  static const String donate = "assets/images/donate.png";
}
