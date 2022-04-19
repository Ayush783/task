import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/home/models/user.dart';

import '../../home/home.dart';

class ManageView extends StatelessWidget {
  const ManageView({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            user == null ? 'Add user' : 'Edit User',
            style: GoogleFonts.juliusSansOne(fontSize: 20),
          ),
          backgroundColor: const Color(0xffFF5470),
        ),
        body:
            user != null ? ManageViewBody(user: user) : const ManageViewBody(),
      ),
    );
  }
}

class ManageViewBody extends StatefulWidget {
  const ManageViewBody({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  State<ManageViewBody> createState() => _ManageViewBodyState();
}

class _ManageViewBodyState extends State<ManageViewBody> {
  final _formKey = GlobalKey<FormState>();

  final _username = TextEditingController();

  final _userid = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _username.text = widget.user!.username!;
      _userid.text = widget.user!.userId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _username,
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
                  controller: _userid,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                  validator: (val) =>
                      val!.isEmpty ? 'Field cannot be left empty' : null,
                  decoration: const InputDecoration(
                    hintText: 'User id',
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              if (!state.isAdding) {
                                if (_formKey.currentState!.validate()) {
                                  if (widget.user != null) {
                                    context.read<HomeBloc>().add(
                                          EditUser(
                                            widget.user!,
                                            User(_username.text, _userid.text),
                                          ),
                                        );
                                  } else {
                                    context.read<HomeBloc>().add(
                                          AddUser(
                                            User(_username.text, _userid.text),
                                          ),
                                        );
                                  }
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
                            child: state.isAdding
                                ? const SizedBox(
                                    height: 17,
                                    width: 17,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    widget.user != null ? 'Edit' : 'Add',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
