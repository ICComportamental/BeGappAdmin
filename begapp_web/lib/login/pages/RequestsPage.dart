import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/login/widgets/RequestsTable.dart';
import 'package:begapp_web/login/classes/requestUserAdmin.dart';
import 'package:begapp_web/main.dart';
import 'package:begapp_web/widgets/futureCheckLogin.dart';
import 'package:flutter/material.dart';

class RequestsPage extends StatefulWidget {
  static const routeName = '/NewUserRequests';

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureCheckLogin(
        page: Scaffold(
      body: FutureBuilder(
        future: Database.getRequests(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching data: exp"),
            );
          }
          List snap = snapshot.data;
          List<AdminUserRequest> requests = [];
          for (int index = 0; index < snap.length; index++) {
            requests.add(AdminUserRequest.fromJson(snap[index]));
            // requests.add(AdminUserRequest.fromJson(snap[index]));
            // requests.add(AdminUserRequest.fromJson(snap[index]));
            // requests.add(AdminUserRequest.fromJson(snap[index]));
            // requests.add(AdminUserRequest.fromJson(snap[index]));
            // requests.add(AdminUserRequest.fromJson(snap[index]));
            // requests.add(AdminUserRequest.fromJson(snap[index]));
            // requests.add(AdminUserRequest.fromJson(snap[index]));
            // requests.add(AdminUserRequest.fromJson(snap[index]));
            // requests.add(AdminUserRequest.fromJson(snap[index]));
          }

          if (localStorage.getString("userType") == "master")
            return RequestsTable(
              requests: requests,
            );

          return Center(child: Text("Não autorizado"));
        },
      ),
    ));
  }
}
