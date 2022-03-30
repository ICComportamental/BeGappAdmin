// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:begapp_web/app_localizations.dart';
import 'package:flutter/material.dart';

import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:convert';

class UploadPdf extends StatefulWidget {
  final Function getSelectedFile;

  const UploadPdf({Key? key, required this.getSelectedFile}) : super(key: key);

  @override
  _UploadPdfState createState() => _UploadPdfState();
}

class _UploadPdfState extends State<UploadPdf> {
  late List<int> _selectedFile;

  late Uint8List _bytesData;

  String fileName = "";

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = ".pdf";
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = new html.FileReader();
      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result!);
      });
      reader.readAsDataUrl(file);
      fileName = file.name;
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
      widget.getSelectedFile(_selectedFile);
    });
  }

  // Future makeRequest() async {
  //   var url = Uri.parse("https://v1.begapp.com.br/upload.php");
  //   // var url = Uri.parse("http://localhost/pdf/teste.php");

  //   var request = new http.MultipartRequest("POST", url);

  //   var file = await http.MultipartFile.fromBytes('file', _selectedFile,
  //       contentType: new MediaType('application', 'octet-stream'),
  //       filename: "file_up");

  //   request.files.add(file);

  //   request.send().then((response) async {
  //     // print(response.statusCode);
  //     // print(await response.stream.bytesToString());
  //     if (response.statusCode == 200) print("Uploaded!");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double labelSize = MediaQuery.of(context).size.width * 0.015;

    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.08,
      // margin: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        // border: Border.all(color: Colors.blueGrey) ,
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      child: TextButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (fileName != "") Text(fileName),
            Text(AppLocalizations.of(context).translate('addpdf'),
                style: TextStyle(
                  fontSize: labelSize,
                  color: Colors.black,
                )),
          ],
        ),
        onPressed: () => startWebFilePicker(),
      ),
    );
  }
}
