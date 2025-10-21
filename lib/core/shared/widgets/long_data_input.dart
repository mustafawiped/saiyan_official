// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:saiyan_official/utils/extensions.dart';
import 'package:suffadaemon/utils/utils.dart';

import '../../resources/app_colors.dart';

class longDataInput extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const longDataInput({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<longDataInput> createState() => _longDataInputState();
}

class _longDataInputState extends State<longDataInput> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: AppColors.surfaceLight(context),
        fontWeight: FontWeight.bold,
        fontSize: SuffaSizes.mediumTextSize,
      ).textFont,
      maxLength: 500,
      minLines: 2,
      maxLines: 4,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 15),
        filled: true,
        fillColor: AppColors.grayOpen(context),
        hintStyle: TextStyle(
          color: AppColors.surfaceLight(context),
          fontWeight: FontWeight.bold,
          fontSize: SuffaSizes.mediumTextSize,
        ).textFont,
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        counterText: "",
      ),
      controller: widget.controller,
    );
  }
}
