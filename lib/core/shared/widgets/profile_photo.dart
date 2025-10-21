import 'dart:io';

import 'package:flutter/material.dart';

import '../../resources/app_assets.dart';
import '../../resources/app_colors.dart';

class ProfilePhoto extends StatelessWidget {
  final double? photoSize;
  final String? filePath;

  const ProfilePhoto({super.key, this.photoSize, this.filePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.background(context).withValues(alpha: 0.1),
          width: 10,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.background(context).withValues(alpha: 0.4),
            width: 5,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(photoSize ?? 26),
              child: getImage(),
            ),
          ),
        ),
      ),
    );
  }

  Widget getImage() {
    if (filePath is String) {
      if (filePath!.isNotEmpty) {
        if (File(filePath!).existsSync()) {
          return Image.file(File(filePath!), fit: BoxFit.cover);
        }
      }
    }
    return Image.asset(AppAssets.default_pp, fit: BoxFit.cover);
  }
}
