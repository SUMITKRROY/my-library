import 'package:flutter/material.dart';

import '../utils/pdf_generate.dart';






class PdfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Export Data to PDF'),
      ),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.picture_as_pdf, size: 50),
          onPressed: () async {
            await generateAndSharePdf();
          },
        ),
      ),
    );
  }
}

