import 'package:canary_app/data/model/request/admin/induk_request_model.dart';
import 'package:canary_app/data/model/response/get_all_induk_response.dart';
import 'package:canary_app/service/service_http_client.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';


class IndukRepository {
  final ServiceHttpClient _serviceHttpClient;

  IndukRepository(this._serviceHttpClient);

  Future<Either<String, GetIndukById>> addInduk(
    IndukRequestModel requestModel,
  )async {
    try{
      final response = await _serviceHttpClient.postWithToken(
        "admin/induk", 
        requestModel.toJson(),
      );

      if (response.statusCode == 201){
        final jsonResponse = json.decode(response.body);
        final profilResponse = GetIndukById.fromJson(jsonResponse);
        return Right(profilResponse);
      }else{
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message']?? 'Unknow error occured');
      }
    }catch (e) {
      return Left("An error occured while adding induk: $e");
    }
  }

  Future<Either<String, GetAllIndukModel>>getAllInduk() async{
    try {
      final response = await _serviceHttpClient.get("admin/profile", {});
      if (response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        final profileResponse = GetAllIndukModel.fromJson(jsonResponse);
        return Right(profileResponse);
      }else{
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? "Get Profile failed");
      }
    } catch (e){
      return Left("An error occured while getting All Induk: $e");
    }
  }


}