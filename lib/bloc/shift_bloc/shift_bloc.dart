import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pos_mobile_app/data_provider/shift_repo/shift_svc.dart';
import 'package:pos_mobile_app/models/model_shifts/amount.dart';
import 'package:pos_mobile_app/models/model_shifts/shift.dart';

part 'shift_events.dart';

part 'shift_states.dart';

class ShiftBloc extends Bloc<ShiftEvent, MyShiftState> {
  final ShiftRepo shiftRepo;
  List<DropdownMenuItem<String>> _list;

  ShiftBloc({@required this.shiftRepo}) : super(MyShiftState());

  @override
  void onTransition(Transition<ShiftEvent, MyShiftState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<MyShiftState> mapEventToState(ShiftEvent event) async* {
    if (event is GettingShifts) {
      try {
        yield state.copyWith(status: Formz.validate([state.shift, state.amount]));
        List<String> _shifts = shiftRepo.gettingShifts();
        yield state.copyWith(
            status: Formz.validate([Shift.dirty(_shifts.first), state.amount]),
            dropDownMenuList: mapListToDropdownMenuItemList(list: _shifts),
            shift: Shift.dirty(_shifts.first).valid
                ? Shift.dirty(_shifts.first)
                : Shift.pure(_shifts.first));
      } catch (e) {
        yield state.copyWith(status: Formz.validate([state.shift, state.amount]),);
        yield ShiftError(error: e.toString());
      }
    } else if (event is ShiftChanged) {
      final shift = Shift.dirty(event.shift);
      yield state.copyWith(
          shift: shift.valid ? shift : Shift.pure(event.shift),
          status: Formz.validate([shift, state.amount]));
    } else if (event is AmountChanged) {
      final amount = Amount.dirty(event.amount);
      yield state.copyWith(
          amount: amount.valid ? amount : Amount.pure(event.amount),
          status: Formz.validate([state.shift, amount]));
    } else if (event is ShiftUnfocused) {
      final shift = Shift.dirty(state.shift.value);
      yield state.copyWith(
          shift: shift, status: Formz.validate([shift, state.amount]));
    } else if (event is AmountUnfocused) {
      final amount = Amount.dirty(state.amount.value);
      yield state.copyWith(
          amount: amount, status: Formz.validate([state.shift, amount]));
    } else if (event is ShiftSubmitted) {
      final shift = Shift.dirty(state.shift.value);
      final amount = Amount.dirty(state.amount.value);
      yield state.copyWith(
          shift: shift,
          amount: amount.valid ? amount : Amount.pure(state.amount.value),
          status: Formz.validate([shift, amount]),
      );

      if(state.status.isValidated){
        try {
          yield state.copyWith(status: FormzStatus.submissionInProgress);
          await Future<void>.delayed(const Duration(seconds: 1), () async{
            print('Dropdown Current Value: ${state.shift.value}');
          });
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } catch (e) {
          yield state.copyWith(status: FormzStatus.submissionFailure);
          yield ShiftError(error: e);
        }
      }
    }
  }

  List<DropdownMenuItem<String>> mapListToDropdownMenuItemList(
      {@required List<String> list}) {
    _list = [];
    list.forEach((element) {
      _list.add(DropdownMenuItem(
        value: element,
        child: Text(element),
      ));
    });
    return _list;
  }
}
