part of 'shift_bloc.dart';

class MyShiftState extends Equatable{

  final Amount amount;
  final Shift shift;
  final FormzStatus status;
  final String currentShift;
  final List<DropdownMenuItem<String>> dropDownMenuList;

  MyShiftState({
    this.amount = const Amount.pure(),
    this.shift = const Shift.pure(),
    this.status = FormzStatus.pure,
    this.currentShift = '',
    this.dropDownMenuList = const []
  });

  MyShiftState copyWith({ Amount amount, Shift shift, FormzStatus status,
    String currentShift,
    List<DropdownMenuItem<String>> dropDownMenuList}) {
    return MyShiftState(
      shift: shift ?? this.shift,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      currentShift: currentShift ?? this.currentShift,
      dropDownMenuList: dropDownMenuList ?? this.dropDownMenuList
    );
  }

  @override
  List<Object> get props => [ shift, amount, status, currentShift, dropDownMenuList];
}

class ShiftError extends MyShiftState {
  final error;
  ShiftError({this.error});
}