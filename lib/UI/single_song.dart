import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/Custom_widget/cachednetworkimage.dart';
import 'package:musicplayer/Constants/Custom_widget/textwidget.dart';

class singleSongScreen extends StatefulWidget {
  final String? id;

  const singleSongScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<singleSongScreen> createState() => _singleSongScreenState();
}

class _singleSongScreenState extends State<singleSongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.red,
              child: Padding(
                padding:  EdgeInsets.only(bottom: 300.0.w),
                child: ImageView(imageUrl: "https://source.unsplash.com/random?sig=1", height: 450.w, width: MediaQuery.of(context).size.width, memCacheHeight: 600, radius: 0.0),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                ],
              )/*.createShader(Rect.fromLTRB(0, 0, 0, 1000)*/),

        ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget.regular("Hello Title",fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.white),
            ],
          )

        ],
      ),

    );
  }
}
