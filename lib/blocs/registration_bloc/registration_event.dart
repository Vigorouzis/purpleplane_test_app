import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:purpleplane_test_app/models/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthButtonPressed extends AuthEvent {
  final User user;

  AuthButtonPressed({@required this.user});

  @override
  List<Object> get props => [user];
}

class BackButtonPressed extends AuthEvent {}
