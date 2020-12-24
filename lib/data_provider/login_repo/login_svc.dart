import 'package:flutter/cupertino.dart';
import 'package:pos_mobile_app/models/generic/credentials.dart';
import 'package:pos_mobile_app/models/generic/response_detail.dart';

abstract class LoginRepo {
  Future<ResponseDetail> authenticateUser({@required Credentials credentials});
}

class LoginService extends LoginRepo {
  @override
  Future<ResponseDetail> authenticateUser({Credentials credentials}) async {
    //TODO: Server hitting code here
    return ResponseDetail(status: true, message: '');
  }
}
