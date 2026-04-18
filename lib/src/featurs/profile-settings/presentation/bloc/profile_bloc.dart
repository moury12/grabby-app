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
      // 1. Fetch current location
      final locationData = await _locationService.getLocationData();
      if (locationData == null) {
        emit(ProfileError('Failed to get current location. Please check your permissions.'));
        return;
      }

      final currentState = state;
      String? userRole;
      if (currentState is ProfileLoaded) {
        userRole = currentState.profileData.authId.role;
      }

      print('Starting profile update for role: $userRole');

      // 2. Role-based Location Update
      if (userRole == 'SHOP_OWNER') {
        // Shop Owners update location via a separate POST endpoint
        final locationResponse = await _profileRepository.updateUserLocation(
          addressName: locationData.address,
          lat: locationData.latitude,
          lon: locationData.longitude,
        );
        if (!locationResponse.success) {
          emit(ProfileError(locationResponse.message));
          return;
        }
      }

      // 3. Update Profile (For Customers, this includes the location data in the same call)
      final response = await _profileRepository.updateProfile(
        name: event.name,
        profileImage: event.profileImage,
        email: event.email,
        phoneNumber: event.phoneNumber,
        shopName: event.shopName,
        shopLicenseNumber: event.shopLicenseNumber,
        contactEmail: event.contactEmail,
        contactPhone: event.contactPhone,
        addressName: locationData.address,
        lat: locationData.latitude,
        lon: locationData.longitude,
      );

      print('Update Profile Final Response: success=${response.success}');

      if (response.success) {
        emit(ProfileUpdateSuccess());
        add(GetProfileEvent());
      } else {
        emit(ProfileError(response.message));
      }
    } on ApiException catch (e) {
      print('ProfileBloc ApiException: ${e.message}');
      emit(ProfileError(e.message));
    } catch (e, stackTrace) {
      print('ProfileBloc Unexpected Error: $e');
      print('Stacktrace: $stackTrace');
      emit(ProfileError('Something went wrong. Please try again.'));
    }
  }
}
