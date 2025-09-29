import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/schedule/data/repositories/schedule_repository.dart';
import 'package:pasos/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:pasos/features/schedule/presentation/cubit/schedule_state.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class RequestMeetingPage extends StatefulWidget {
  final String? teacherId;

  const RequestMeetingPage({super.key, this.teacherId});

  @override
  State<RequestMeetingPage> createState() => _RequestMeetingPageState();
}

class _RequestMeetingPageState extends State<RequestMeetingPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedTimeSlot;

  final List<String> _timeSlots = [
    '09:00 ص',
    '10:00 ص',
    '11:00 ص',
    '12:00 م',
    '01:00 م',
    '02:00 م',
    '03:00 م',
    '04:00 م',
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleCubit(ScheduleRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'طلب موعد',
            style: AppTextStyles.arabicHeadline.copyWith(fontSize: 24),
          ),
        ),
        body: BlocConsumer<ScheduleCubit, ScheduleState>(
          listener: (context, state) {
            if (state is MeetingRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إرسال طلب الموعد بنجاح'),
                  backgroundColor: AppColors.success,
                ),
              );
              Navigator.pop(context);
            } else if (state is MeetingRequestError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'موضوع الاجتماع',
                      style: AppTextStyles.arabicBody.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                        hintText: 'أدخل موضوع الاجتماع',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال موضوع الاجتماع';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'وصف الاجتماع',
                      style: AppTextStyles.arabicBody.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'أدخل وصف الاجتماع',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال وصف الاجتماع';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'تاريخ الاجتماع',
                      style: AppTextStyles.arabicBody.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(
                            const Duration(days: 1),
                          ),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 30),
                          ),
                        );
                        if (date != null) {
                          setState(() {
                            _selectedDate = date;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMedium,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                  : 'اختر التاريخ',
                              style: AppTextStyles.arabicBody,
                            ),
                            const Icon(
                              Icons.calendar_today,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'وقت الاجتماع',
                      style: AppTextStyles.arabicBody.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    DropdownButtonFormField<String>(
                      value: _selectedTimeSlot,
                      decoration: const InputDecoration(hintText: 'اختر الوقت'),
                      items: _timeSlots.map((time) {
                        return DropdownMenuItem(value: time, child: Text(time));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTimeSlot = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'الرجاء اختيار وقت الاجتماع';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    ElevatedButton(
                      onPressed: state is MeetingRequestLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate() &&
                                  _selectedDate != null) {
                                context.read<ScheduleCubit>().requestMeeting({
                                  'teacherId': widget.teacherId ?? '',
                                  'subject': _subjectController.text,
                                  'description': _descriptionController.text,
                                  'meetingDate': _selectedDate!
                                      .toIso8601String(),
                                  'timeSlot': _selectedTimeSlot!,
                                });
                              } else if (_selectedDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'الرجاء اختيار تاريخ الاجتماع',
                                    ),
                                    backgroundColor: AppColors.error,
                                  ),
                                );
                              }
                            },
                      child: state is MeetingRequestLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.white,
                            )
                          : const Text('إرسال الطلب'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
