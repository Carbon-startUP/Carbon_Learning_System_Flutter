import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/core/auth/auth_cubit.dart';
import 'package:pasos/core/auth/auth_state.dart';
import 'package:pasos/features/auth/presentation/pages/login_page.dart';
import 'package:pasos/features/home/presentation/pages/parent_home_page.dart';
import 'package:pasos/features/home/presentation/pages/student_home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          if (state.userRole == UserRole.student) {
            return const StudentHomePage();
          } else {
            return const ParentHomePage();
          }
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
