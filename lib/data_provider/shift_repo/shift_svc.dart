import 'package:flutter/cupertino.dart';
import 'package:pos_mobile_app/models/generic/response_detail.dart';

abstract class ShiftRepo {

  List<String> gettingShifts();
  Future<List<dynamic>> shiftOpening({@required String shift, @required String amount});
}

class ShiftService extends ShiftRepo {

  List<String> _shifts = ['Morning', 'Day', 'Evening'];

  @override
  List<String> gettingShifts() {
    return _shifts;
  }

  @override
  Future<List> shiftOpening({String shift, String amount}) {
    // TODO: implement shiftOpening
    throw UnimplementedError();
  }


}
