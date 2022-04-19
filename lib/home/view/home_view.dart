import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/manage_users/manage_users.dart';
import 'package:task/profile/profile.dart';

import '../bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Current Users',
            style: GoogleFonts.juliusSansOne(fontSize: 20),
          ),
          backgroundColor: const Color(0xffFF5470),
        ),
        body: const HomeViewListener(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageView(),
                ));
          },
          backgroundColor: const Color(0xffFF5470),
          child: const Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HomeViewListener extends StatefulWidget {
  const HomeViewListener({Key? key}) : super(key: key);

  @override
  State<HomeViewListener> createState() => _HomeViewListenerState();
}

class _HomeViewListenerState extends State<HomeViewListener> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadUsers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.isAdded) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User added successfuly!',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.isDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User deleted!',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: const HomeViewBody(),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xffFF5470),
            ),
          );
        } else {
          if (state.hasError) {
            return Center(
              child: Text(
                'An error occoured',
                style: GoogleFonts.juliusSansOne(fontSize: 16),
              ),
            );
          } else {
            final users = state.users;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileView(
                            user: users[index],
                          ),
                        ),
                      );
                    },
                    title: Text(
                      users[index].username!,
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManageView(
                                  user: users[index],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        if (state.deletingIndex != index)
                          IconButton(
                            onPressed: () {
                              if (!state.isDeleting) {
                                context.read<HomeBloc>().add(
                                      DeleteUser(
                                        users[index],
                                        index,
                                      ),
                                    );
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color:
                                  state.isDeleting ? Colors.grey : Colors.red,
                            ),
                          ),
                        if (state.isDeleting && state.deletingIndex == index)
                          Container(
                            height: 16,
                            width: 16,
                            margin: const EdgeInsets.only(right: 20, left: 14),
                            child: const CircularProgressIndicator(
                              color: Colors.red,
                              strokeWidth: 2,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                itemCount: users.length,
              ),
            );
          }
        }
      },
    );
  }
}
