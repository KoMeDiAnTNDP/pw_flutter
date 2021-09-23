import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sign_up_bloc.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: _EmailInput(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: _NameInput(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: _PasswordInput(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: _ConfirmedPasswordInput(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: _SignUpButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) => TextField(
        key: const Key('sign_up_form_email_input_text_field'),
        onChanged: (email) => context.read<SignUpBloc>().add(SignUpEmailChanged(email)),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          helperText: 'jsmith@gmail.com',
          errorText: state.email.invalid ? 'Invalid email' : null,
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) => TextField(
        key: const Key('sign_up_form_name_input_text_field'),
        onChanged: (name) => context.read<SignUpBloc>().add(SignUpNameChanged(name)),
        decoration: InputDecoration(
          labelText: 'Name',
          helperText: 'Enter your name',
          errorText: state.name.invalid ? 'Invalid name' : null,
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) => TextField(
        key: const Key('sign_up_form_password_input_text_field'),
        onChanged: (password) => context.read<SignUpBloc>().add(SignUpPasswordChanged(password)),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          helperText: 'Password must be at least 8 characters long',
          errorText: state.password.invalid ? 'Invalid password' : null,
        ),
      ),
    );
  }
}

class _ConfirmedPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) => TextField(
        key: const Key('sign_up_form_confirmed_password_input_text_field'),
        onChanged: (confirmedPassword) =>
            context.read<SignUpBloc>().add(SignUpConfirmedPasswordChanged(confirmedPassword)),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Confirmed Password',
          errorText: state.password.invalid ? 'Invalid confirmed password' : null,
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) => ElevatedButton(
        key: const Key('sign_up_form_button_form'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
          ),
        ),
        onPressed: state.status.isValidated
            ? () => context.read<SignUpBloc>().add(SignUpSubmitted())
            : null,
        child: Text('Sign Up'),
      ),
    );
  }
}
