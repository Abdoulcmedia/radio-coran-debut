import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({super.key,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.hintText,
    this.errorText,
    this.iconData,
    this.labelText,
    this.labelstyle,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.isFirst,
    this.isLast,
    this.style,
    this.textAlign,
    this.suffix,
    this.focusNode,
    this.autofocus,
    this.enable,
    this.hintstylecolor,
    this.borderRadius,
    this.controller
  });

  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final TextStyle? labelstyle;
  final IconData? iconData;
  final bool? obscureText;
  final bool? isFirst;
  final bool? isLast;
  final bool? enable;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? autofocus;
  final FocusNode? focusNode;
  final Widget? suffix;
  final Color? hintstylecolor;
  final double? borderRadius;
  final TextEditingController? controller;

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText ?? "",
          style: labelstyle ?? Get.textTheme.bodyText1,
          textAlign: textAlign ?? TextAlign.start,
        ),
        TextFormField(
          maxLines: keyboardType == TextInputType.multiline ? null : 1,
          keyboardType: keyboardType ?? TextInputType.text,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          onChanged: onChanged,
          controller: controller,enabled: enable,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 0.0.r),borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 0.0.r),borderSide: BorderSide.none),
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 0.0.r),borderSide: BorderSide.none),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 0.0.r),borderSide: BorderSide.none),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText ?? '',
            hintStyle: TextStyle(
              color: hintstylecolor
            ),
          ),
          validator: validator,
          style: style ?? Get.textTheme.bodyText2,
          obscureText: obscureText ?? false,
          textAlign: textAlign ?? TextAlign.start,
          // decoration: Ui.getInputDecoration(
          //   hintText: hintText ?? '',
          //   iconData: iconData,
          //   suffixIcon: suffixIcon,
          //   suffix: suffix,
          //   errorText: errorText,
          // ),
        ),
      ],
    );
  }
}
