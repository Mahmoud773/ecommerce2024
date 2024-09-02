

import 'package:amazon/ecommerce/blocs/authentication/authentication/signup_bloc/sign_up_event.dart';
import 'package:amazon/ecommerce/blocs/authentication/authentication/signup_bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/user_repo.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState> {
  final  UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository}): _userRepository=userRepository ,
  super(SignUpInitial()){

    on<SignUpRequired>((event, emit) async{
      emit(SignUpProcess());
      try {
       await _userRepository.signUp(event.myUser, event.password);
       await _userRepository.setUserData(event.myUser);
        emit(SignUpSuccess());
      }catch (e){
        emit(SignUpFailure());
      }
    });
  }
}