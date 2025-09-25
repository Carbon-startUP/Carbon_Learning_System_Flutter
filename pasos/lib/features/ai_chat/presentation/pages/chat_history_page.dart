import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../cubit/chat_history_cubit.dart';
import '../cubit/ai_chat_cubit.dart';
import '../widgets/chat_history_item_widget.dart';
import '../widgets/chat_history_search_widget.dart';
import '../../data/models/chat_conversation_model.dart';

class ChatHistoryPage extends StatelessWidget {
  const ChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatHistoryCubit()),
        BlocProvider(create: (context) => AiChatCubit()),
      ],
      child: const ChatHistoryView(),
    );
  }
}

class ChatHistoryView extends StatefulWidget {
  const ChatHistoryView({super.key});

  @override
  State<ChatHistoryView> createState() => _ChatHistoryViewState();
}

class _ChatHistoryViewState extends State<ChatHistoryView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshConversations();
    });
  }

  void _refreshConversations() {
    context.read<ChatHistoryCubit>().refreshConversations();
    context.read<AiChatCubit>().refreshConversationHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          _refreshConversations();
        },
        child: BlocConsumer<ChatHistoryCubit, ChatHistoryState>(
          listener: (context, state) {
            if (state is ChatHistoryError) {
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
            if (state is ChatHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is ChatHistoryLoaded) {
              return Column(
                children: [
                  ChatHistorySearchWidget(
                    onSearchChanged: (query) {
                      context.read<ChatHistoryCubit>().searchConversations(
                        query,
                      );
                    },
                    initialQuery: state.searchQuery,
                  ),
                  Expanded(
                    child: _buildConversationsList(state.filteredConversations),
                  ),
                ],
              );
            }

            return _buildEmptyState();
          },
        ),
      ),
      floatingActionButton: _buildNewChatFab(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'سجل المحادثات',
        style: AppTextStyles.arabicHeadline.copyWith(
          fontSize: 20,
          color: AppColors.white,
        ),
      ),
      centerTitle: true,
    );
  }

  void _openConversation(BuildContext context, String conversationId) {
    context.read<AiChatCubit>().loadConversation(conversationId);
    Navigator.pop(context, true);
  }

  void _deleteConversation(BuildContext context, String conversationId) {
    context.read<ChatHistoryCubit>().deleteConversation(conversationId);
    context.read<AiChatCubit>().deleteConversation(conversationId);
  }

  void _pinConversation(BuildContext context, String conversationId) {
    context.read<ChatHistoryCubit>().pinConversation(conversationId);
    context.read<AiChatCubit>().pinConversation(conversationId);
  }

  void _startNewConversation(BuildContext context) {
    context.read<AiChatCubit>().startNewConversation();
    Navigator.pop(context, true);
  }

  Widget _buildConversationsList(List<ChatConversation> conversations) {
    if (conversations.isEmpty) {
      return _buildEmptySearchState();
    }

    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return ChatHistoryItemWidget(
          conversation: conversation,
          onTap: () => _openConversation(context, conversation.id),
          onDelete: () => _deleteConversation(context, conversation.id),
          onPin: () => _pinConversation(context, conversation.id),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: AppColors.whiteWithOpacity),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'لا توجد محادثات بعد',
              style: AppTextStyles.arabicHeadline.copyWith(
                fontSize: 20,
                color: AppColors.whiteWithOpacity,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'ابدأ محادثة جديدة مع المساعد الذكي',
              style: AppTextStyles.arabicBody.copyWith(
                color: AppColors.whiteWithOpacity,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.whiteWithOpacity),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'لا توجد نتائج بحث',
              style: AppTextStyles.arabicHeadline.copyWith(
                fontSize: 20,
                color: AppColors.whiteWithOpacity,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'جرب البحث بكلمات مختلفة',
              style: AppTextStyles.arabicBody.copyWith(
                color: AppColors.whiteWithOpacity,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewChatFab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _startNewConversation(context),
      backgroundColor: AppColors.primary,
      icon: Icon(Icons.add, color: AppColors.white),
      label: Text(
        'محادثة جديدة',
        style: AppTextStyles.arabicBody.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
