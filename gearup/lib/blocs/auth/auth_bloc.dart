import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearup/blocs/auth/auth_events.dart';
import 'package:gearup/blocs/auth/auth_state.dart';
import 'package:gearup/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthRepository repo;
  AuthBloc(AuthState initialState, this.repo) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async* {
    var pref = await SharedPreferences.getInstance();
    if (event is StartEvent) {
      yield LoginInitState();
    } else if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      var data = await repo.login(event.email, event.password);
      if (data['user.role'] == 'user') {
        pref.setString("token", data['token']);
        pref.setString("user.role", data['user.role']);
        pref.setString("email", data['email']);
        yield UserLoginSuccessState();
      } else if (data['user.role'] == 'admin') {
        pref.setString("token", data['token']);
        pref.setString("user.role", data['user.role']);
        pref.setString("email", data['email']);
        yield AdminLoginSuccessState();
      } else {
        yield LoginErrorState(data.message);
      }
    }
  }
}
