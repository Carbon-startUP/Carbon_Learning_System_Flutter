import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../data/models/chat_conversation_model.dart';

class ChatHistoryItemWidget extends StatelessWidget {
  final ChatConversation conversation;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  const ChatHistoryItemWidget({
    super.key,
    required this.conversation,
    required this.onTap,
    required this.onDelete,
    required this.onPin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryWithOpacity,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(
          color: conversation.isPinned
              ? AppColors.secondary.withValues(alpha: 0.5)
              : AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        leading: _buildLeadingIcon(),
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
        trailing: _buildTrailing(context),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: conversation.isPinned
            ? AppColors.secondary.withValues(alpha: 0.2)
            : AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Icon(
        conversation.isPinned ? Icons.push_pin : Icons.chat_bubble_outline,
        color: conversation.isPinned ? AppColors.secondary : AppColors.primary,
        size: 20,
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        if (conversation.isPinned) ...[
          Icon(Icons.push_pin, size: 16, color: AppColors.secondary),
          const SizedBox(width: AppSpacing.xs),
        ],
        Expanded(
          child: Text(
            conversation.title,
            style: AppTextStyles.arabicBody.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
            textDirection: TextDirection.rtl,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xxs),
        Text(
          conversation.lastMessagePreview,
          style: AppTextStyles.arabicBody.copyWith(
            color: AppColors.whiteWithOpacity,
            fontSize: 12,
          ),
          textDirection: TextDirection.rtl,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          _formatDate(conversation.updatedAt),
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.whiteWithOpacity,
          ),
        ),
      ],
    );
  }

  Widget _buildTrailing(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: AppColors.whiteWithOpacity),
      color: AppColors.background,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'pin',
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                conversation.isPinned
                    ? Icons.push_pin_outlined
                    : Icons.push_pin,
                color: AppColors.secondary,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                conversation.isPinned ? 'إلغاء التثبيت' : 'تثبيت',
                style: AppTextStyles.arabicBody,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.delete_outline, color: AppColors.error, size: 18),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'حذف',
                style: AppTextStyles.arabicBody.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'pin':
            onPin();
            break;
          case 'delete':
            _showDeleteDialog(context);
            break;
        }
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          'حذف المحادثة',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        content: Text(
          'هل أنت متأكد من حذف هذه المحادثة؟ لا يمكن التراجع عن هذا الإجراء.',
          style: AppTextStyles.arabicBody,
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'إلغاء',
              style: AppTextStyles.arabicBody.copyWith(
                color: AppColors.whiteWithOpacity,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onDelete();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(
              'حذف',
              style: AppTextStyles.arabicBody.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'اليوم ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
