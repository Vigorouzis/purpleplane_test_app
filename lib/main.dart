import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purpleplane_test_app/blocs/registration_bloc/registration_bloc.dart';
import 'package:purpleplane_test_app/blocs/login_bloc/login_bloc.dart';
import 'package:purpleplane_test_app/screens/main_screen.dart';
import 'package:purpleplane_test_app/screens/registration_page.dart';
import 'package:purpleplane_test_app/services/api_provider.dart';
import 'package:purpleplane_test_app/services/shared_prefs.dart';

import 'blocs/main_bloc/main.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiProvider _provider = ApiProvider();

  SharedPrefs _sharedPref = SharedPrefs();

  User user = User();
  bool isLogin = false;

  Future getUser() async {
    try {
      user = User.fromJson(await _sharedPref.read('user'));
      isLogin = true;
    } catch (_) {
      isLogin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegistrationBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => MainBloc(this._provider),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (isLogin == false) {
              return RegistrationScreen();
            } else {
              return MainScreen();
            }
          },
        ),
      ),
    );
  }
}
