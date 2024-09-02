
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable{
  @override

  List<Object?> get props => [];

}
class AuthStateInitial extends AuthState{}
class AuthStatefailure extends AuthState{}
class AuthStateSuccess extends AuthState{
  final User;

  AuthStateSuccess(this.User);
}
