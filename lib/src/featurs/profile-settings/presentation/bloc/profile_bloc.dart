import '../../../../src_export.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/models/profile_response_model.dart';

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
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError('Something went wrong. Please try again.'));
    }
  }
}
