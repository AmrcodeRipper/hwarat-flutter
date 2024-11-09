


import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../API_Endpoint/APICallCenter.dart';
import '../APP/Utils.dart';
import '../APP/config.dart';



class DetailedAPIResponse{

  int overriddenResponseCode;
  bool showAPIMessage = APP.debugging;
  DioException? dioException;
  String? get errorMessage {
    return Utils.responseAnalyzer(overriddenResponseCode);
  }
  dynamic messageFromAPI;
  Response? response = Response(requestOptions: RequestOptions());
  String get uiMessage {
    //old condition considers APP.debugging to show API message!(showAPIMessage) && messageFromAPI != Utils.failedToGetMessageFromAPI
    //but now the API message will be shown always unless there is an error parsing it or if the api didn't send it in the expected format or didn't send it at all, in this case the message will be based on response status code only
    if( messageFromAPI != Utils.failedToGetMessageFromAPI){
      return messageFromAPI.toString() ?? "Fatal Error";
    }
    else{
      return errorMessage ?? "Fatal Error 1010";
    }
  }

  DetailedAPIResponse({required this.overriddenResponseCode, this.showAPIMessage = false, this.dioException, this.messageFromAPI, this.response});

  DetailedAPIResponse copyWith({required responseCode,showAPIMessage,dioException,messageFromAPI,response}){
    return DetailedAPIResponse(
        overriddenResponseCode: responseCode ?? overriddenResponseCode,
        showAPIMessage: showAPIMessage ?? this.showAPIMessage,
        dioException: dioException ?? this.dioException,
        messageFromAPI: messageFromAPI ?? this.messageFromAPI,
        response: response ?? this.response
    );
  }

}








abstract class DataPagesController<T>{

  ValueNotifier<bool>  loadingStatus = ValueNotifier<bool>(false);


  bool alreadyInitialized = false;
  int currentPage = 1;
  int totalPages = 1;
  bool hasNext = false;
  bool loading = false;
  int dataLength = 0;


  //Parsed models
  List<T> listOfParsedData = <T>[];

  //Full response, filled by ApiCall function
  List<dynamic> rawData = [];


  reset();
  refreshParent();
  defaultLoader();
  loadMore();
  init();

}










extension ForRoutes on BuildContext{
  toHome(HomeExtra extra)=>pushNamed('/',extra: extra);
}




class HomeExtra {}



