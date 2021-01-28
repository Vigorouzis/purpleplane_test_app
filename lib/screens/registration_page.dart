import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purpleplane_test_app/blocs/auth_bloc/auth.dart';
import 'package:purpleplane_test_app/models/user.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AuthBloc _authBloc;
  User _user = User();
  bool _obscureText = true;

  void saveToSharedPref() async {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(AuthButtonPressed(user: _user));
    Navigator.pushNamed(context, '/login_screen');
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
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is InitAuthState || state is Authenticated) {
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
                    'Sign up',
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
                            autofocus: false,
                            onChanged: (value) {
                              setState(() {
                                _user.login = value;
                              });
                            },
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
                                  obscureText: _obscureText,
                                  onChanged: (value) {
                                    setState(() {
                                      _user.password = value;
                                    });
                                  },
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter your password',
                                    hintStyle: TextStyle(color: Colors.white),
                                    contentPadding: const EdgeInsets.fromLTRB(
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
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Name',
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _user.name = value;
                              });
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () => saveToSharedPref(),
                      child: Text('Sign up'),
                      color: Colors.yellow[900],
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
    ));
  }
}
