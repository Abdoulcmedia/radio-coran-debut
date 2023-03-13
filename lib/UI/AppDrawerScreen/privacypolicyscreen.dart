import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../generated/l10n.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final String? data;

  const PrivacyPolicyScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget.regular('privacypolicy'.tr, fontFamily: "Poppins-Bold", fontSize: 20.sp),
      ),
      body: SingleChildScrollView(
        child: Html(
          data: data,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
