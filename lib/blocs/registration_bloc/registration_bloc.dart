import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purpleplane_test_app/services/shared_prefs.dart';
import 'registration.dart';

class RegistrationBloc extends Bloc<AuthEvent, RegistrationState> {
  RegistrationBloc() : super(InitRegistrationState());

  @override
  Stream<RegistrationState> mapEventToState(AuthEvent event) async* {
    yield RegistrationLoading();
    if (event is AuthButtonPressed) {
      SharedPrefs _prefs = SharedPrefs();
      event.user.singUpDate = DateTime.now().toString();
      if (event.user.login != null && event.user.password != null) {
        await _prefs.save('user', event.user.toJson());

        yield InitRegistrationState();
      } else {
        yield RegistrationFailure();
      }
    }
  }
}
