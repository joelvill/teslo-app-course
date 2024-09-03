import 'package:dio/dio.dart';

import '../../../../config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class AuthDataSourcesImpl extends AuthDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            message: e.response?.data['message'] ?? 'Credentials incorrect');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        // throw ConnectionTimeout();
        throw CustomError(message: 'Connection timeout');
      }

      throw Exception();
    } catch (e) {
      throw CustomError(message: 'Something wrong happened');
    }
  }

  @override
  Future<User> register(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/auth/check-status',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            message: e.response?.data['message'] ?? 'Credentials incorrect');
      }

      throw Exception();
    } catch (e) {
      throw CustomError(message: 'Something wrong happened');
    }
  }
}
