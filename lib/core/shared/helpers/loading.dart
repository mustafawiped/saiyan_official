// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class loadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Container(
              width: 150.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColors.background(context).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: AppColors.primary(context)),
                  SizedBox(height: 10.0),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
