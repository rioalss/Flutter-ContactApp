import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:test/models/user_contact_model.dart';

class FetchUserService {
  Dio dio = Dio();
  FetchUserService() {
    dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api'));
  }

  Future<List<UserContactModel>> fetchUser() async {
    try {
      final response = await dio.get(
        'https://reqres.in/api/users/',
        queryParameters: {'page': 2},
      );
      if (response.statusCode == 200) {
        log('Get successfully : response -> ${response.statusCode}');
        List usersData = response.data!['data'];
        List<UserContactModel> users = usersData.map((userData) {
          return UserContactModel(
            id: userData['id'],
            email: userData['email'],
            firstName: userData['first_name'],
            lastName: userData['last_name'],
            avatar: userData['avatar'],
            isFavorite: false,
          );
        }).toList();
        return users;
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Faild to load user: $e');
    }
  }

  Future<UserContactModel> createUser({
    required firstName,
    required lastName,
    required email,
    required avatar,
    required job,
    required phone,
    required web,
  }) async {
    try {
      final response = await dio.post('/api/users', data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'avatar': avatar,
        'job': job,
        'phone': phone,
        'web': web,
      });
      if (response.statusCode == 201) {
        log('create successfully : response -> ${response.data}');
        final userData = response.data as Map<String, dynamic>;
        final user = UserContactModel(
            email: userData['email'],
            firstName: userData['first_name'],
            lastName: userData['last_name'],
            avatar: userData['avatar'],
            id: null,
            isFavorite: false);

        return user;
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<UserContactModel> updateUser({
    required id,
    required firstName,
    required lastName,
    required email,
    required avatar,
    required job,
    required phone,
    required web,
  }) async {
    try {
      final response = await dio.put('/api/users/$id', data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'avatar': avatar,
        'job': job,
        'phone': phone,
        'web': web,
      });
      if (response.statusCode == 200) {
        log('update successfully : response -> ${response.data}');
        final userData = response.data as Map<String, dynamic>;
        final user = UserContactModel(
          email: userData['email'],
          firstName: userData['first_name'],
          lastName: userData['last_name'],
          avatar: userData['avatar'],
          id: id,
          isFavorite: false,
        );

        return user;
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<bool> deleteUser({
    required id,
  }) async {
    try {
      final response = await dio.delete('/api/users/$id');
      if (response.statusCode == 204) {
        log('delete successfully : response -> ${response.statusCode}');
        return true;
      } else {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
