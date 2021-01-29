import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:purpleplane_test_app/models/user.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class InitRegistrationState extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class Registrated extends RegistrationState {
  final User user;

  Registrated({@required this.user});

  @override
  List<Object> get props => [user];
}

class RegistrationFailure extends RegistrationState {}
