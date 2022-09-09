import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'dart:html'  as html;

class PdfScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PdfScreen> {
  final picker = ImagePicker();
  final pdf = pw.Document();
  List<File> _image = [];
  List<Uint8List> _imageFile = [];

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
                    child: Image.network(
                      _image[index].path,
                      fit: BoxFit.contain,
                    )),
              )
            : Center(
                child: Text("No Image", style: Theme.of(context).textTheme.headline3,),
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
    Uint8List imageFile = (await pickedFile?.readAsBytes())!;
    _imageFile.add(imageFile);
  }

  void saveTextFile(String text, String filename) {
    // html = dart:html.AnchorElement()
    //   ..href = text
    //   ..download = filename
    //   ..style.display = 'none'
    //   ..click();
  }

  createPDF() async {
    for (var img in _imageFile) {
      final image = pw.MemoryImage(img);

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  }

  savePDF() async {
    // Uint8List pdfInBytes = await pdf.save();
    // final blob = html.Blob([pdfInBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // int seconds = DateTime.now().millisecondsSinceEpoch;
    // saveTextFile(url, "a$seconds.pdf");

  }

  showPrintedMessage(String title, String msg) {
    print("Title $title");
    print("msg $msg");
  }
}

