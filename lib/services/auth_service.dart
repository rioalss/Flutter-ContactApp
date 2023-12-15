import 'package:dio/dio.dart';
import 'package:test/services/dio_exceptions.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Make API request to authenticate user
      Response response = await _dio.post(
        'https://reqres.in/api/login',
        data: {'email': email, 'password': password},
      );
      return response.data;
    } on DioException catch (error) {
      final errorMessage = DioExceptions.fromDioException(error).toString();
      throw errorMessage;
    }
  }
}


