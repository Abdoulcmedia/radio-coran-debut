// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:musicplayer/service/httpservice.dart';
// import '../../Controller/songplayer_controller.dart';
// import '../../Controller/user_controller.dart';
//
// class FavouriteButtonWidget extends StatelessWidget {
//   String? postid;
//
//   FavouriteButtonWidget({
//     super.key,
//     this.postid,
//   });
//
//   final SongPlayerController songPlayerController = Get.put(SongPlayerController());
//   final UserController userController = Get.put(UserController());
//
//   // getfavourite() async {
//   //   await HttpService()
//   //       .getSongs(
//   //     songId: postid,
//   //     userId: userController.userId,
//   //   )
//   //       .then((value) {
//   //     favourite = value.onlineMp3[0].isFavorite;
//   //     songPlayerController.isLike.value = favourite!;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     // songPlayerController.getfavourite(postid: postid);
//     return Obx(() {
//       songPlayerController.isLike.value;
//       return IconButton(
//         onPressed: () async {
//           await songPlayerController.favouriteBookController(postid: postid, userid: userController.userId).then((val) async {
//             val.onlineMp3[0].success == "1" ? songPlayerController.isLike.value = true : songPlayerController.isLike.value = false;
//             await songPlayerController.getfavouriteBookController(userid: userController.userId);
//           }).whenComplete(() => songPlayerController.update());
//           songPlayerController.getfavourite(postid: postid);
//
//         },
//         icon: songPlayerController.isLike.value == true
//             ? Icon(
//                 Icons.favorite_outlined,
//                 color: Get.theme.colorScheme.primaryContainer,
//               )
//             : Icon(
//                 Icons.favorite_border_rounded,
//                 color: Get.theme.colorScheme.primary,
//               ),
//       );
//     });
//   }
// }
