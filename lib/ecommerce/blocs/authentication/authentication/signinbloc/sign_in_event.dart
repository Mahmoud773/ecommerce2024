
import 'package:equatable/equatable.dart';

class SignInEvent extends Equatable{
  SignInEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class SignInRequired extends  SignInEvent{
  final String email ;
  final String password;

  SignInRequired(this.email, this.password);
}

class SignOutRequired extends  SignInEvent{


  SignOutRequired();
}