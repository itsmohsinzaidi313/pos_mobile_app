import 'package:flutter/material.dart';


class DashboardScreen extends StatefulWidget {

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(),
            ),
            Text('Shift#: '),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.builder(

      ),
    );
  }
}
