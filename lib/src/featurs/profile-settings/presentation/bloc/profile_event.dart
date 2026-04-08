part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final File? profileImage;

  UpdateProfileEvent({
    required this.name,
    this.profileImage,
  });
}
