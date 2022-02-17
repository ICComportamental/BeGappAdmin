// import 'dart:convert';

// import 'package:begapp_web/experimentsTable.dart';
// import 'package:begapp_web/widgets/customDatatable.dart';
// import 'package:flutter/material.dart';
// import 'package:json_table/json_table.dart';
// import 'package:begapp_web/classes/PG_variables.dart';
// import 'package:begapp_web/classes/database.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BeGapp Web',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       debugShowCheckedModeBanner: false,
//       supportedLocales: [
//         Locale('pt'),
//         Locale('en'),
//       ],
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
    
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//      // backgroundColor: Colors.green,
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: FutureBuilder(
//         future: Database.getExperiments() ,
//         builder: (BuildContext context, AsyncSnapshot snapshot){
//           List snap = snapshot.data;


//           if(snapshot.connectionState == ConnectionState.waiting){
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if(snapshot.hasError){
//             return Center(
//               child: Text("Error fetching data"),
//             );
//           }
//           List<PublicGoodsVariables> experiments = new List();
//           for(int index=0;index<snap.length;index++){
//             experiments.add(PublicGoodsVariables.fromJson(snap[index]));
//             experiments.add(PublicGoodsVariables.fromJson(snap[index]));
//             experiments.add(PublicGoodsVariables.fromJson(snap[index]));
//             // experiments.add(PublicGoodsVariables("teste",15,5,3,5,0,8,"default","jogo padrão",DateTime.parse("2020-01-01"),DateTime.parse("2020-12-01")));
//             // experiments.add(PublicGoodsVariables("teste",15,5,3,5,0,8,"PG658","jogo padrão",DateTime.parse("2020-01-01"),DateTime.parse("2020-12-01")));
//             // experiments.add(PublicGoodsVariables("teste",15,5,3,5,0,8,"PG247","jogo padrão",DateTime.parse("2020-01-01"),DateTime.parse("2020-12-01")));
//             // experiments.add(PublicGoodsVariables("teste",15,5,3,5,0,8,"default","jogo padrão",DateTime.parse("2020-01-01"),DateTime.parse("2020-12-01")));
//           }
//           List<String> cols = ["col1","col2","col3"];
//           TextStyle headerTextStyle =TextStyle(color:Colors.white,fontSize:20);
//           return 
//           Center(
//             child: 
//             Container(//height: 300,
//               padding: EdgeInsets.symmetric(horizontal: 30),//color: Colors.redAccent,
//               child: //Image.asset("moneyPig.png")
//            //   ExperimentsTable(experiments),
//               CustomDataTable(
//                 DataTable(
//                   horizontalMargin: 24,
//                   columnSpacing: 24,
//                    columns: [DataColumn(label: Text("col1",style: headerTextStyle,),),DataColumn(label: Text("col22222",style: headerTextStyle,),),DataColumn(label: Text("col3",style: headerTextStyle,),),], 
//                   rows: [
//                     DataRow(cells: [DataCell(Text("testandooo"),),DataCell(Text("testandooo"),),DataCell(Text("testandooo"),),]),
//                     DataRow(cells: [DataCell(Text("aaaaa")),DataCell(Text("testandooo")),DataCell(Text("testandooo")),]),
//                     DataRow(cells: [DataCell(Text("123456790123456789")),DataCell(Text("testandooo")),DataCell(Text("testandooo"))])
//                   ]
//                 ),
//                 // rowColor1:Colors.grey.shade300,
//                 // headerColor: Colors.purple,
//               )
//             )
//           );
          
          
//           // ListView.builder(
//           //   itemCount: snap.length,
//           //   itemBuilder: (context,index){
//           //     return ListTile(
//           //       title: Text("username: ${snap[index]['name']}"),
//           //       subtitle: Text("email: ${snap[index]['key']}") ,
//           //     );
//           //   },
//           // );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class SimpleTable extends StatefulWidget {
//   @override
//   _SimpleTableState createState() => _SimpleTableState();
// }

// class _SimpleTableState extends State<SimpleTable> {
//   final String jsonSample =
//       '[{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc"},{"name":"Shyam","email":"shyam23@gmail.com",'
//       '"age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India",'
//       '"area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
//       '{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com",'
//       '"age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India",'
//       '"area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
//       '{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,'
//       '"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc",'
//       '"day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"}]';
//   bool toggle = true;

//   @override
//   Widget build(BuildContext context) {
//     var json = jsonDecode(jsonSample);
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Container(
//           child: toggle
//               ? Column(
//                   children: [
//                     JsonTable(
//                       json,
//                       showColumnToggle: true,
//                       allowRowHighlight: true,
//                       rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
//                       paginationRowCount: 4,
//                       onRowSelect: (index, map) {
//                         print(index);
//                         print(map);
//                       },
//                     ),
//                     SizedBox(
//                       height: 40.0,
//                     ),
//                     Text("Simple table which creates table direclty from json")
//                   ],
//                 )
//               : Center(
//                   child: Text(getPrettyJSONString(jsonSample)),
//                 ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.grid_on),
//           onPressed: () {
//             setState(
//               () {
//                 toggle = !toggle;
//               },
//             );
//           }),
//     );
//   }

//   String getPrettyJSONString(jsonObject) {
//     JsonEncoder encoder = new JsonEncoder.withIndent('  ');
//     String jsonString = encoder.convert(json.decode(jsonObject));
//     return jsonString;
//   }
// }