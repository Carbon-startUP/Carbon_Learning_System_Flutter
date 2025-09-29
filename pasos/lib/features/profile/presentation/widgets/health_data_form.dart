import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../data/models/health_data_model.dart';

class HealthDataForm extends StatefulWidget {
  final HealthDataModel initialHealthData;
  final Function(HealthDataModel) onHealthDataChanged;

  const HealthDataForm({
    super.key,
    required this.initialHealthData,
    required this.onHealthDataChanged,
  });

  @override
  State<HealthDataForm> createState() => _HealthDataFormState();
}

class _HealthDataFormState extends State<HealthDataForm> {
  late String _selectedBloodType;
  late List<String> _chronicConditions;

  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void initState() {
    super.initState();

    _selectedBloodType = widget.initialHealthData.bloodType;
    _chronicConditions = List.from(widget.initialHealthData.chronicConditions);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المعلومات الصحية',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 20),
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedBloodType,
                decoration: InputDecoration(
                  labelText: 'فصيلة الدم',
                  labelStyle: AppTextStyles.arabicBody,
                  prefixIcon: const Icon(
                    Icons.water_drop,
                    color: AppColors.primary,
                  ),
                ),
                items: _bloodTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type, style: AppTextStyles.bodyLarge),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedBloodType = value;
                    });
                    _updateHealthData();
                  }
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),
        Row(children: [const SizedBox(width: AppSpacing.md)]),

        const SizedBox(height: AppSpacing.md),
        _buildListSection(
          'الحالات المزمنة',
          _chronicConditions,
          Icons.medical_information,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }

  Widget _buildListSection(String title, List<String> items, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.xs),
            Text(
              title,
              style: AppTextStyles.arabicBody.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
              onPressed: () => _showAddItemDialog(title, items),
              tooltip: 'إضافة',
            ),
          ],
        ),
        if (items.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: items.map((item) {
              return Chip(
                label: Text(
                  item,
                  style: AppTextStyles.arabicBody.copyWith(fontSize: 12),
                ),
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                deleteIcon: const Icon(Icons.close, size: 16),
                deleteIconColor: AppColors.error,
                onDeleted: () {
                  setState(() {
                    items.remove(item);
                  });
                  _updateHealthData();
                },
              );
            }).toList(),
          ),
        ] else ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Text(
              'لم يتم إضافة $title',
              style: AppTextStyles.arabicBody.copyWith(
                fontSize: 12,
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showAddItemDialog(String title, List<String> items) {
    String newItem = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: Text(
            'إضافة $title',
            style: AppTextStyles.arabicHeadline.copyWith(fontSize: 18),
          ),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'أدخل $title',
              hintStyle: AppTextStyles.arabicBody.copyWith(
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
            style: AppTextStyles.arabicBody,
            onChanged: (value) => newItem = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('إلغاء', style: AppTextStyles.arabicBody),
            ),
            ElevatedButton(
              onPressed: () {
                if (newItem.isNotEmpty) {
                  setState(() {
                    items.add(newItem);
                  });
                  _updateHealthData();
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'إضافة',
                style: AppTextStyles.arabicBody.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateHealthData() {
    final healthData = HealthDataModel(
      bloodType: _selectedBloodType,
      chronicConditions: _chronicConditions,
    );
    widget.onHealthDataChanged(healthData);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
