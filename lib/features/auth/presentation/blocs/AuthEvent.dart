// Events
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInWithEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailPasswordEvent(this.email, this.password);
}

class SignInWithGoogleEvent extends AuthEvent {}

class SignInAnonymouslyEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class GetCurrentUserEvent extends AuthEvent {}