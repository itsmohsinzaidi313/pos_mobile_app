import 'package:flutter/cupertino.dart';
import 'package:pos_mobile_app/models/generic/credentials.dart';
import 'package:pos_mobile_app/models/generic/response_detail.dart';

abstract class LoginRepo {
  Future<ResponseDetail> authenticateUser({@required String username, String password});
}

class LoginService extends LoginRepo {

  @override
  Future<ResponseDetail> authenticateUser({String username, String password}) {
    // TODO: implement authenticateUser
    throw UnimplementedError();
  }

}
