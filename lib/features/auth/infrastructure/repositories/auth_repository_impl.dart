import '../../domain/domain.dart';
import '../datasources/auth_datasources_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({
    AuthDataSource? dataSource,
  }) : dataSource = dataSource ?? AuthDataSourcesImpl();

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password) {
    return dataSource.register(email, password);
  }

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }
}
