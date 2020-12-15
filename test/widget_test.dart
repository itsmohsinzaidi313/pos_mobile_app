// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

void main() {
  getData();
}

void getData() async {
  try {
    Response response =
        await get('http://192.168.18.250/api/customer/getAllCustomer?key=123');
    List<Map<String, dynamic>> listMap = jsonDecode(response.body) as List<Map<String, dynamic>>;
    log(response.body, name: 'Response');
    listMap.forEach((element) {
      log('${element.keys} : ${element.values}', name: 'Output');
    });
  } catch (e) {
    log('', error: e, name: 'Error');
  }
}
