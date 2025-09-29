class ExamResultModel {
  final String subjectName;
  final double score;
  final double totalScore;
  final String grade;
  final DateTime examDate;

  ExamResultModel({
    required this.subjectName,
    required this.score,
    required this.totalScore,
    required this.grade,
    required this.examDate,
  });

  factory ExamResultModel.fromJson(Map<String, dynamic> json) {
    return ExamResultModel(
      subjectName: json['subjectName'] as String,
      score: (json['score'] as num).toDouble(),
      totalScore: (json['totalScore'] as num).toDouble(),
      grade: json['grade'] as String,
      examDate: DateTime.parse(json['examDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName,
      'score': score,
      'totalScore': totalScore,
      'grade': grade,
      'examDate': examDate.toIso8601String(),
    };
  }
}
