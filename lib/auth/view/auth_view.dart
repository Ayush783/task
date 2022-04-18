import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/home/home.dart';

import '../bloc/auth_bloc.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => AuthBloc(),
          child: const AuthListener(),
        ),
      ),
    );
  }
}

class AuthListener extends StatelessWidget {
  const AuthListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Something went wrong!',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state.isAuthorized) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ),
          );
        }
      },
      child: const AuthViewBody(),
    );
  }
}

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({Key? key}) : super(key: key);

  static final _userName = TextEditingController();
  static final _password = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final showPass = context.select((AuthBloc bloc) => bloc.state.showPassword);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lorem ipsum dolor sit amet',
                  style: GoogleFonts.juliusSansOne(
                      fontSize: 32, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _userName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                  validator: (val) =>
                      val!.isEmpty ? 'Field cannot be left empty' : null,
                  decoration: const InputDecoration(
                    hintText: 'username',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _password,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                  validator: (val) =>
                      val!.isEmpty ? 'Field cannot be left empty' : null,
                  decoration: InputDecoration(
                    hintText: 'password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(ToggleShowPassword());
                      },
                      icon: Icon(
                        showPass
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye_rounded,
                        color: Colors.black,
                      ),
                      constraints: const BoxConstraints(),
                      iconSize: 24,
                    ),
                  ),
                  obscureText: showPass ? false : true,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              if (!state.isLoading) {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        Login(_userName.text, _password.text),
                                      );
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: const Color(0xffFF5470),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                primary:
                                    const Color.fromARGB(255, 255, 45, 80)),
                            child: state.isLoading
                                ? const SizedBox(
                                    height: 17,
                                    width: 17,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    'Login',
                                    style: GoogleFonts.juliusSansOne(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
