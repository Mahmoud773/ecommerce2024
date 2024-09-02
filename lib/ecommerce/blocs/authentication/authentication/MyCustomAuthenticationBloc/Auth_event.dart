
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../utilities/enums.dart';

class AuthEvent extends Equatable{

  @override

  List<Object?> get props => [];

}

class ADDAuth extends AuthEvent{
  final String email;
  final String password;
  var authFormType = AuthFormType.login;

  ADDAuth(this.email, this.password , this.authFormType);

}

class AuthenticationUserChanged extends AuthEvent {
   AuthenticationUserChanged(this.user);


  final User? user;
}