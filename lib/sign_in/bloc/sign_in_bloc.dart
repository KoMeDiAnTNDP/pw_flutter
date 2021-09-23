import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';

import 'package:pw_flutter/helper/models/form_inputs/form_inputs.dart';
import 'package:pw_flutter/repositories/authentication_repository/authentication_repository.dart';

part 'sign_in_state.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required AuthenticationRepository authenticationRepository
  }) : _authenticationRepository = authenticationRepository,
       super(const SignInState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInEmailChanged) {
      yield _emailChanged(event, state);
    } else if (event is SignInPasswordChanged) {
      yield _passwordChanged(event, state);
    } else if (event is SignInSubmitted) {
      yield* _signInSubmitted(event, state);
    }
  }

  SignInState _emailChanged(SignInEmailChanged event, SignInState state) {
    final email = Email.dirty(event.email);

    return state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    );
  }

  SignInState _passwordChanged(SignInPasswordChanged event, SignInState state) {
    final password = Password.dirty(event.password);

    return state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    );
  }

  Stream<SignInState> _signInSubmitted(SignInSubmitted event, SignInState state) async* {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    yield state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        await _authenticationRepository.signIn(email: email.value, password: password.value);

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (err) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
