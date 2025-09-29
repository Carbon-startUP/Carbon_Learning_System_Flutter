import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/theme/app_spacing.dart';

class ChatInputWidget extends StatefulWidget {
  final Function(String) onSendMessage;
  final VoidCallback onPickFile;
  final bool isLoading;

  const ChatInputWidget({
    super.key,
    required this.onSendMessage,
    required this.onPickFile,
    this.isLoading = false,
  });

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final canSend = _controller.text.trim().isNotEmpty && !widget.isLoading;
    if (canSend != _canSend) {
      setState(() {
        _canSend = canSend;
      });
    }
  }

  void _sendMessage() {
    if (_canSend) {
      final message = _controller.text.trim();
      _controller.clear();
      widget.onSendMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: widget.isLoading ? null : widget.onPickFile,
                icon: Icon(
                  Icons.attach_file,
                  color: widget.isLoading
                      ? AppColors.blackWithOpacity
                      : AppColors.secondary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryWithOpacity,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  enabled: !widget.isLoading,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyles.arabicBody,
                  decoration: InputDecoration(
                    hintText: 'اكتب رسالتك هنا...',
                    hintStyle: AppTextStyles.arabicBody.copyWith(
                      color: AppColors.blackWithOpacity,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),

            Container(
              decoration: BoxDecoration(
                gradient: _canSend ? AppColors.primaryGradient : null,
                color: _canSend ? null : AppColors.blackWithOpacity,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _canSend ? _sendMessage : null,
                icon: Icon(
                  Icons.send,
                  color: _canSend ? AppColors.white : AppColors.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
