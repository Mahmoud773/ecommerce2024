

import 'dart:developer';

import 'package:amazon/ecommerce/models/my_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/user_repo.dart';
import 'my_user_event.dart';
import 'my_user_state.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
  final UserRepository _userRepository;
  MyUserBloc({required UserRepository userRepository}) : _userRepository=userRepository ,
    super(const MyUserState.loading()) {
    on<GetMyUser>((event, emit) async{
      
      try{
         MyUser myUser = await _userRepository.getMyUser(event.myUserId);
         emit( MyUserState.success(myUser!));
      }catch (e) {
        log(e.toString());
        emit(const MyUserState.failure());
      }
    });
  }


}