import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/core/navigation/app_router.dart';
import 'package:pasos/features/ai_chat/presentation/cubit/ai_chat_cubit.dart';
import 'package:pasos/features/costs/data/repositories/costs_repository.dart';
import 'package:pasos/features/costs/presentation/cubit/costs_cubit.dart';
import 'package:pasos/features/profile/data/repositories/profile_repository.dart';
import 'package:pasos/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:pasos/shared/theme/app_theme.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AiChatCubit>(
          create: (BuildContext context) => AiChatCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (BuildContext context) => ProfileCubit(ProfileRepository()),
        ),
        BlocProvider<CostsCubit>(
          create: (BuildContext context) => CostsCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pasos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splash,
    );
  }
}
