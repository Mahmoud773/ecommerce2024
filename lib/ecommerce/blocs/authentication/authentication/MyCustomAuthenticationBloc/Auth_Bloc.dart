//
//  import 'dart:async';
//
// import 'package:amazon/ecommerce/blocs/authentication/authentication/MyCustomAuthenticationBloc/Auth_event.dart';
// import 'package:amazon/ecommerce/blocs/authentication/authentication/MyCustomAuthenticationBloc/Auth_state.dart';
// import 'package:amazon/ecommerce/services/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../utilities/enums.dart';
//
// class AuthBloc extends Bloc<AuthEvent,AuthState> {
//   final AuthBase authBase ;
//   late final StreamSubscription<User?> _userSubscription;
//
//   AuthBloc({required AuthBase mauthBase}) :
//         authBase =mauthBase,  super( AuthStateInitial()) {
//
//     _userSubscription = authBase.authStateChanges().listen((authUser) {
//       add(AuthenticationUserChanged(authUser));
//     });
//
//     on<ADDAuth>((event, emit)
//                           async {
//                             try {
//                               if (event.authFormType == AuthFormType.login) {
//                                User? user= await
//                                authBase.loginWithEmailAndPassword(event.email, event.password);
//                                 emit AuthStateSuccess(user!);
//                               } else {
//                                 await authBase.signUpWithEmailAndPassword(
//                                     event.email, event.password);
//                               }
//                             } catch (e) {
//                               rethrow;
//                             }
//                           });
//   }
//
//   @override
//   Future<void> close() {
//     _userSubscription.cancel();
//     return super.close();
//   }
//
//
// }