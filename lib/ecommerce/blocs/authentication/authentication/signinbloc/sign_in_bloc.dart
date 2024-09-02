

import 'dart:developer';

import 'package:amazon/ecommerce/blocs/authentication/authentication/signinbloc/sign_in_event.dart';
import 'package:amazon/ecommerce/blocs/authentication/authentication/signinbloc/sign_in_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../services/user_repo.dart';



class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc({
    required UserRepository userRepository
  }) : _userRepository = userRepository,
        super(SignInInitial()) {
   on<SignInRequired>((event, emit) async{
     emit(SignInProcess());
     try{
      await _userRepository.signIn(event.email, event.password);
      emit(SignInSuccess());
     }catch(e){
       log(e.toString());
       emit(const SignInFailure());
     }
   });
   on<SignOutRequired>((event, emit) async{
     await _userRepository.logOut();
   });
  }
}