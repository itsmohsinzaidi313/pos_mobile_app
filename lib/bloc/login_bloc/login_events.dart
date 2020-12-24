import 'package:flutter/cupertino.dart';
import 'package:pos_mobile_app/models/generic/credentials.dart';

abstract class LoginEvent {}

class LoginCredentials extends LoginEvent {
  Credentials credentials;
  LoginCredentials({@required credentials}) : assert(credentials != null);
}
