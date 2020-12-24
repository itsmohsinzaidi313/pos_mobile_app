import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {}

class LoginProcessing extends LoginState {}

class LoginSuccessful extends LoginState {}

class LoginFailed extends LoginState {}

class LoginError extends LoginState {
  final error;
  LoginError({this.error});
}
