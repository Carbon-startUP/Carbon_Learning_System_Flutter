import 'package:pasos/features/schedule/data/models/schedule_model.dart';
import 'package:pasos/features/schedule/data/models/teacher_model.dart';
import 'package:pasos/features/schedule/data/models/meeting_model.dart';

class ScheduleRepository {
  Future<List<ScheduleModel>> getWeeklySchedule() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      ScheduleModel(
        id: '1',
        dayName: 'الأحد',
        dayIndex: 0,
        classes: [
          const ClassModel(
            id: '1',
            subjectName: 'الرياضيات',
            teacherName: 'أحمد محمد',
            teacherId: 'teacher1',
            startTime: '08:00',
            endTime: '08:45',
            roomNumber: '101',
            periodNumber: 1,
          ),
          const ClassModel(
            id: '2',
            subjectName: 'اللغة العربية',
            teacherName: 'فاطمة أحمد',
            teacherId: 'teacher2',
            startTime: '08:50',
            endTime: '09:35',
            roomNumber: '102',
            periodNumber: 2,
          ),
          const ClassModel(
            id: '3',
            subjectName: 'العلوم',
            teacherName: 'محمد علي',
            teacherId: 'teacher3',
            startTime: '09:40',
            endTime: '10:25',
            roomNumber: '103',
            periodNumber: 3,
          ),
          const ClassModel(
            id: '4',
            subjectName: 'اللغة الإنجليزية',
            teacherName: 'سارة خالد',
            teacherId: 'teacher4',
            startTime: '10:40',
            endTime: '11:25',
            roomNumber: '104',
            periodNumber: 4,
          ),
        ],
      ),
      ScheduleModel(
        id: '2',
        dayName: 'الاثنين',
        dayIndex: 1,
        classes: [
          const ClassModel(
            id: '5',
            subjectName: 'التاريخ',
            teacherName: 'يوسف إبراهيم',
            teacherId: 'teacher5',
            startTime: '08:00',
            endTime: '08:45',
            roomNumber: '105',
            periodNumber: 1,
          ),
          const ClassModel(
            id: '6',
            subjectName: 'الجغرافيا',
            teacherName: 'منى عبدالله',
            teacherId: 'teacher6',
            startTime: '08:50',
            endTime: '09:35',
            roomNumber: '106',
            periodNumber: 2,
          ),
        ],
      ),
      ScheduleModel(
        id: '3',
        dayName: 'الثلاثاء',
        dayIndex: 2,
        classes: [
          const ClassModel(
            id: '7',
            subjectName: 'الفيزياء',
            teacherName: 'عمر حسن',
            teacherId: 'teacher7',
            startTime: '08:00',
            endTime: '08:45',
            roomNumber: '107',
            periodNumber: 1,
          ),
        ],
      ),
      ScheduleModel(
        id: '4',
        dayName: 'الأربعاء',
        dayIndex: 3,
        classes: [
          const ClassModel(
            id: '8',
            subjectName: 'الكيمياء',
            teacherName: 'ليلى أحمد',
            teacherId: 'teacher8',
            startTime: '08:00',
            endTime: '08:45',
            roomNumber: '108',
            periodNumber: 1,
          ),
        ],
      ),
      ScheduleModel(
        id: '5',
        dayName: 'الخميس',
        dayIndex: 4,
        classes: [
          const ClassModel(
            id: '9',
            subjectName: 'الأحياء',
            teacherName: 'خالد محمود',
            teacherId: 'teacher9',
            startTime: '08:00',
            endTime: '08:45',
            roomNumber: '109',
            periodNumber: 1,
          ),
        ],
      ),
    ];
  }

  Future<List<TeacherModel>> getTeachers() async {
    await Future.delayed(const Duration(seconds: 1));

    return const [
      TeacherModel(
        id: 'teacher1',
        name: 'أحمد محمد',
        subject: 'الرياضيات',
        email: 'ahmed@school.com',
        phoneNumber: '0501234567',
        profileImage: 'assets/images/teacher1.png',
        availableTimeSlots: ['02:00 م', '03:00 م', '04:00 م'],
      ),
      TeacherModel(
        id: 'teacher2',
        name: 'فاطمة أحمد',
        subject: 'اللغة العربية',
        email: 'fatima@school.com',
        phoneNumber: '0507654321',
        profileImage: 'assets/images/teacher2.png',
        availableTimeSlots: ['01:00 م', '02:00 م', '03:00 م'],
      ),
      TeacherModel(
        id: 'teacher3',
        name: 'محمد علي',
        subject: 'العلوم',
        email: 'mohammed@school.com',
        phoneNumber: '0509876543',
        profileImage: 'assets/images/teacher3.png',
        availableTimeSlots: ['12:00 م', '01:00 م', '02:00 م'],
      ),
    ];
  }

  Future<List<MeetingModel>> getMeetings() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MeetingModel(
        id: '1',
        teacherId: 'teacher1',
        teacherName: 'أحمد محمد',
        studentId: 'student1',
        studentName: 'محمد علي',
        requestDate: DateTime.now().subtract(const Duration(days: 2)),
        meetingDate: DateTime.now().add(const Duration(days: 1)),
        timeSlot: '02:00 م',
        subject: 'مناقشة الأداء الأكاديمي',
        description: 'مناقشة أداء الطالب في مادة الرياضيات',
        status: MeetingStatus.approved,
      ),
      MeetingModel(
        id: '2',
        teacherId: 'teacher2',
        teacherName: 'فاطمة أحمد',
        studentId: 'student1',
        studentName: 'محمد علي',
        requestDate: DateTime.now().subtract(const Duration(days: 1)),
        meetingDate: DateTime.now().add(const Duration(days: 3)),
        timeSlot: '01:00 م',
        subject: 'متابعة المستوى',
        description: 'متابعة مستوى الطالب في اللغة العربية',
        status: MeetingStatus.pending,
      ),
    ];
  }

  Future<bool> requestMeeting(Map<String, dynamic> meetingData) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
