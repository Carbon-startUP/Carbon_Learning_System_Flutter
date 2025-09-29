import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/core/auth/auth_cubit.dart';
import 'package:pasos/core/navigation/app_router.dart';
import 'package:pasos/features/ai_chat/presentation/cubit/ai_chat_cubit.dart';
import 'package:pasos/features/costs/presentation/cubit/costs_cubit.dart';
import 'package:pasos/features/curricula/data/Repository/curricula_repository.dart';
import 'package:pasos/features/curricula/presentation/cubit/curricula_cubit.dart';
import 'package:pasos/features/exams/data/repositories/exam_repository.dart';
import 'package:pasos/features/exams/presentation/cubit/exam_results_cubit.dart';
import 'package:pasos/features/profile/data/repositories/profile_repository.dart';
import 'package:pasos/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:pasos/features/schedule/data/repositories/schedule_repository.dart';
import 'package:pasos/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:pasos/features/tracking/data/repositories/tracking_repository.dart';
import 'package:pasos/features/tracking/presentation/cubit/tracking_cubit.dart';
import 'package:pasos/shared/theme/app_theme.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TrackingRepository>(
          create: (context) => TrackingRepository(),
        ),
      ],
      child: MultiBlocProvider(
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
          BlocProvider<ScheduleCubit>(
            create: (BuildContext context) =>
                ScheduleCubit(ScheduleRepository()),
          ),
          BlocProvider<CurriculaCubit>(
            create: (BuildContext context) =>
                CurriculaCubit(CurriculaRepository()),
          ),
          BlocProvider<ExamResultsCubit>(
            create: (BuildContext context) =>
                ExamResultsCubit(ExamRepository()),
          ),
          BlocProvider<TrackingCubit>(
            create: (context) => TrackingCubit(
              trackingRepository: context.read<TrackingRepository>(),
            ),
          ),
          BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ar'),
      title: 'Pasos',
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splash,
    );
  }
}
