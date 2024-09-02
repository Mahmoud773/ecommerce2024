

import 'package:amazon/ecommerce/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable{
  const SignUpState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

 class SignUpInitial extends SignUpState {}
class SignUpProcess extends SignUpState {}
class SignUpSuccess extends SignUpState {}
class SignUpFailure extends SignUpState {
}