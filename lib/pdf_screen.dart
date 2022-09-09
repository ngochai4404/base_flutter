// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:permission_handler/permission_handler.dart';
//
// import 'dart:html' as html;
//
// class PdfScreen extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<PdfScreen> {
//   final picker = ImagePicker();
//   final pdf = pw.Document();
//   List<File> _image = [];
//   late Uint8List imageFile;
//
//   @override
//   Widget build(BuildContext context) {
//     // checkPermission();
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text("image to pdf"),
//             actions: [
//               IconButton(
//                   icon: Icon(Icons.picture_as_pdf),
//                   onPressed: () {
//                     createPDF();
//                     savePDF();
//                   })
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.add),
//             onPressed: getImageFromGallery,
//           ),
//           body: _image.isNotEmpty
//               ? ListView.builder(
//                   itemCount: _image.length,
//                   itemBuilder: (context, index) => Container(
//                       height: 400,
//                       width: double.infinity,
//                       margin: EdgeInsets.all(8),
//                       child: Image.network(
//                         _image[index].path,
//                         fit: BoxFit.cover,
//                       )),
//                 )
//               : Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.red
//                 ),
//             child: Text("123"),
//           )),
//     );
//   }
//
//   getImageFromGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image.add(File(pickedFile.path));
//       } else {
//         print('No image selected');
//       }
//     });
//     imageFile = (await pickedFile?.readAsBytes())!;
//   }
//
//   void saveTextFile(String text, String filename) {
//     html.AnchorElement()
//       ..href = text
//       ..download = filename
//       ..style.display = 'none'
//       ..click();
//   }
//
//   createPDF() async {
//     for (var img in _image) {
//       final image = pw.MemoryImage(imageFile);
//
//       pdf.addPage(pw.Page(
//           pageFormat: PdfPageFormat.a4,
//           build: (pw.Context contex) {
//             return pw.Center(child: pw.Image(image));
//           }));
//     }
//   }
//
//   savePDF() async {
//     Uint8List pdfInBytes = await pdf.save();
//     final blob = html.Blob([pdfInBytes], 'application/pdf');
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     saveTextFile(url, "a.pdf");
//
//     // try {
//     //   // final directory = await getTemporaryDirectory();
//     //
//     //   final dir = _image[0].path;
//     //   // final dir = directory.path;
//     //   final file = File('$dir/filename4.txt');
//     //   print("start save PDF ${file.path}");
//     //   //await file.writeAsString("123");
//     //   print((await pdf.save()).toString());
//     //   // await pdf.save();
//     //   print('success'+ 'saved to documents ${file.path}');
//     // } catch (e) {
//     //   print('error'+ e.toString());
//     // }
//   }
//
//   showPrintedMessage(String title, String msg) {
//     // Flushbar(
//     //   title: title,
//     //   message: msg,
//     //   duration: Duration(seconds: 3),
//     //   icon: Icon(
//     //     Icons.info,
//     //     color: Colors.blue,
//     //   ),
//     // )..show(context);
//     print("Title $title");
//     print("msg $msg");
//   }
// }
//
// void checkPermission() async {
//   Map<Permission, PermissionStatus> statuses = await [
//     Permission.camera,
//     Permission.storage,
//   ].request();
//   print(statuses[Permission.camera]);
// }
