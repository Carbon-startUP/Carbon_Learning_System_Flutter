import 'package:pasos/features/curricula/data/models/curriculum_model.dart';

class CurriculaRepository {
  Future<List<CurriculumModel>> getCurricula() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final List<CurriculumModel> curricula = [
        CurriculumModel(
          id: 'math101',
          title: 'أساسيات الجبر',
          description: 'مقدمة شاملة في مبادئ الجبر الأساسية.',
          subject: 'الرياضيات',
          grade: 'الصف العاشر',
          fileUrl:
              'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
          fileType: 'pdf',
        ),
        CurriculumModel(
          id: 'phy101',
          title: 'مبادئ الفيزياء الكلاسيكية',
          description: 'استكشاف قوانين نيوتن والميكانيكا.',
          subject: 'الفيزياء',
          grade: 'الصف الحادي عشر',
          fileUrl: 'https://calibre-ebook.com/downloads/demos/demo.docx',
          fileType: 'doc',
        ),
        CurriculumModel(
          id: 'chem101',
          title: 'الكيمياء العضوية',
          description: 'دراسة المركبات العضوية وتفاعلاتها.',
          subject: 'الكيمياء',
          grade: 'الصف الثاني عشر',
          fileUrl:
              'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
          fileType: 'pdf',
        ),
        CurriculumModel(
          id: 'bio101',
          title: 'علم الأحياء الخلوي',
          description: 'مقدمة في بنية الخلية ووظائفها.',
          subject: 'الأحياء',
          grade: 'الصف العاشر',
          fileUrl: 'https://calibre-ebook.com/downloads/demos/demo.docx',
          fileType: 'doc',
        ),
      ];

      return curricula;
    } catch (e) {
      return [];
    }
  }
}
