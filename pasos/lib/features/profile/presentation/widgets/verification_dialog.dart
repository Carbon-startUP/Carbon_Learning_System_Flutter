import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';

class VerificationDialog extends StatefulWidget {
  final Function(String) onVerified;

  const VerificationDialog({super.key, required this.onVerified});

  @override
  State<VerificationDialog> createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _cardIdController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.security,
                  color: AppColors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'التحقق من الهوية',
                style: AppTextStyles.arabicHeadline.copyWith(fontSize: 22),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'يرجى إدخال رقم البطاقة الخاص بك للتحقق من هويتك',
                style: AppTextStyles.arabicBody.copyWith(
                  color: AppColors.white.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _cardIdController,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  labelText: 'رقم البطاقة',
                  labelStyle: AppTextStyles.arabicBody,
                  prefixIcon: const Icon(
                    Icons.credit_card,
                    color: AppColors.primary,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال رقم البطاقة';
                  }
                  if (value.length < 10) {
                    return 'رقم البطاقة يجب أن يكون 10 أحرف على الأقل';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: Text(
                        'إلغاء',
                        style: AppTextStyles.arabicBody.copyWith(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _verify,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.white,
                              ),
                            )
                          : Text('تحقق', style: AppTextStyles.arabicBody),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verify() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate verification delay
      await Future.delayed(const Duration(seconds: 1));

      widget.onVerified(_cardIdController.text);
    }
  }

  @override
  void dispose() {
    _cardIdController.dispose();
    super.dispose();
  }
}
