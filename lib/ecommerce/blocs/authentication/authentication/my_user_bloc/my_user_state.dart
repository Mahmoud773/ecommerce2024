
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../models/my_user.dart';

enum MyUserStatus { success, loading, failure }

class MyUserState extends Equatable {
  final MyUserStatus status;
  final MyUser? user;

 const MyUserState._({
    this.user ,
    this.status =MyUserStatus.loading,
});
  const MyUserState.loading() : this._();

  const MyUserState.success(MyUser user) : this._(status: MyUserStatus.success, user: user);

  const MyUserState.failure() : this._(status: MyUserStatus.failure);

  @override
  List<Object?> get props => [status, user];

}