import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../data/models/user_profile_model.dart';
import '../cubit/profile_cubit.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _cardIdController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  DateTime _selectedDate = DateTime.now().subtract(
    const Duration(days: 365 * 25),
  );
  String _selectedGender = 'ذكر';
  bool _isVerified = false;

  final Map<String, String> _reverseGenderMap = {
    'ذكر': 'Male',
    'أنثى': 'Female',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إنشاء ملف شخصي', style: AppTextStyles.arabicHeadline),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_isVerified) _buildVerificationSection(),
              if (_isVerified) _buildProfileForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          ),
          child: Column(
            children: [
              const Icon(Icons.credit_card, size: 48, color: AppColors.white),
              const SizedBox(height: AppSpacing.md),
              Text(
                'أدخل رقم بطاقتك',
                style: AppTextStyles.arabicHeadline.copyWith(
                  color: AppColors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'سيتم استخدام هذا للتحقق من هويتك',
                style: AppTextStyles.arabicBody.copyWith(
                  color: AppColors.black.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextFormField(
          controller: _cardIdController,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            labelText: 'رقم البطاقة',
            labelStyle: AppTextStyles.arabicBody,
            prefixIcon: const Icon(Icons.credit_card, color: AppColors.primary),
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
        ElevatedButton(
          onPressed: _verifyCardId,
          child: Text('تحقق واستمر', style: AppTextStyles.arabicBody),
        ),
      ],
    );
  }

  Widget _buildProfileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'تم التحقق من البطاقة: ${_cardIdController.text}',
                style: AppTextStyles.arabicBody.copyWith(
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'المعلومات الشخصية',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 20),
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _fullNameController,
          decoration: InputDecoration(
            labelText: 'الاسم الكامل',
            labelStyle: AppTextStyles.arabicBody,
            prefixIcon: const Icon(Icons.person, color: AppColors.primary),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى إدخال الاسم الكامل';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),
        InkWell(
          onTap: _selectDate,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'تاريخ الميلاد',
              labelStyle: AppTextStyles.arabicBody,
              prefixIcon: const Icon(
                Icons.calendar_today,
                color: AppColors.primary,
              ),
            ),
            child: Text(
              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              style: AppTextStyles.bodyLarge,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        DropdownButtonFormField<String>(
          value: _selectedGender,
          decoration: InputDecoration(
            labelText: 'الجنس',
            labelStyle: AppTextStyles.arabicBody,
            prefixIcon: const Icon(Icons.people, color: AppColors.primary),
          ),
          items: ['ذكر', 'أنثى'].map((gender) {
            return DropdownMenuItem(
              value: gender,
              child: Text(gender, style: AppTextStyles.arabicBody),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedGender = value;
              });
            }
          },
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'رقم الهاتف',
            labelStyle: AppTextStyles.arabicBody,
            prefixIcon: const Icon(Icons.phone, color: AppColors.primary),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى إدخال رقم الهاتف';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'البريد الإلكتروني',
            labelStyle: AppTextStyles.arabicBody,
            prefixIcon: const Icon(Icons.email, color: AppColors.primary),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى إدخال البريد الإلكتروني';
            }
            if (!value.contains('@')) {
              return 'يرجى إدخال بريد إلكتروني صالح';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _addressController,
          decoration: InputDecoration(
            labelText: 'العنوان',
            labelStyle: AppTextStyles.arabicBody,
            prefixIcon: const Icon(Icons.location_on, color: AppColors.primary),
          ),
          maxLines: 2,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى إدخال العنوان';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _createProfile,
            child: Text('إنشاء الملف الشخصي', style: AppTextStyles.arabicBody),
          ),
        ),
      ],
    );
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.background,
              onSurface: AppColors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _verifyCardId() {
    if (_cardIdController.text.isNotEmpty &&
        _cardIdController.text.length >= 10) {
      setState(() {
        _isVerified = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'يرجى إدخال رقم بطاقة صالح',
            style: AppTextStyles.arabicBody,
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _createProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        final englishGender = _reverseGenderMap[_selectedGender] ?? 'Male';

        final newProfile = UserProfileModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          cardIdNumber: _cardIdController.text,
          fullName: _fullNameController.text,
          dateOfBirth: _selectedDate,
          gender: englishGender,
          phoneNumber: _phoneController.text,
          email: _emailController.text,
          address: _addressController.text,
          lastUpdated: DateTime.now(),
          childrenIds: [],
        );

        await context.read<ProfileCubit>().createUserProfile(newProfile);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'فشل في إنشاء الملف الشخصي',
                style: AppTextStyles.arabicBody,
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}
