import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:purpleplane_test_app/models/user.dart';
import 'package:purpleplane_test_app/services/shared_prefs.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  SharedPrefs _sharedPref = SharedPrefs();

  User user = User();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInitial();
      user = User.fromJson(await _sharedPref.read('user'));

      if (user.login == event.username &&
          user.password == event.password &&
          event.username != null &&
          event.password != null) {
        yield LoginComplete(user: user);
      } else {
        yield LoginFailure(error: 'Error');
      }
    }
  }
}
