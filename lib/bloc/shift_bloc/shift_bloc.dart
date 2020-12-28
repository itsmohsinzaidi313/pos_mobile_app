import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pos_mobile_app/models/model_shifts/amount.dart';
import 'package:pos_mobile_app/models/model_shifts/shift.dart';

part 'shift_events.dart';
part 'shift_states.dart';

class ShiftBloc extends Bloc<ShiftEvent, MyShiftState>{

  ShiftBloc(MyShiftState initialState) : super(MyShiftState());

  @override
  void onTransition(Transition<ShiftEvent, MyShiftState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<MyShiftState> mapEventToState(ShiftEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }


}