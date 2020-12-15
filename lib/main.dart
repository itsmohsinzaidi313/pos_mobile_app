import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(new MaterialApp(
    title: 'POS',
    initialRoute: '',
    routes: {
      '': (context) => Text(''),
    },
  ));
  getData();
}

void getData() async {
  Response response =
      await get('http://192.168.18.250/api/customer/getAllCustomer?key=123');
  print(response.body);
}
