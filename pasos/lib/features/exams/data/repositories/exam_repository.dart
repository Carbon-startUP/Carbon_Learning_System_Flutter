import 'package:pasos/features/exams/data/models/exam_result_model.dart';

class ExamRepository {
  Future<List<ExamResultModel>> getExamResults() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final mockData = [
        {
          'subjectName': 'الرياضيات',
          'score': 85,
          'totalScore': 100,
          'grade': 'ممتاز',
          'examDate': '2025-09-15T00:00:00.000Z',
        },
        {
          'subjectName': 'الفيزياء',
          'score': 78,
          'totalScore': 100,
          'grade': 'جيد جداً',
          'examDate': '2025-09-16T00:00:00.000Z',
        },
        {
          'subjectName': 'اللغة العربية',
          'score': 92,
          'totalScore': 100,
          'grade': 'ممتاز',
          'examDate': '2025-09-17T00:00:00.000Z',
        },
        {
          'subjectName': 'التاريخ',
          'score': 65,
          'totalScore': 100,
          'grade': 'جيد',
          'examDate': '2025-09-18T00:00:00.000Z',
        },
      ];

      final results = mockData
          .map((json) => ExamResultModel.fromJson(json))
          .toList();
      return results;
    } catch (e) {
      throw Exception('فشل في تحميل نتائج الامتحانات من المستودع');
    }
  }
}
