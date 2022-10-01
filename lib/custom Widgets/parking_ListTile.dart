import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/dynamic_size.dart';

// Widget ParkingListTile(context, holeData, Widget icon) {
//   return Container(
//     width: dynamicWidth(context, 0.9),
//     margin: EdgeInsets.symmetric(
//       vertical: dynamicHeight(context, 0.006),
//       // horizontal: 5,
//     ),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10.r),
//       color: AppColor.greyColor,
//     ),
//     padding: EdgeInsets.all(15.h),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           height: 80.h,
//           width: 80.w,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 // image: AssetImage(AppImages.parkingParking),
//                 image: NetworkImage(holeData['parkingImg']),
//                 fit: BoxFit.cover),
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//         ),
//         SizedBox(
//           width: 20.h,
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               // color: Colors.amber,
//               width: dynamicWidth(context, 0.5),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   text(
//                     context,
//                     // 'Allington Paddock',
//                     holeData['parkingName'].toString(),
//                     20.sp,
//                     boldText: FontWeight.w600,
//                     color: AppColor.blackColor,
//                   ),
//                   icon,
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 5.h,
//             ),
//             // ReadMoreText(
//             //         holeData['description'],
//             //         trimLines: 1,
//             //         colorClickableText: Colors.pink,
//             //         trimMode: TrimMode.Line,
//             //         trimCollapsedText: 'Show more',
//             //         trimExpandedText: ' Show less',
//             //         moreStyle: TextStyle(
//             //           fontSize: 14,
//             //           fontWeight: FontWeight.bold,
//             //           color: AppColor.darkGreyColor,
//             //         ),
//             //       ),
//             text(
//               context,
//               holeData['description'].length > 5
//                   ? holeData['description'].substring(0, 5) + '...'
//                   : holeData['description'],
//               // holeData['description'].toString(),
//               20.sp,
//               boldText: FontWeight.w600,
//               color: AppColor.darkGreyColor,
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 text(context, '\$${holeData['parkingPrice'].toString()}', 16.sp,
//                     boldText: FontWeight.w700, color: AppColor.primaryColor),
//                 text(
//                   context,
//                   '/ 2 hours',
//                   12.sp,
//                   boldText: FontWeight.w700,
//                   color: AppColor.darkGreyColor,
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 text(
//                   context,
//                   holeData['bookedStatus'],
//                   17.sp,
//                   boldText: FontWeight.w700,
//                   color: AppColor.greenColor,
//                 ),
//               ],
//             )
//           ],
//         )
//       ],
//     ),
//   );
// }

Widget ParkingListTile(context, holeData, Widget icon) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: AppColor.lightGreybg,
    ),
    margin: EdgeInsets.only(bottom: 5.h),
    padding: EdgeInsets.symmetric(
      horizontal: 10.w,
      vertical: 5.h,
    ),
    child: Row(
      children: [
        Container(
          height: 80.h,
          width: 80.w,
          decoration: BoxDecoration(
            image: DecorationImage(
                // image: AssetImage(AppImages.parkingParking),
                image: NetworkImage(holeData['parkingImg']),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        SizedBox(
          width: 20.h,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.amber,
              width: dynamicWidth(context, 0.57),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(
                    context,
                    // 'Allington Paddock',
                    holeData['parkingName'].toString(),
                    20.sp,
                    boldText: FontWeight.w600,
                    color: AppColor.blackColor,
                  ),
                  icon,
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            // ReadMoreText(
            //         holeData['description'],
            //         trimLines: 1,
            //         colorClickableText: Colors.pink,
            //         trimMode: TrimMode.Line,
            //         trimCollapsedText: 'Show more',
            //         trimExpandedText: ' Show less',
            //         moreStyle: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.bold,
            //           color: AppColor.darkGreyColor,
            //         ),
            //       ),
            Container(
              // color: Colors.amber,
              width: dynamicWidth(context, 0.5),
              child: text(
                  context,
                  holeData['description'],
                  // holeData['description'].toString(),
                  15.sp,
                  boldText: FontWeight.w600,
                  color: AppColor.darkGreyColor,
                  maxLines: 1),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              // color: Colors.amber,
              width: dynamicWidth(context, 0.57),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      text(context, '\$${holeData['parkingPrice'].toString()}',
                          16.sp,
                          boldText: FontWeight.w700,
                          color: AppColor.primaryColor),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: dynamicWidth(context, 0.03),
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 1,
                        )),
                    child: text(
                      context,
                      holeData['parkingType'],
                      15.sp,
                      boldText: FontWeight.w500,
                      color: AppColor.greenColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget bookmarkListTile(context, holeData, Widget icon) {
  return Container(
    height: dynamicHeight(context, 0.13),
    width: dynamicWidth(context, 0.9),
    margin: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, 0.006),
      // horizontal: 5,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: AppColor.lightGreybg,
    ),
    padding: EdgeInsets.all(10.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 70.h,
          width: 70.w,
          decoration: BoxDecoration(
            // color: Colors.amber,
            image: DecorationImage(
                // image: AssetImage(AppImages.parkingParking),
                image: NetworkImage(holeData['parkingImg']),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        SizedBox(
          width: 20.h,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: dynamicWidth(context, 0.57),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // color: Colors.amber,
                    width: dynamicWidth(context, 0.5),
                    child: text(
                      context,
                      // 'Allington kfas;ads f a;dock',
                      holeData['parkingName'].toString(),
                      20.sp,
                      boldText: FontWeight.w600,
                      color: AppColor.blackColor,
                      maxLines: 1,
                    ),
                  ),
                  icon,
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            // ReadMoreText(
            //         holeData['description'],
            //         trimLines: 1,
            //         colorClickableText: Colors.pink,
            //         trimMode: TrimMode.Line,
            //         trimCollapsedText: 'Show more',
            //         trimExpandedText: ' Show less',
            //         moreStyle: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.bold,
            //           color: AppColor.darkGreyColor,
            //         ),
            //       ),
            Container(
              width: dynamicWidth(context, 0.57),
              height: dynamicHeight(context, 0.05),
              // color: Colors.amber,
              child: text(
                context,
                holeData['description'],
                // holeData['description'].toString(),
                15.sp,
                boldText: FontWeight.w600,
                color: AppColor.darkGreyColor,
                maxLines: 2,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        )
      ],
    ),
  );
}

Widget parkingTileCommon(context, holeData) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: AppColor.lightGreybg,
    ),
    margin: EdgeInsets.only(bottom: 5.h),
    padding: EdgeInsets.symmetric(
      horizontal: 10.w,
      vertical: 5.h,
    ),
    child: Row(
      children: [
        Container(
          height: 80.h,
          width: 80.w,
          decoration: BoxDecoration(
            image: DecorationImage(
                // image: AssetImage(AppImages.parkingParking),
                image: NetworkImage(holeData['parkingImg']),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        SizedBox(
          width: 20.h,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.amber,
              width: dynamicWidth(context, 0.55),
              child: text(
                context,
                // 'Allington Paddock',
                holeData['parkingName'].toString(),
                20.sp,
                boldText: FontWeight.w600,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            // ReadMoreText(
            //         holeData['description'],
            //         trimLines: 1,
            //         colorClickableText: Colors.pink,
            //         trimMode: TrimMode.Line,
            //         trimCollapsedText: 'Show more',
            //         trimExpandedText: ' Show less',
            //         moreStyle: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.bold,
            //           color: AppColor.darkGreyColor,
            //         ),
            //       ),
            Container(
              // color: Colors.amber,
              width: dynamicWidth(context, 0.55),
              child: text(
                  context,
                  holeData['description'],
                  // holeData['description'].toString(),
                  15.sp,
                  boldText: FontWeight.w600,
                  color: AppColor.darkGreyColor,
                  maxLines: 1),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: dynamicWidth(context, 0.55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      text(context, '\$${holeData['parkingPrice'].toString()}',
                          16.sp,
                          boldText: FontWeight.w700,
                          color: AppColor.primaryColor),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: dynamicWidth(context, 0.03),
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 1,
                        )),
                    child: text(
                      context,
                      holeData['parkingType'],
                      15.sp,
                      boldText: FontWeight.w500,
                      color: AppColor.greenColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
