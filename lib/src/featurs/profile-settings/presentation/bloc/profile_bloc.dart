import 'dart:io';
import '../../../../src_export.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  final LocationService _locationService;

  ProfileBloc({
    required ProfileRepository profileRepository,
    required LocationService locationService,
  })  : _profileRepository = profileRepository,
        _locationService = locationService,
        super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final response = await _profileRepository.getProfile();
      if (response.success && response.data != null) {
        emit(ProfileLoaded(response.data!));
      } else {
        emit(ProfileError(response.message));
      }
    } on ApiException catch (e) {
      debugPrint("ProfileBloc ApiException: ${e.message}");
      emit(ProfileError(e.message));
    } catch (e, stackTrace) {
      debugPrint("ProfileBloc catch: $e");
      debugPrint("ProfileBloc stackTrace: $stackTrace");
      emit(ProfileError('Something went wrong. Please try again.'));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      // Fetch current location automatically
      final locationData = await _locationService.getLocationData();
      
      if (locationData == null) {
        emit(ProfileError('Failed to get current location. Please check your permissions.'));
        return;
      }

      // First update the location
      await _profileRepository.updateUserLocation(
        addressName: locationData.address,
        lat: locationData.latitude,
        lon: locationData.longitude,
      );

      // Then update the profile
      final response = await _profileRepository.updateProfile(
        name: event.name,
        profileImage: event.profileImage,
      );

      print('Update Profile Response: $response');

      if (response.success) {
        // Refresh profile after update
        add(GetProfileEvent());
      } else {
        emit(ProfileError(response.message));
      }
    } on ApiException catch (e) {
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError('Something went wrong. Please try again.'));
    }
  }
}
