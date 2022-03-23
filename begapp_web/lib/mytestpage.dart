// import 'dart:html';

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:begapp_web/chartTest.dart';
// import 'package:begapp_web/prisoner_dilemma/widgets/graphic.dart';
// import 'package:begapp_web/widgets/hover/translate_on_hover.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:begapp_web/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late List<int> _selectedFile;
  late Uint8List _bytesData;

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
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  Future makeRequest() async {
    var url = Uri.parse("https://v1.begapp.com.br/upload.php");
    // var url = Uri.parse("http://localhost/pdf/teste.php");
    // var url = Uri.parse(
    //     "http://192.168.23.10/upload_api/web/app_dev.php/api/save-file/");

    var request = new http.MultipartRequest("POST", url);

    var file = await http.MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "file_up");

    request.files.add(file);

    request.send().then((response) async {
      // print("test");
      // print(response.statusCode);
      // print(await response.stream.bytesToString());
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: //LineChartSample4()
              // Graphic(
              //     defect: [FlSpot(0, 1), FlSpot(0, 2)],
              //     cooperate: [FlSpot(0, 5), FlSpot(0, 7)],
              //     maxRounds: 10),

              Center(
            child: Column(
              children: [
                TextButton(
                  child: Text("file"),
                  onPressed: () async {
                    startWebFilePicker();
                    // FilePickerResult result =
                    //     await FilePicker.platform.pickFiles();

                    // if (result != null) {
                    //   Uint8List fileBytes = result.files.first.bytes;
                    //   String fileName = result.files.first.name;
                    //   print(fileName);
                    // Upload file
                    // await FirebaseStorage.instance
                    //     .ref('uploads/$fileName')
                    //     .putData(fileBytes);
                    // }
                  },
                ),
                Divider(
                  color: Colors.teal,
                ),
                TextButton(
                  // color: Colors.purple,
                  // elevation: 8.0,
                  // textColor: Colors.white,
                  onPressed: () {
                    makeRequest();
                  },
                  child: Text('Send file to server'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("teste"),
          onPressed: () async {
            var json =
                """[{"id":6,"name":"","username":"yas","email":"yasmin.carolina12@gmail.com","password":"912ec803b2ce49e4a541068d495ab570","userType":"master","code":"146ba2"}]""";
            var d = jsonDecode(json) as List;

            //   String url = "http://localhost:8080/users/login";
            //   // String url = "http://192.168.0.8/print/text";
            //   try {
            //     var res = await http.post(
            //       Uri.encodeFull(url),
            //       headers: {
            //         // "Access-Control-Allow-Origin": "http://localhost:63892",
            //         // "Access-Control-Allow-Credentials": "true",
            //         "Accept": "application/json",
            //         'Content-Type': 'application/json;charset=utf-8'
            //       },
            //       // headers: {"Accept": "application/json"},
            //       body: jsonEncode(
            //           {"username": username.text, "password": password.text}),
            //     );
            //     print(res.statusCode);
            //     print(res.body);
            //   } catch (e) {
            //     print('Error: $e');
            //   }
          },
        ));
  }
}
