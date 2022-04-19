import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/models/user.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User profile',
            style: GoogleFonts.juliusSansOne(fontSize: 20),
          ),
          backgroundColor: const Color(0xffFF5470),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Username: ${user!.username!}',
                style: GoogleFonts.poppins(fontSize: 24),
              ),
              Text(
                'User Id: ${user!.userId!}',
                style: GoogleFonts.poppins(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
