// import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:canary_app/data/model/request/admin/admin_profile_request.dart';
import 'package:canary_app/data/model/response/admin_profile_response_model.dart';
import 'package:canary_app/service/service_http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart';
import 'dart:convert';
import 'dart:developer'; // untuk fungsi log()



class ProfileAdminRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  ProfileAdminRepository(this._serviceHttpClient);

  Future<Either<String, AdminProfileResponseModel>> addProfile(
    AdminProfileRequest requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        'admin/profile',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201){
        final profileResponse = AdminProfileResponseModel.fromMap(jsonResponse);
        log("Add Admin Profile successful: ${profileResponse.message}");
        return Right(profileResponse);
      }else {
        log("Add Admin Profile failed: ${jsonResponse['massage']}");
        return Left(jsonResponse['message']?? "Create Profile failed");
      }
    }catch (e){
      log("Error in adding profile: $e");
      return Left("An error occured while adding profile: $e");
    }
  }

  Future<Either<String, AdminProfileResponseModel>>getProfile() async{
    try {
      final response = await _serviceHttpClient.get("admin/profile", {});
      if (response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        final profileResponse = AdminProfileResponseModel.fromMap(jsonResponse);
        log("Get Admin Profile successful: ${profileResponse.message}");
        return Right(profileResponse);
      }else{
        final jsonResponse = json.decode(response.body);
        log("Get Admin Profile failed: ${jsonResponse.message}");
        return Left(jsonResponse['message'] ?? "Get Profile failed");
      }
    } catch (e){
      log("Error in getting profile: $e");
      return Left("An error occured while getting profile: $e");
    }
  }

  


}