import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../cubit/ai_chat_cubit.dart';
import '../cubit/ai_chat_state.dart';
import '../widgets/chat_message_widget.dart';
import '../widgets/chat_input_widget.dart';
import '../widgets/typing_indicator_widget.dart';
import '../widgets/empty_chat_widget.dart';
import 'chat_history_page.dart';

class AiChatPage extends StatelessWidget {
  const AiChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiChatCubit()..startNewConversation(),
      child: const AiChatView(),
    );
  }
}

class AiChatView extends StatefulWidget {
  const AiChatView({super.key});

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<AiChatCubit, AiChatState>(
        listener: (context, state) {
          if (state is AiChatLoaded) {
            _scrollToBottom();
          } else if (state is AiChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: AppTextStyles.arabicBody,
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              if (state is AiChatLoaded && state.isGeneratingTitle)
                _buildTitleGeneratingIndicator(),
              Expanded(child: _buildChatBody(state)),
              _buildChatInput(context, state),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: BlocBuilder<AiChatCubit, AiChatState>(
        builder: (context, state) {
          String title = 'المساعد الذكي';
          String subtitle = 'متصل';

          if (state is AiChatLoaded && state.currentConversation != null) {
            title = state.currentConversation!.title;
            subtitle = state.isGeneratingTitle
                ? 'جاري إنشاء العنوان...'
                : 'متصل';
          }

          return Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.secondary,
                radius: 20,
                child: Icon(Icons.smart_toy, color: AppColors.white),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: state is AiChatLoaded && state.isGeneratingTitle
                            ? AppColors.secondary
                            : AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () => _openChatHistory(context),
          icon: Icon(Icons.history, color: AppColors.white),
          tooltip: 'سجل المحادثات',
        ),
        IconButton(
          onPressed: () => _showNewChatDialog(context),
          icon: Icon(Icons.add, color: AppColors.white),
          tooltip: 'محادثة جديدة',
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: AppColors.white),
          color: AppColors.background,
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'clear',
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Icon(Icons.clear_all, color: AppColors.warning, size: 18),
                  const SizedBox(width: AppSpacing.xs),
                  Text('مسح المحادثة', style: AppTextStyles.arabicBody),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'info',
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Icon(Icons.info_outline, color: AppColors.info, size: 18),
                  const SizedBox(width: AppSpacing.xs),
                  Text('معلومات المساعد', style: AppTextStyles.arabicBody),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'clear':
                _showClearChatDialog(context);
                break;
              case 'info':
                _showChatInfo(context);
                break;
            }
          },
        ),
      ],
    );
  }

  Widget _buildTitleGeneratingIndicator() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        border: Border(
          bottom: BorderSide(color: AppColors.secondary.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            'جاري إنشاء عنوان للمحادثة...',
            style: AppTextStyles.arabicBody.copyWith(
              color: AppColors.secondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBody(AiChatState state) {
    if (state is AiChatInitial || state is AiChatLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state is AiChatLoaded) {
      if (state.currentConversation == null) {
        return const EmptyChatWidget();
      }

      final messages = state.currentConversation!.messages;
      if (messages.isEmpty) {
        return const EmptyChatWidget();
      }

      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        itemCount: messages.length + (state.isTyping ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == messages.length && state.isTyping) {
            return const TypingIndicatorWidget();
          }

          return ChatMessageWidget(message: messages[index]);
        },
      );
    }

    return const EmptyChatWidget();
  }

  Widget _buildChatInput(BuildContext context, AiChatState state) {
    final isLoading = state is AiChatLoaded && state.isTyping;
    final hasConversation =
        state is AiChatLoaded && state.currentConversation != null;

    return ChatInputWidget(
      onSendMessage: hasConversation
          ? (message) {
              context.read<AiChatCubit>().sendTextMessage(message);
            }
          : (message) {},
      onPickFile: hasConversation
          ? () {
              context.read<AiChatCubit>().pickFile();
            }
          : () {},
      isLoading: isLoading,
    );
  }

  void _openChatHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<AiChatCubit>(),
          child: const ChatHistoryPage(),
        ),
      ),
    );
  }

  void _showNewChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          'محادثة جديدة',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        content: Text(
          'هل تريد بدء محادثة جديدة؟ سيتم حفظ المحادثة الحالية في السجل.',
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
              context.read<AiChatCubit>().startNewConversation();
            },
            child: Text(
              'محادثة جديدة',
              style: AppTextStyles.arabicBody.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          'مسح المحادثة',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        content: Text(
          'هل أنت متأكد من أنك تريد مسح جميع الرسائل في هذه المحادثة؟',
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
              context.read<AiChatCubit>().clearCurrentChat();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(
              'مسح',
              style: AppTextStyles.arabicBody.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showChatInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXLarge),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.whiteWithOpacity,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'حول المساعد الذكي',
              style: AppTextStyles.arabicHeadline.copyWith(fontSize: 20),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'الميزات المتوفرة:',
              style: AppTextStyles.arabicBody,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildInfoItem('الإجابة على الأسئلة'),
            _buildInfoItem('تحليل الملفات والمستندات'),
            _buildInfoItem('وصف الصور والمحتوى المرئي'),
            _buildInfoItem('تلخيص النصوص'),
            _buildInfoItem('حفظ المحادثات تلقائياً'),
            _buildInfoItem('إنشاء عناوين ذكية للمحادثات'),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'أنواع الملفات المدعومة:',
              style: AppTextStyles.arabicBody,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildInfoItem('PDF، Word، Excel، PowerPoint'),
            _buildInfoItem('الصور: JPG، PNG، GIF'),
            _buildInfoItem('الملفات النصية'),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(Icons.check_circle, color: AppColors.success, size: 16),
          const SizedBox(width: AppSpacing.xs),
          Text(
            text,
            style: AppTextStyles.arabicBody.copyWith(
              color: AppColors.whiteWithOpacity,
            ),
          ),
        ],
      ),
    );
  }
}
