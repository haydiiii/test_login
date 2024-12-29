import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_login/domain/share/notifications.dart';
import 'package:test_login/presentation/bloc/app_cubit.dart';
import 'package:test_login/presentation/bloc/app_states.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocListener<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showLoadingDialog(context);
          } else if (state is LoginSuccessState) {
            Navigator.of(context).pop(); 
            showSuccessDialog(context, "Login successful!");
          } else if (state is LoginErrorState) {
            Navigator.of(context).pop();
            showErrorDialog(context, state.error);
          }
        },
        child: const Scaffold(
          body: SafeArea(child: LoginBody()),
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final username = usernameController.text.trim();
              final password = passwordController.text.trim();
              context.read<AppCubit>().login(username, password);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}