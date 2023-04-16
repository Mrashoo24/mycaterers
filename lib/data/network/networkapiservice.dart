import 'dart:convert';
import 'dart:io';

import 'package:mycaterers/data/network/baseapiservice.dart';
import 'package:http/http.dart' as http;

import '../appexception.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getResponse(String? url) async {

    dynamic responseJson ;
    try {
      http.Response response  = await  http.get(Uri.parse(url!)).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet");
    }



    return responseJson;
  }

  @override
  Future postResponse(String? url) {
    // TODO: implement postResponse
    throw UnimplementedError();
  }


  dynamic returnResponse (http.Response response){
      switch(response.statusCode){
        case 200:
          dynamic responsejson = jsonDecode(response.body);
          return responsejson;
        case 400:
          throw BadRequestException("Something went wrong ${response.statusCode}");
        default:
          throw FetchDataException( "Error while communicating with server StatusCode: ${response.statusCode}");

      }
  }

}