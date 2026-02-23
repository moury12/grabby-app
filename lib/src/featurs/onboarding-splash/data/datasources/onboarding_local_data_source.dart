import '../../../../src_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  Future<void> saveUserRole(UserRole role);
  UserRole? getUserRole();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String kUserRoleKey = 'CACHED_USER_ROLE';

  OnboardingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveUserRole(UserRole role) async {
    await sharedPreferences.setString(kUserRoleKey, role.name);
  }

  @override
  UserRole? getUserRole() {
    final roleName = sharedPreferences.getString(kUserRoleKey);
    if (roleName != null) {
      return UserRole.values.firstWhere(
        (role) => role.name == roleName,
        orElse: () => UserRole.customer,
      );
    }
    return null;
  }
}
