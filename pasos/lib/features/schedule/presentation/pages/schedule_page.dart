import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/schedule/data/repositories/schedule_repository.dart';
import 'package:pasos/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:pasos/features/schedule/presentation/cubit/schedule_state.dart';
import 'package:pasos/features/schedule/presentation/widgets/schedule_day_widget.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';
import 'package:pasos/core/navigation/app_router.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ScheduleCubit(ScheduleRepository())..loadWeeklySchedule(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الجدول الدراسي',
            style: AppTextStyles.arabicHeadline.copyWith(fontSize: 24),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.people),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRouter.teacherMeetings),
            ),
          ],
        ),
        body: BlocBuilder<ScheduleCubit, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ScheduleLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: state.schedule.length,
                itemBuilder: (context, index) {
                  return ScheduleDayWidget(schedule: state.schedule[index]);
                },
              );
            } else if (state is ScheduleError) {
              return Center(
                child: Text(state.message, style: AppTextStyles.arabicBody),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
