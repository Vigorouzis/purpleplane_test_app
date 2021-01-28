import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:purpleplane_test_app/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitAuthState extends AuthState {}


class AuthLoading extends AuthState {}


class Authenticated extends AuthState {
  final User user;

  Authenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

