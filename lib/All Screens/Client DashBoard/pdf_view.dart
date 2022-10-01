import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:pdf_render/pdf_render_widgets.dart';

class FullPdfViewerScreen extends StatefulWidget {
  @override
  State<FullPdfViewerScreen> createState() => _FullPdfViewerScreenState();
}

class _FullPdfViewerScreenState extends State<FullPdfViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            AppRoutes.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
        title: text(
          context,
          'Privacy Policy',
          29.sp,
          color: AppColor.blackColor,
          boldText: FontWeight.w600,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SfPdfViewer.network(
          'file:///D:/workspace1/Car_Parking_App/assets/doc/privacypolicy.pdf',
          key: _pdfViewerKey,
        ),
        // child: PdfViewer.openAsset(
        //   'assets/doc/privacypolicy.pdf',
        //   viewerController: controller,
        //   onError: (err) {
        //     log('Error');
        //   },
        //   params: const PdfViewerParams(
        //     padding: 10,
        //     minScale: 1.0,
        //     scrollDirection: Axis.vertical,
        //   ),
        // ),
      ),
    );
  }
}
