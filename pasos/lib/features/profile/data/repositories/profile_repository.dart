import '../datasources/profile_database_helper.dart';
import '../models/user_profile_model.dart';
import '../models/child_profile_model.dart';

class ProfileRepository {
  final ProfileDatabaseHelper _databaseHelper = ProfileDatabaseHelper.instance;

  Future<UserProfileModel?> getUserProfile(String userId) async {
    try {
      return await _databaseHelper.getUserProfile(userId);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  Future<UserProfileModel?> verifyAndGetProfile(String cardIdNumber) async {
    try {
      return await _databaseHelper.getUserProfileByCardId(cardIdNumber);
    } catch (e) {
      throw Exception('Failed to verify profile: $e');
    }
  }

  Future<void> updateUserProfile(UserProfileModel profile) async {
    try {
      final updatedProfile = profile.copyWith(lastUpdated: DateTime.now());
      await _databaseHelper.updateUserProfile(updatedProfile);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<void> createUserProfile(UserProfileModel profile) async {
    try {
      await _databaseHelper.insertUserProfile(profile);
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  Future<List<ChildProfileModel>> getChildrenProfiles(String parentId) async {
    try {
      return await _databaseHelper.getChildrenProfiles(parentId);
    } catch (e) {
      throw Exception('Failed to get children profiles: $e');
    }
  }

  Future<void> addChildProfile(ChildProfileModel profile) async {
    try {
      await _databaseHelper.insertChildProfile(profile);
    } catch (e) {
      throw Exception('Failed to add child profile: $e');
    }
  }

  Future<void> updateChildProfile(ChildProfileModel profile) async {
    try {
      await _databaseHelper.updateChildProfile(profile);
    } catch (e) {
      throw Exception('Failed to update child profile: $e');
    }
  }

  Future<void> deleteChildProfile(String childId) async {
    try {
      await _databaseHelper.deleteChildProfile(childId);
    } catch (e) {
      throw Exception('Failed to delete child profile: $e');
    }
  }
}
