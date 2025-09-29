import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../data/models/chat_message_model.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(false),
          if (!isUser) const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: Column(
                crossAxisAlignment: isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  _buildMessageBubble(isUser),
                  const SizedBox(height: AppSpacing.xxs),
                  _buildTimestamp(),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: AppSpacing.xs),
          if (isUser) _buildAvatar(true),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isUser) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: isUser ? AppColors.primary : AppColors.secondary,
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        size: 18,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildMessageBubble(bool isUser) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: isUser
            ? AppColors.primary.withValues(alpha: 0.8)
            : AppColors.background.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(
          color: isUser
              ? AppColors.primary.withValues(alpha: 0.3)
              : AppColors.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: _buildMessageContent(),
    );
  }

  Widget _buildMessageContent() {
    switch (message.type) {
      case MessageType.text:
        return _buildTextContent();
      case MessageType.file:
        return _buildFileContent();
      case MessageType.image:
        return _buildImageContent();
    }
  }

  Widget _buildTextContent() {
    return Text(
      message.content,
      style: AppTextStyles.arabicBody,
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildFileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.attach_file, color: AppColors.secondary, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.fileName ?? 'ملف',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.secondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (message.fileSize != null)
                      Text(
                        message.fileSize!,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.blackWithOpacity,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (message.content.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            message.content,
            style: AppTextStyles.arabicBody,
            textDirection: TextDirection.rtl,
          ),
        ],
      ],
    );
  }

  Widget _buildImageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.image, color: AppColors.secondary, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.fileName ?? 'صورة',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.secondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (message.fileSize != null)
                      Text(
                        message.fileSize!,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.blackWithOpacity,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (message.content.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            message.content,
            style: AppTextStyles.arabicBody,
            textDirection: TextDirection.rtl,
          ),
        ],
      ],
    );
  }

  Widget _buildTimestamp() {
    return Text(
      _formatTime(message.timestamp),
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.blackWithOpacity,
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
