import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/api/api_service.dart';
import '../../../../core/api/dio_client.dart';
import '../../../../core/auth/auth_cubit.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(
        AuthRemoteDataSource(
          ApiService(DioClient(Dio())),
          const FlutterSecureStorage(),
        ),
      ),
      child: BlocProvider(
        create: (context) => LoginCubit(context.read<AuthRepository>()),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.horizontalPadding),
              child: BlocListener<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                          textDirection: TextDirection.rtl,
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                    context.read<AuthCubit>().login(state.userRole);
                  } else if (state is LoginError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                          textDirection: TextDirection.rtl,
                        ),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: const Column(
                          children: [
                            SizedBox(height: 100),
                            BuildHeader(),
                            SizedBox(height: AppSpacing.xl),
                            LoginForm(),
                            SizedBox(height: 100),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
