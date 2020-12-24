import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_mobile_app/bloc/login_bloc/login_events.dart';
import 'package:pos_mobile_app/bloc/login_bloc/login_states.dart';
import 'package:pos_mobile_app/data_provider/login_repo/login_svc.dart';
import 'package:pos_mobile_app/exception/error.dart';
import 'package:pos_mobile_app/models/generic/response_detail.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo loginRepo;
  ResponseDetail loginStatus;
  LoginBloc({this.loginRepo}) : super(LoginInitState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginCredentials) {
      yield LoginProcessing();
      try {
        loginStatus =
            await loginRepo.authenticateUser(credentials: event.credentials);
        if (loginStatus.status) {
          yield LoginSuccessful();
        } else {
          yield LoginFailed();
          yield LoginError(error: LoginException(message: loginStatus.message));
        }
      } catch (e) {
        yield LoginError(error: LoginException(message: e.toString()));
      }
    }
  }
}
