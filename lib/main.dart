import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purpleplane_test_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:purpleplane_test_app/blocs/login_bloc/login_bloc.dart';
import 'package:purpleplane_test_app/screens/login_page.dart';
import 'package:purpleplane_test_app/screens/main_screen.dart';
import 'package:purpleplane_test_app/screens/registration_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/singUp_screen',
        routes: {
          '/singUp_screen': (context) => RegistrationScreen(),
          '/login_screen': (context) => LoginScreen(),
          '/main_screen': (context) => MainScreen()
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
