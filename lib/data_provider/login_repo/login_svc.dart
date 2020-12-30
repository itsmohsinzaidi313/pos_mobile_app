import 'package:flutter/cupertino.dart';
import 'package:pos_mobile_app/models/generic/response_detail.dart';

abstract class LoginRepo {
  Future<ResponseDetail> authenticateUser({@required String username, String password});
}

class LoginService extends LoginRepo {

  @override
  Future<ResponseDetail> authenticateUser({String username, String password}) async{
    ResponseDetail _response;
    Future.delayed(Duration(seconds: 1), (){
      _response = ResponseDetail(status: true, message: 'Message');
    });
    return _response;
  }

}
