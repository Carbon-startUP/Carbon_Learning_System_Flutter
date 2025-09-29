import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/schedule/data/repositories/schedule_repository.dart';
import 'package:pasos/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:pasos/features/schedule/presentation/cubit/schedule_state.dart';
import 'package:pasos/features/schedule/presentation/widgets/teacher_card_widget.dart';
import 'package:pasos/features/schedule/presentation/widgets/meeting_card_widget.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class TeacherMeetingsPage extends StatelessWidget {
  const TeacherMeetingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleCubit(ScheduleRepository())..loadTeachers(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'المعلمين والاجتماعات',
              style: AppTextStyles.arabicHeadline.copyWith(fontSize: 24),
            ),
            bottom: TabBar(
              unselectedLabelColor: AppColors.black.withValues(alpha: 0.6),
              indicatorColor: AppColors.primary,
              labelStyle: AppTextStyles.arabicBody,
              tabs: const [
                Tab(text: 'المعلمين'),
                Tab(text: 'الاجتماعات'),
              ],
            ),
          ),
          body: TabBarView(
            children: [_buildTeachersTab(), _buildMeetingsTab()],
          ),
        ),
      ),
    );
  }

  Widget _buildTeachersTab() {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        if (state is TeachersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TeachersLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: state.teachers.length,
            itemBuilder: (context, index) {
              return TeacherCardWidget(teacher: state.teachers[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMeetingsTab() {
    return BlocProvider(
      create: (context) => ScheduleCubit(ScheduleRepository())..loadMeetings(),
      child: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          if (state is MeetingsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MeetingsLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: state.meetings.length,
              itemBuilder: (context, index) {
                return MeetingCardWidget(meeting: state.meetings[index]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
