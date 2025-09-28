import 'package:equatable/equatable.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/models/child_profile_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileModel userProfile;
  final List<ChildProfileModel> childrenProfiles;

  const ProfileLoaded({
    required this.userProfile,
    required this.childrenProfiles,
  });

  @override
  List<Object> get props => [userProfile, childrenProfiles];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileVerificationRequired extends ProfileState {}

class ProfileVerificationInProgress extends ProfileState {}

class ProfileVerified extends ProfileState {
  final UserProfileModel userProfile;

  const ProfileVerified(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class ProfileUpdated extends ProfileState {
  final String message;

  const ProfileUpdated(this.message);

  @override
  List<Object> get props => [message];
}
