part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String addressName;
  final String lat;
  final String lon;
  final File? profileImage;

  UpdateProfileEvent({
    required this.name,
    required this.addressName,
    required this.lat,
    required this.lon,
    this.profileImage,
  });
}
