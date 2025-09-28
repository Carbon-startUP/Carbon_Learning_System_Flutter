import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/models/child_profile_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;
  UserProfileModel? _currentUserProfile;

  ProfileCubit(this._repository) : super(ProfileInitial());

  UserProfileModel? get currentUserProfile => _currentUserProfile;
  ProfileRepository get repository => _repository;

  Future<void> loadUserProfile(String userId) async {
    try {
      emit(ProfileLoading());

      final userProfile = await _repository.getUserProfile(userId);
      if (userProfile == null) {
        emit(const ProfileError('الحساب غير موجود'));
        return;
      }

      _currentUserProfile = userProfile;
      final childrenProfiles = await _repository.getChildrenProfiles(userId);

      emit(
        ProfileLoaded(
          userProfile: userProfile,
          childrenProfiles: childrenProfiles,
        ),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> createUserProfile(UserProfileModel profile) async {
    try {
      emit(ProfileLoading());

      final existingProfile = await _repository.verifyAndGetProfile(
        profile.cardIdNumber,
      );
      if (existingProfile != null) {
        emit(const ProfileError('رقم البطاقة مستخدم بالفعل'));
        return;
      }

      await _repository.createUserProfile(profile);

      _currentUserProfile = profile;

      emit(const ProfileUpdated('تم إنشاء الملف الشخصي بنجاح'));

      await loadUserProfile(profile.id);
    } catch (e) {
      emit(ProfileError('فشل في إنشاء الملف الشخصي: ${e.toString()}'));
    }
  }

  Future<bool> isCardIdAvailable(String cardId) async {
    try {
      final profile = await _repository.verifyAndGetProfile(cardId);
      return profile == null;
    } catch (e) {
      return false;
    }
  }

  Future<void> verifyCardId(String cardIdNumber) async {
    try {
      emit(ProfileVerificationInProgress());

      final profile = await _repository.verifyAndGetProfile(cardIdNumber);
      if (profile == null) {
        emit(const ProfileError('رقم بطاقة الهوية غير صالح'));
        return;
      }

      _currentUserProfile = profile;
      emit(ProfileVerified(profile));

      await loadUserProfile(profile.id);
    } catch (e) {
      emit(ProfileError('فشل التحقق: ${e.toString()}'));
    }
  }

  Future<void> updateUserProfile(UserProfileModel profile) async {
    try {
      emit(ProfileLoading());

      if (profile.cardIdNumber != _currentUserProfile?.cardIdNumber) {
        emit(
          const ProfileError(
            'رقم بطاقة الهوية غير متطابق. يرجى التحقق مرة أخرى.',
          ),
        );
        return;
      }

      await _repository.updateUserProfile(profile);
      _currentUserProfile = profile;

      emit(const ProfileUpdated('تم تحديث الملف الشخصي بنجاح'));

      await loadUserProfile(profile.id);
    } catch (e) {
      emit(ProfileError('فشل تحديث الملف الشخصي: ${e.toString()}'));
    }
  }

  Future<void> addChildProfile(ChildProfileModel childProfile) async {
    try {
      emit(ProfileLoading());

      await _repository.addChildProfile(childProfile);

      emit(const ProfileUpdated('تم إضافة ملف الطفل بنجاح'));

      if (_currentUserProfile != null) {
        await loadUserProfile(_currentUserProfile!.id);
      }
    } catch (e) {
      emit(ProfileError('فشل إضافة ملف الطفل: ${e.toString()}'));
    }
  }

  Future<void> updateChildProfile(ChildProfileModel childProfile) async {
    try {
      emit(ProfileLoading());

      await _repository.updateChildProfile(childProfile);

      emit(const ProfileUpdated('تم تحديث ملف الطفل بنجاح'));

      if (_currentUserProfile != null) {
        await loadUserProfile(_currentUserProfile!.id);
      }
    } catch (e) {
      emit(ProfileError('فشل تحديث ملف الطفل: ${e.toString()}'));
    }
  }

  Future<void> deleteChildProfile(String childId) async {
    try {
      emit(ProfileLoading());

      await _repository.deleteChildProfile(childId);

      emit(const ProfileUpdated('تم حذف ملف الطفل بنجاح'));

      if (_currentUserProfile != null) {
        await loadUserProfile(_currentUserProfile!.id);
      }
    } catch (e) {
      emit(ProfileError('فشل حذف ملف الطفل: ${e.toString()}'));
    }
  }

  void requestVerification() {
    emit(ProfileVerificationRequired());
  }
}
