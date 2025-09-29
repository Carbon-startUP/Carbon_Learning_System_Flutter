import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/models/child_profile_model.dart';
import '../../data/models/health_data_model.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/health_data_form.dart';

class EditProfilePage extends StatefulWidget {
  final dynamic profile;
  final bool isChild;

  const EditProfilePage({
    super.key,
    required this.profile,
    required this.isChild,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  late TextEditingController _religionController;
  late TextEditingController _nationalityController;
  late TextEditingController _cardIdController;
  late TextEditingController _braceletIdController;

  late DateTime _selectedDate;
  late String _selectedGender;
  late HealthDataModel _healthData;

  final Map<String, String> _genderMap = {'Male': 'ذكر', 'Female': 'أنثى'};

  final Map<String, String> _reverseGenderMap = {
    'ذكر': 'Male',
    'أنثى': 'Female',
  };

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    if (widget.profile != null) {
      _fullNameController = TextEditingController(
        text: widget.profile.fullName,
      );
      _selectedDate = widget.profile.dateOfBirth;
      _selectedGender = _genderMap[widget.profile.gender] ?? 'ذكر';

      if (widget.isChild) {
        final child = widget.profile as ChildProfileModel;
        _phoneController = TextEditingController();
        _emailController = TextEditingController();
        _addressController = TextEditingController();
        _religionController = TextEditingController(text: child.religion);
        _nationalityController = TextEditingController(text: child.nationality);
        _cardIdController = TextEditingController(
          text: child.cardId.toString(),
        );
        _braceletIdController = TextEditingController(
          text: child.braceletId.toString(),
        );
        _phoneController = TextEditingController(
          text: child.phoneNumber.toString(),
        );
        _emailController = TextEditingController(text: child.email);
        _healthData = child.healthData;
      } else {
        final user = widget.profile as UserProfileModel;
        _phoneController = TextEditingController(text: user.phoneNumber);
        _emailController = TextEditingController(text: user.email);
        _addressController = TextEditingController(text: user.address);
        _religionController = TextEditingController();
        _nationalityController = TextEditingController();
        _cardIdController = TextEditingController();
        _braceletIdController = TextEditingController();

        _healthData = HealthDataModel(bloodType: 'O+');
      }
    } else {
      _fullNameController = TextEditingController();
      _phoneController = TextEditingController();
      _emailController = TextEditingController();
      _addressController = TextEditingController();

      _selectedDate = DateTime.now().subtract(const Duration(days: 365 * 10));
      _selectedGender = 'ذكر';
      _healthData = HealthDataModel(bloodType: 'O+');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.profile == null
              ? 'اضف ${widget.isChild ? "طفل" : "ملف شخصي"}'
              : 'تعديل ${widget.isChild ? "طفل" : "ملف شخصي"}',
          style: AppTextStyles.headlineMedium,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPersonalInfoSection(),
              const SizedBox(height: AppSpacing.lg),

              _buildHealthDataSection(),
              const SizedBox(height: AppSpacing.xl),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('معلومات شخصية', style: AppTextStyles.titleLarge),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _fullNameController,
          decoration: const InputDecoration(
            labelText: 'الاسم الكامل',
            prefixIcon: Icon(Icons.person, color: AppColors.primary),
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
            decoration: const InputDecoration(
              labelText: 'تاريخ الميلاد',
              prefixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
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
          decoration: const InputDecoration(
            labelText: 'الجنس',
            prefixIcon: Icon(Icons.people, color: AppColors.primary),
          ),
          items: ['ذكر', 'أنثى'].map((gender) {
            return DropdownMenuItem(
              value: gender,
              child: Text(gender, style: AppTextStyles.bodyLarge),
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
        if (widget.isChild) ...[
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _religionController,
            decoration: const InputDecoration(labelText: 'الديانة'),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _nationalityController,
            decoration: const InputDecoration(
              labelText: 'الجنسية',
              prefixIcon: Icon(Icons.flag, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'البريد الإلكتروني',
              prefixIcon: Icon(Icons.email, color: AppColors.primary),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'رقم الهاتف',
              prefixIcon: Icon(Icons.phone, color: AppColors.primary),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _cardIdController,
            decoration: const InputDecoration(
              labelText: 'رقم البطاقة',
              prefixIcon: Icon(Icons.credit_card, color: AppColors.primary),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _braceletIdController,
            decoration: const InputDecoration(
              labelText: 'رقم السوار',
              prefixIcon: Icon(Icons.watch, color: AppColors.primary),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
        if (!widget.isChild) ...[
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'رقم الهاتف',
              prefixIcon: Icon(Icons.phone, color: AppColors.primary),
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
            decoration: const InputDecoration(
              labelText: 'البريد الإلكتروني',
              prefixIcon: Icon(Icons.email, color: AppColors.primary),
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
            decoration: const InputDecoration(
              labelText: 'العنوان',
              prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
            ),
            maxLines: 2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى إدخال العنوان';
              }
              return null;
            },
          ),
        ],
      ],
    );
  }

  Widget _buildHealthDataSection() {
    return HealthDataForm(
      initialHealthData: _healthData,
      onHealthDataChanged: (healthData) {
        setState(() {
          _healthData = healthData;
        });
      },
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveProfile,
        child: Text(widget.profile == null ? 'إضافة' : 'حفظ التعديلات'),
      ),
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

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<ProfileCubit>();

      final englishGender = _reverseGenderMap[_selectedGender] ?? 'Male';

      if (widget.isChild) {
        final cardId = int.tryParse(_cardIdController.text) ?? 0;
        final braceletId = int.tryParse(_braceletIdController.text) ?? 0;
        final phoneNumber = int.tryParse(_phoneController.text) ?? 0;

        if (widget.profile == null) {
          final newChild = ChildProfileModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            parentId: cubit.currentUserProfile!.id,
            fullName: _fullNameController.text,
            dateOfBirth: _selectedDate,
            gender: englishGender,
            religion: _religionController.text,
            nationality: _nationalityController.text,
            email: _emailController.text,
            phoneNumber: phoneNumber,
            cardId: cardId,
            braceletId: braceletId,
            age: DateTime.now().year - _selectedDate.year,
            healthData: _healthData,
          );
          cubit.addChildProfile(newChild);
        } else {
          final child = widget.profile as ChildProfileModel;
          final updatedChild = child.copyWith(
            fullName: _fullNameController.text,
            dateOfBirth: _selectedDate,
            gender: englishGender,
            religion: _religionController.text,
            nationality: _nationalityController.text,
            email: _emailController.text,
            phoneNumber: phoneNumber,
            cardId: cardId,
            braceletId: braceletId,
            age: DateTime.now().year - _selectedDate.year,
            healthData: _healthData,
          );
          cubit.updateChildProfile(updatedChild);
        }
      } else {
        final user = widget.profile as UserProfileModel;
        final updatedUser = user.copyWith(
          fullName: _fullNameController.text,
          dateOfBirth: _selectedDate,
          gender: englishGender,
          phoneNumber: _phoneController.text,
          email: _emailController.text,
          address: _addressController.text,
        );
        cubit.updateUserProfile(updatedUser);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _religionController.dispose();
    _nationalityController.dispose();
    _cardIdController.dispose();
    _braceletIdController.dispose();
    super.dispose();
  }
}
