import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';

import 'package:pw_flutter/helper/models/form_inputs/form_inputs.dart';
import 'package:pw_flutter/repositories/authentication_repository/authentication_repository.dart';

part 'sign_up_state.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthenticationRepository authenticationRepository
  }) : _authenticationRepository = authenticationRepository,
       super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpEmailChanged) {
      yield _mapSignUpEmailChanged(event, state);
    } else if (event is SignUpNameChanged) {
      yield _mapSignUpNameChanged(event, state);
    } else if (event is SignUpPasswordChanged) {
      yield _mapSignUpPasswordChanged(event, state);
    } else if (event is SignUpConfirmedPasswordChanged) {
      yield _mapSignUpConfirmedPasswordChanged(event, state);
    } else if (event is SignUpSubmitted) {
      yield* _mapSignUpSubmitted(event, state);
    }
  }

  SignUpState _mapSignUpEmailChanged(SignUpEmailChanged event, SignUpState state) {
    final email = Email.dirty(event.email);

    return state.copyWith(
      email: email,
      status: Formz.validate([email, state.name, state.password, state.confirmedPassword]),
    );
  }

  SignUpState _mapSignUpNameChanged(SignUpNameChanged event, SignUpState state) {
    final name = Name.dirty(event.name);

    return state.copyWith(
      name: name,
      status: Formz.validate([state.email, name, state.password, state.confirmedPassword]),
    );
  }

  SignUpState _mapSignUpPasswordChanged(SignUpPasswordChanged event, SignUpState state) {
    final password = Password.dirty(event.password);
    ConfirmedPassword confirmedPassword;

    if (state.confirmedPassword.pure) {
      confirmedPassword = ConfirmedPassword.pure(password: event.password);
    } else {
      confirmedPassword = ConfirmedPassword.dirty(
        password: event.password,
        value: state.confirmedPassword.value,
      );
    }

    return state.copyWith(
      password: password,
      status: Formz.validate(
        [state.email, state.name, password, confirmedPassword],
      ),
    );
  }

  SignUpState _mapSignUpConfirmedPasswordChanged(
    SignUpConfirmedPasswordChanged event,
    SignUpState state
  ) {
    final confirmedPassword = ConfirmedPassword.dirty(password: state.password.value, value: event.confirmedPassword);

    return state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([state.email, state.name, state.password, confirmedPassword]),
    );
  }

  Stream<SignUpState> _mapSignUpSubmitted(SignUpSubmitted event, SignUpState state) async* {
    final email = Email.dirty(state.email.value);
    final name = Name.dirty(state.name.value);
    final password = Password.dirty(state.password.value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: state.confirmedPassword.value
    );

    yield state.copyWith(
      email: email,
      name: name,
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([email, name, password, confirmedPassword]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        await _authenticationRepository.signUp(
          email: email.value,
          name: name.value,
          password: password.value
        );

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (err) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
