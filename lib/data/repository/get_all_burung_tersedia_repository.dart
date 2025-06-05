import 'dart:io';

import 'package:canary_app/data/model/response/burung_semua_tersedia_model.dart';
import 'package:canary_app/service/service_http_client.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';


class GetAllBurungTersediaRepository {
  final ServiceHttpClient httpClient;

  GetAllBurungTersediaRepository(this.httpClient);

  Future<Either<String, BurungSemuaTersediaModel>> getAllBurungTersedia()async {
    try{
      final response = await httpClient.get(
        "buyer/burung-semua-tersedia",{});

      if (response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        final burungTersediaResponse = BurungSemuaTersediaModel.fromJson(jsonResponse);
        return Right(burungTersediaResponse);
      }else{
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message']?? 'Unknow error occured');
      }
    }catch (e) {
      if (e is SocketException){
        return Left("No Internet connection");
      }else if (e is HttpException){
        return Left("HTTP error: ${e.message}");
      }else if (e is FormatException){
        return Left("Invalid response format");
      }else{
        return Left("An unexcepcted error occurred : $e");

      }
    }
  }
}