import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:pw_flutter/sign_in/bloc/sign_in_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
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
                child: _PasswordInput(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: _SignInButton(),
              )
            ],
          ),
        )
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('sign_in_form_email_input_text_field'),
          onChanged: (email) => context.read<SignInBloc>().add(SignInEmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Theme.of(context).colorScheme.secondary,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: 'jsmith@gmail.com',
            errorText: state.email.invalid ? 'Invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('sign_in_form_password_input_text_field'),
          onChanged: (password) => context.read<SignInBloc>().add(SignInPasswordChanged(password)),
          obscureText: true,
          cursorColor: Theme.of(context).colorScheme.secondary,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: 'Password must be at least 8 characters long',
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('sign_in_form_button_form'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
            ),
          ),
          onPressed: state.status.isValidated
            ? () => context.read<SignInBloc>().add(SignInSubmitted())
            : null,
          child: Text('Sign In'),
        );
      },
    );
  }
}
