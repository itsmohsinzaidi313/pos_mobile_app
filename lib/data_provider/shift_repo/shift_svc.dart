import 'package:flutter/cupertino.dart';
import 'package:pos_mobile_app/models/generic/response_detail.dart';

abstract class ShiftRepo {

  Future<ResponseDetail> shiftOpening({@required String shift, @required String amount});
}

class ShiftService extends ShiftRepo {

  @override
  Future<ResponseDetail> shiftOpening({String shift, String amount}) {
    // TODO: implement shiftOpening
    throw UnimplementedError();
  }

}
