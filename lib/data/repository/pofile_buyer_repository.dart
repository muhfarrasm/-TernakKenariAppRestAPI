import 'package:canary_app/data/model/request/admin/induk_request_model.dart';
import 'package:canary_app/data/model/request/buyer/buyer_profile_request_model.dart';
import 'package:canary_app/data/model/response/buyer/buyer_profile_response_model.dart';
import 'package:canary_app/data/model/response/get_all_induk_response.dart';
import 'package:canary_app/service/service_http_client.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';


class PofileBuyerRepository {
  final ServiceHttpClient _serviceHttpClient;

  PofileBuyerRepository(this._serviceHttpClient);

  Future<Either<String, BuyerProfileResponseModel>> addProfileBuyer(
    BuyerProfileRequestModel requestModel,
  )async {
    try{
      final response = await _serviceHttpClient.postWithToken(
        "buyer/profile", 
        requestModel.toJson(),
      );

      if (response.statusCode == 201){
        final jsonResponse = json.decode(response.body);
        final profilResponse = BuyerProfileResponseModel.fromJson(jsonResponse);
        return Right(profilResponse);
      }else{
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message']?? 'Unknow error occured');
      }
    }catch (e) {
      return Left("An error occured while adding induk: $e");
    }
  }
}