import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:purpleplane_test_app/models/user.dart';
import 'package:purpleplane_test_app/services/shared_prefs.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User _user = User();

  var _loginController = TextEditingController();
  var _passwordController = TextEditingController();

  SharedPrefs _sharedPref = SharedPrefs();
  bool _obscureText = true;

  void loadFromSharedPrefsAndLogin() async {
    try {
      _user = User.fromJson(await _sharedPref.read('user'));
      if (_user.login == _loginController.text &&
          _user.password == _passwordController.text) {
        Navigator.pushNamed(context, '/main_screen');
      } else {
        Flushbar(
          message: 'Login failed',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } catch (Excepetion) {
      throw Exception();
    }
  }

   void seePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _loginController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: Container(
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      controller: _loginController,
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
                            controller: _passwordController,
                            obscureText: _obscureText,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.white),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(6, 6, 48, 6),
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
        ),
      ),
    );
  }
}
