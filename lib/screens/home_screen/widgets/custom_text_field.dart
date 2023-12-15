import 'package:expenses_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.width,
    this.hintText,
    this.controller,
    this.helperText,
    this.keyboardType,
  });

  final double? width;
  final String? hintText;
  final TextEditingController? controller;
  
  final String? helperText;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsetsDirectional.symmetric(
        horizontal: MediaQuery.of(context).size.width * .05,
        vertical:  MediaQuery.of(context).size.height * .015
      ),
      width: width,
      child: TextFormField(
        autocorrect: false,
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide:  BorderSide(color: Colors.blueGrey),
              ),
          hintStyle: style11,
          helperText: helperText,
          helperStyle: style9,
          hintText: hintText,
        ),
      ),
    );
  }
}
