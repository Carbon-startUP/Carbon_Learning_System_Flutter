import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/profile/presentation/pages/create_profile_page.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/child_profile_card.dart';
import '../widgets/verification_dialog.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().loadUserProfile('user123');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الملف الشخصي', style: AppTextStyles.arabicHeadline),
        actions: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.secondary),
                  onPressed: () => _navigateToEditProfile(context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          } else if (state is ProfileVerificationRequired) {
            _showVerificationDialog(context);
          } else if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.success,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading ||
              state is ProfileVerificationInProgress) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is ProfileLoaded) {
            return _buildProfileContent(context, state);
          } else if (state is ProfileInitial || state is ProfileError) {
            return _buildInitialState(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return FloatingActionButton(
              onPressed: () => _navigateToAddChild(context),
              backgroundColor: AppColors.primary,
              tooltip: 'إضافة طفل',
              child: const Icon(Icons.add, color: AppColors.white),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildInitialState(BuildContext context, ProfileState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline,
                size: 64,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'التحقق من الهوية مطلوب',
              style: AppTextStyles.arabicHeadline.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              state is ProfileError
                  ? state.message
                  : 'يرجى التحقق من هويتك للوصول إلى معلومات ملفك الشخصي وإدارتها',
              style: AppTextStyles.arabicBody.copyWith(
                color: AppColors.white.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton.icon(
              onPressed: () => _showVerificationDialog(context),
              icon: const Icon(Icons.verified_user),
              label: Text('التحقق من الهوية', style: AppTextStyles.arabicBody),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: () => _showCreateProfileDialog(context),
              child: Text(
                'إنشاء ملف شخصي جديد',
                style: AppTextStyles.arabicBody.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileInfoCard(profile: state.userProfile),
          const SizedBox(height: AppSpacing.lg),

          if (state.childrenProfiles.isNotEmpty) ...[
            Text(
              'ملفات الأطفال',
              style: AppTextStyles.arabicHeadline.copyWith(fontSize: 22),
            ),
            const SizedBox(height: AppSpacing.md),
            ...state.childrenProfiles.map(
              (child) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ChildProfileCard(
                  child: child,
                  onEdit: () => _navigateToEditChild(context, child),
                  onDelete: () => _confirmDeleteChild(context, child.id),
                ),
              ),
            ),
          ] else ...[
            Center(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                margin: const EdgeInsets.only(top: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.child_care,
                      size: 48,
                      color: AppColors.secondary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'لا توجد ملفات أطفال حتى الآن',
                      style: AppTextStyles.arabicBody.copyWith(
                        color: AppColors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'اضغط على زر + لإضافة ملف طفل',
                      style: AppTextStyles.arabicBody.copyWith(
                        fontSize: 12,
                        color: AppColors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => VerificationDialog(
        onVerified: (cardId) {
          context.read<ProfileCubit>().verifyCardId(cardId);
          Navigator.of(dialogContext).pop();
        },
      ),
    );
  }

  void _showCreateProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          'إنشاء ملف شخصي جديد',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 20),
        ),
        content: Text(
          'هل تريد إنشاء ملف شخصي جديد باستخدام رقم البطاقة الخاص بك؟',
          style: AppTextStyles.arabicBody,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('إلغاء', style: AppTextStyles.arabicBody),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _navigateToCreateProfile(context);
            },
            child: Text('إنشاء', style: AppTextStyles.arabicBody),
          ),
        ],
      ),
    );
  }

  void _navigateToCreateProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateProfilePage()),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    if (cubit.currentUserProfile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfilePage(
            profile: cubit.currentUserProfile!,
            isChild: false,
          ),
        ),
      );
    }
  }

  void _navigateToAddChild(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const EditProfilePage(profile: null, isChild: true),
      ),
    );
  }

  void _navigateToEditChild(BuildContext context, dynamic child) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(profile: child, isChild: true),
      ),
    );
  }

  void _confirmDeleteChild(BuildContext context, String childId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          'حذف ملف الطفل؟',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 20),
        ),
        content: Text(
          'هل أنت متأكد من رغبتك في حذف ملف هذا الطفل؟ لا يمكن التراجع عن هذا الإجراء.',
          style: AppTextStyles.arabicBody,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('إلغاء', style: AppTextStyles.arabicBody),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileCubit>().deleteChildProfile(childId);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text('حذف', style: AppTextStyles.arabicBody),
          ),
        ],
      ),
    );
  }
}
