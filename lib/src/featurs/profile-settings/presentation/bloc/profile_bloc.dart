import '../../../../src_export.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository,
      super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
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
}
