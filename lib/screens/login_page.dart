import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purpleplane_test_app/blocs/login_bloc/login.dart';
import 'package:purpleplane_test_app/blocs/login_bloc/login_bloc.dart';
import 'package:purpleplane_test_app/blocs/login_bloc/login_event.dart';
import 'package:purpleplane_test_app/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  String _login;
  String _password;
  bool _obscureText = true;

  void loadFromSharedPrefsAndLogin() async {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc.add(LoginButtonPressed(username: _login, password: _password));
  }

  void seePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              return Flushbar(
                message: 'Login failed',
                duration: Duration(seconds: 3),
              )..show(context);
            }

            if (state is LoginComplete) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            print(state);
            if (state is LoginInitial ||
                state is LoginComplete ||
                state is LoginFailure) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Username',
                              style: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  _login = value;
                                },
                                autofocus: false,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your login',
                                  prefixIcon: Icon(
                                    Icons.login,
                                    color: Colors.white,
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Container(
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    TextFormField(
                                      onChanged: (value) {
                                        _password = value;
                                      },
                                      obscureText: _obscureText,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter your password',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                6, 6, 48, 6),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        seePassword();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () => loadFromSharedPrefsAndLogin(),
                          child: Text('Login'),
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return null;
          }),
        ),
      ),
    );
  }
}
