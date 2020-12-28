part of 'shift_bloc.dart';

abstract class ShiftEvent extends Equatable{

  const ShiftEvent();

  @override
  List<Object> get props => [];
}

class GettingShifts extends ShiftEvent{

  final List<String> shifts;

  GettingShifts({ this.shifts });

  @override
  List<Object> get props => [shifts];
}

class ShiftChanged extends ShiftEvent{

  final String shift;

  ShiftChanged({ @required this.shift});

  @override
  List<Object> get props => [shift];
}

class AmountChanged extends ShiftEvent{

  final String amount;

  AmountChanged({ @required this.amount});

  @override
  List<Object> get props => [amount];
}

class ShiftUnfocused extends ShiftEvent{}

class AmountUnfocused extends ShiftEvent{}

class FormSubmitted extends ShiftEvent{}