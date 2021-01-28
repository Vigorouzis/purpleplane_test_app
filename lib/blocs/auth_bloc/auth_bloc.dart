import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purpleplane_test_app/services/shared_prefs.dart';
import 'auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    yield AuthLoading();
    if (event is AuthButtonPressed) {
      SharedPrefs _prefs = SharedPrefs();
      event.user.singUpDate = DateTime.now().toString();
      await _prefs.save('user', event.user.toJson());

      print(event.user.login);
      print(event.user.password);
      print(event.user.name);

      yield Authenticated(user: event.user);
    }
  }
}
