
import 'dart:convert';
import 'dart:developer';
import 'package:canary_app/data/model/request/admin/posting_jual_request_model.dart';
import 'package:canary_app/data/model/response/burung_semua_tersedia_model.dart';
import 'package:canary_app/service/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PostingRepository {
  final ServiceHttpClient _serviceHttpClient;
  PostingRepository(this. _serviceHttpClient);


  Future<Either<String, BurungSemuaTersediabyIdModel>>addPostBurung(
    PostingJualRequestModel requestModel,
  )async{
    try{
      final response = await _serviceHttpClient.postWithToken(
        'admin/posting-jual',
        requestModel.toJson(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201){
        final profileResponse = BurungSemuaTersediabyIdModel.fromJson(
          jsonResponse,
        );
        log("Add Burung successful: ${profileResponse.message}");
        return Right(profileResponse);
      }else{
        log("Add Burung failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Ad burung failed");
      }
    }catch(e){
      log("Error in add burung : $e");
      return Left("An error occurred while post burung: $e");
    }
  }
}