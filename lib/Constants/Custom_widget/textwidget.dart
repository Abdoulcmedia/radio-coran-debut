import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class TextWidget {
  static Text regular(
    String text, {
    double? fontSize,
    String? fontFamily,
    Color? color,
    double? letterSpacing,
    TextAlign? textAlign,
    double? height,
    FontWeight? fontWeight,
    bool strike = false,
    int? maxLines,
    bool underline = false,
    TextOverflow? textOverflow,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
      overflow: textOverflow,
      softWrap: true,
      style: TextStyle(
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
        fontFamily: fontFamily,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
      ),
    );
  }
}

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({Key? key, required this.title, required this.onPressed}) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.r, top: 8.r, bottom: 8.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget.regular(title, fontFamily: "Poppins-Bold", textAlign: TextAlign.start),
          TextButton(
            onPressed: onPressed,
            child: TextWidget.regular('seeall'.tr, fontFamily: "Poppins-Medium"),
          ),
        ],
      ),
    );
  }
}
