import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class PdfScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PdfScreen> {
  final picker = ImagePicker();
  final pdf = pw.Document();
  List<File> _image = [];
  late Uint8List imageFile;

  @override
  Widget build(BuildContext context) {
    // checkPermission();
    return Scaffold(
        appBar: AppBar(
          title: Text("image to pdf"),
          actions: [
            IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: () {
                  createPDF();
                  savePDF();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: getImageFromGallery,
        ),
        body: _image.isNotEmpty
            ? ListView.builder(
                itemCount: _image.length,
                itemBuilder: (context, index) => Container(
                    height: 400,
                    width: double.infinity,
                    margin: EdgeInsets.all(8),
                    child: Image.file(
                      _image[index],
                      fit: BoxFit.cover,
                    )),
              )
            : Center(
                child: Text(
                  "No Image",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ));
  }

  getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      } else {
        print('No image selected');
      }
    });
  }

  createPDF() async {
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  }

  savePDF() async {
    try {
      final dir = await getTemporaryDirectory();
      int seconds = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir.path}/pdf-$seconds.pdf');
      await file.writeAsBytes(await pdf.save());
      showPrintedMessage('success', 'saved to documents ${file.path}');
    } catch (e) {
    }
  }

  showPrintedMessage(String title, String msg) {
    print("Title $title");
    print("msg $msg");
  }
}

void checkPermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.storage,
  ].request();
  print(statuses[Permission.camera]);
}
