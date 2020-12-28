part of 'shift_bloc.dart';

class MyShiftState extends Equatable{

  final Amount amount;
  final Shift shift;
  final FormzStatus status;

  MyShiftState({
    this.amount = const Amount.pure(),
    this.shift = const Shift.pure(),
    this.status = FormzStatus.pure
  });

  MyShiftState copyWith({ Amount amount, Shift shift, FormzStatus status}) {
    return MyShiftState(
      shift: shift ?? this.shift,
      amount: amount ?? this.amount,
      status: status ?? this.status
    );
  }

  @override
  List<Object> get props => [ shift, amount, status];
}

class ShiftError extends MyShiftState {
  final error;
  ShiftError({this.error});
}