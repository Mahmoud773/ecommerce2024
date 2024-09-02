

import 'package:amazon/ecommerce/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable{
 const SignUpEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

 class SignUpRequired extends SignUpEvent{
  final MyUser myUser ;
  final String password;

 const  SignUpRequired(this.myUser, this.password);
}