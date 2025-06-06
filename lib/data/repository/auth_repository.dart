import 'package:dartz/dartz.dart';
import 'package:canary_app/data/model/request/auth/login_request_model.dart';
import 'package:canary_app/data/model/request/auth/register_request_model.dart';
import 'package:canary_app/data/model/response/auth_response_model.dart';
import 'package:canary_app/service/service_http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:canary_app/core/error/failure.dart'; // import Failure

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

  // LOGIN
  Future<Either<Failure, AuthResponseModel>> login(LoginRequestModel requestModel) async {
    try {
      final http.Response response = await _serviceHttpClient.post(
        'login',
        requestModel.toMap(),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponseModel.fromJson(response.body);
        if (authResponse.user?.token != null) {
          await secureStorage.write(key: 'token', value: authResponse.user!.token);
        }
        return Right(authResponse);
      } else {
        return Left(Failure('Login gagal: ${response.body}'));
      }
    } catch (e) {
      return Left(Failure('Terjadi kesalahan: $e'));
    }
  }

  // REGISTER
  Future<Either<Failure, AuthResponseModel>> register(RegisterRequestModel requestModel) async {
    try {
      final http.Response response = await _serviceHttpClient.post(
        'register',
        requestModel.toMap(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final authResponse = AuthResponseModel.fromJson(response.body);
        if (authResponse.user?.token != null) {
          await secureStorage.write(key: 'token', value: authResponse.user!.token);
        }
        return Right(authResponse);
      } else {
        return Left(Failure('Register gagal: ${response.body}'));
      }
    } catch (e) {
      return Left(Failure('Terjadi kesalahan: $e'));
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await secureStorage.delete(key: 'token');
  }

  // AMBIL TOKEN
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }
}
