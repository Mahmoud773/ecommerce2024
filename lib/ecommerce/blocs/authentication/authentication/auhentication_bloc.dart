

import 'dart:async';

import 'package:amazon/ecommerce/services/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository ;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required UserRepository myUserRepository}) :
        userRepository =myUserRepository,  super(const AuthenticationState.unknown()) {

    _userSubscription = userRepository.user.listen((authUser) {
      add(AuthenticationUserChanged(authUser));
    });

    on<AuthenticationUserChanged>((event, emit)
    {
      if(event.user != null) {
        emit(AuthenticationState.authenticated(event.user!));
      }else{
        emit(AuthenticationState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }


}