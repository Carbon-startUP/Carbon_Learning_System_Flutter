import 'package:flutter/material.dart';
import 'package:pasos/features/curricula/data/models/curriculum_model.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CurriculumDetailsPage extends StatelessWidget {
  final CurriculumModel curriculum;

  const CurriculumDetailsPage({super.key, required this.curriculum});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(curriculum.title, style: AppTextStyles.titleMedium),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                curriculum.title,
                style: AppTextStyles.headlineSmall.copyWith(fontFamily: 'RPT'),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'المادة: ${curriculum.subject}',
                style: AppTextStyles.bodyLarge.copyWith(fontFamily: 'RPT'),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'الصف: ${curriculum.grade}',
                style: AppTextStyles.bodyLarge.copyWith(fontFamily: 'RPT'),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                curriculum.description,
                style: AppTextStyles.bodyMedium.copyWith(fontFamily: 'RPT'),
                textDirection: TextDirection.rtl,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _launchURL(curriculum.fileUrl),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text('فتح المادة الدراسية'),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
