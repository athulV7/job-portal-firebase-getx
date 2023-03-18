import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResumeOpenPage extends StatelessWidget {
  const ResumeOpenPage({super.key, required this.userCvUrl});

  final String userCvUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfPdfViewer.network(userCvUrl),
      ),
    );
  }
}
