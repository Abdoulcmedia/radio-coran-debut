import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:shimmer/shimmer.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.imageUrl, this.height, this.width, this.radius,this.memCacheHeight}) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;
  final double? memCacheHeight;


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0.r),
      child: CachedNetworkImage(
          imageUrl: imageUrl,
          memCacheHeight: memCacheHeight?.toInt(),
          height: height,
          width: width,
          fit: BoxFit.cover,
          // imageBuilder: (context, imageProvider) => Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(15.r),
          //         image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          //       ),
          //     ),
          placeholder: (context, url) => Shimmer.fromColors(
              baseColor: shimmerGreen,
              highlightColor: shimmerLightGreen,
              child: Container(
                color: Colors.white,
                height: height,
                width: width,
              )),
          errorWidget: (context, url, error) => Image.network(image, fit: BoxFit.cover)),
    );
  }
}
