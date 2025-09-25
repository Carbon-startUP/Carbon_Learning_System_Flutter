import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/theme/app_spacing.dart';

class ChatHistorySearchWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final String initialQuery;

  const ChatHistorySearchWidget({
    super.key,
    required this.onSearchChanged,
    this.initialQuery = '',
  });

  @override
  State<ChatHistorySearchWidget> createState() =>
      _ChatHistorySearchWidgetState();
}

class _ChatHistorySearchWidgetState extends State<ChatHistorySearchWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryWithOpacity,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: TextField(
        controller: _controller,
        style: AppTextStyles.arabicBody,
        textDirection: TextDirection.rtl,
        onChanged: widget.onSearchChanged,
        decoration: InputDecoration(
          hintText: 'البحث في المحادثات...',
          hintStyle: AppTextStyles.arabicBody.copyWith(
            color: AppColors.whiteWithOpacity,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.primary),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _controller.clear();
                    widget.onSearchChanged('');
                  },
                  icon: Icon(Icons.clear, color: AppColors.whiteWithOpacity),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
      ),
    );
  }
}
