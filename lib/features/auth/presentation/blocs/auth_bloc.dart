import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:researchfirebase/core/usecases/usecase.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_in_anonymously.dart';
import '../../domain/usecases/sign_in_with_email_password.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import 'AuthEvent.dart';
import 'AuthState.dart';

// Bloc
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailPassword signInWithEmailPassword;
  final SignInWithGoogle signInWithGoogle;
  final SignInAnonymously signInAnonymously;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.signInWithEmailPassword,
    required this.signInWithGoogle,
    required this.signInAnonymously,
    required this.signOut,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    on<SignInWithEmailPasswordEvent>(_onSignInWithEmailPassword);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignInAnonymouslyEvent>(_onSignInAnonymously);
    on<SignOutEvent>(_onSignOut);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
  }

  void _onSignInWithEmailPassword(
      SignInWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signInWithEmailPassword(
      SignInParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(Authenticated(user!)),
    );
  }

  void _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signInWithGoogle(NoParams());
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(Authenticated(user!)),
    );
  }

  void _onSignInAnonymously(
      SignInAnonymouslyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signInAnonymously(NoParams());
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(Authenticated(user!)),
    );
  }

  void _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await signOut(NoParams());
    emit(Unauthenticated());
  }

  void _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    final result = await getCurrentUser(NoParams());
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(Authenticated(user!)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
