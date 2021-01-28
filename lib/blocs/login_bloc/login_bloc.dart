import 'dart:async';
import 'dart:js';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      
    }
  }
}
