import 'package:cognito_authentication_repository/cognito_authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final authRepo = CognitoAuthenticationRepository();

  AuthCubit() : super(UnknownAuthState());

  void signIn() async {
    try {
      final userId = await authRepo.webSignIn();
      if (userId.isNotEmpty) {
        emit(Authenticated(userId: userId));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void signOut() async {
    try {
      await authRepo.signOut();
      emit(Unauthenticated());
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void attemptAutoSignIn() async {
    try {
      final userId = await authRepo.attemptAutoSignIn();
      if (userId.isNotEmpty) {
        emit(Authenticated(userId: userId));
      } else {
        emit(Unauthenticated());
      }
    } on Exception {
      emit(Unauthenticated());
    }
  }
}
