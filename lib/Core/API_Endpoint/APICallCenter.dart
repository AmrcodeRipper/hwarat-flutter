
import 'dart:developer';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import '../APP/Utils.dart';
import '../APP/config.dart';
import '../Models/DataModels.dart';


class ApiCall {

  static final dio = Dio(
      BaseOptions(
    baseUrl: "https://api.openai.com",
    connectTimeout: const Duration(seconds: 10),
    //receiveTimeout: const Duration(seconds: 30),
    //contentType: 'application/json',
  )
  );


  static int dioExceptionHandler(DioException e){
    switch(e.type){
      case DioExceptionType.connectionTimeout:
        return -101;
      case DioExceptionType.sendTimeout:
        return -102;
      case DioExceptionType.receiveTimeout:
        return -103;
      case DioExceptionType.badCertificate:
        return -104;
      case DioExceptionType.badResponse:
        return -105;
      case DioExceptionType.cancel:
        return -106;
      case DioExceptionType.connectionError:
        return -107;
      case DioExceptionType.unknown:
        return -108;
      default:
        return -100;
    }
  }

  static Future<DetailedAPIResponse> apiRequestTemplate(
      {required String url, dynamic data, required Options options, Function(int, int)? onSendProgress , Function(int, int)? onReceiveProgress,dynamic queryParameters,CancelToken? cancelToken,}) async {
    Response? response;
    try{
      response = await dio.request(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken
      );
    }
    catch(e){
      if (e is DioException) {
        //handle DioError here by error type or by error code
        if (kDebugMode) {
          print("API Request Template $url");
          print(e.response?.statusCode ?? -3);
          print(e.message);
          print(e.response?.data);
          print(e.response?.statusMessage);
        }
        return DetailedAPIResponse(
            overriddenResponseCode: e.response?.statusCode ?? -3 ,
            dioException: e,
            showAPIMessage: Utils.getDebugging(),
            messageFromAPI: Utils.parseErrorAPIMessage(e.response),
            response: e.response
        );
      }
    }

    return DetailedAPIResponse(
        overriddenResponseCode: response?.statusCode ?? -3 ,
        showAPIMessage: Utils.getDebugging(),
        messageFromAPI: Utils.parseSuccessAPIMessage(response),
        response: response
    );
  }

  static Future<DetailedAPIResponse> apiIBMRequestTemplate(
      {required String baseUrl, required String url, dynamic data, required Options options, Function(int, int)? onSendProgress , Function(int, int)? onReceiveProgress,dynamic queryParameters,CancelToken? cancelToken,}) async {

    final iBMDio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          //receiveTimeout: const Duration(seconds: 30),
          //contentType: 'application/json',
        )
    );

    Response? response;
    try{
      response = await iBMDio.request(
          url,
          data: data,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken
      );
    }
    catch(e){
      if (e is DioException) {
        //handle DioError here by error type or by error code
        if (kDebugMode) {
          print("API Request Template $url");
          print(e.response?.statusCode ?? -3);
          print(e.message);
          print(e.response?.data);
          print(e.response?.statusMessage);
        }
        return DetailedAPIResponse(
            overriddenResponseCode: e.response?.statusCode ?? -3 ,
            dioException: e,
            showAPIMessage: Utils.getDebugging(),
            messageFromAPI: Utils.parseErrorAPIMessage(e.response),
            response: e.response
        );
      }
    }

    return DetailedAPIResponse(
        overriddenResponseCode: response?.statusCode ?? -3 ,
        showAPIMessage: Utils.getDebugging(),
        messageFromAPI: Utils.parseSuccessAPIMessage(response),
        response: response
    );
  }

  static Future<DetailedAPIResponse> getAssistance() async {

    DetailedAPIResponse detailedResponse = await apiRequestTemplate(
        url: '/v1/assistants/asst_S3Xe4WwpUHkGHrxSNAcCM1X2',
        options: Options(method: 'GET',responseType: ResponseType.json,headers: Map.fromEntries([Utils.getDefaultHeader(),Utils.openAIBetaHeader()]))
    );


    if(detailedResponse.response?.data != null && detailedResponse.response?.statusCode! == 200){
      try{
        //APP.user.value = User.fromJson(detailedResponse.response?.data);
        //APP.user.value?.password = password;
      }
      catch(e){
        if (kDebugMode) {
          print(e);
        }
        return DetailedAPIResponse(
            overriddenResponseCode: -2,
            showAPIMessage: Utils.getDebugging(),
            messageFromAPI: "API_Errors".tr(gender: "parsing"),
        );
      }
    }

    return detailedResponse;
  }

  static Future<DetailedAPIResponse> createThread() async {

    DetailedAPIResponse detailedResponse = await apiRequestTemplate(
        url: '/v1/threads',
        options: Options(method: 'post',responseType: ResponseType.json,headers: Map.fromEntries([Utils.getDefaultHeader(),Utils.openAIBetaHeader()]))
    );


    if(detailedResponse.response?.data != null && detailedResponse.response?.statusCode! == 200){
      APP.threadID = detailedResponse.response?.data['id'];
      print(APP.threadID);
    }

    return detailedResponse;
  }

  static Future<DetailedAPIResponse> createMessageForThread(String message) async {

    if(APP.threadID == null){
      return DetailedAPIResponse(overriddenResponseCode: 404);
    }

    DetailedAPIResponse detailedResponse = await apiRequestTemplate(
        url: 'https://api.openai.com/v1/threads/${APP.threadID}/messages',
        data: {
        "role": "user",
        "content": message
        },
        options: Options(method: 'post',responseType: ResponseType.json,headers: Map.fromEntries([Utils.getDefaultHeader(),Utils.openAIBetaHeader()]))
    );


    if(detailedResponse.response?.data != null && detailedResponse.response?.statusCode! == 200){
      print(APP.threadID);
    }

    return detailedResponse;
  }

  static Future<Stream?> runTheThreadStream() async {

    DetailedAPIResponse detailedResponse = await apiRequestTemplate(
        url: 'https://api.openai.com/v1/threads/${APP.threadID}/runs',
        data: {
          "assistant_id": "asst_S3Xe4WwpUHkGHrxSNAcCM1X2",
          "stream" : true
        },
        options: Options(method: 'post',responseType: ResponseType.stream,headers: Map.fromEntries([Utils.getDefaultHeader(),Utils.openAIBetaHeader()]))
    );


    Stream? str;


    if(detailedResponse.response?.statusCode == 200){
      str = detailedResponse.response?.data.stream;
    }
    else{
      return null;
    }

    if (kDebugMode) {
      print(detailedResponse.response?.data);
    }

    return str;

  }

  static Future<DetailedAPIResponse> generateIBMToken() async {

    DetailedAPIResponse detailedResponse = await apiIBMRequestTemplate(
      baseUrl: 'https://iam.cloud.ibm.com/',
        url: 'identity/token?',
        queryParameters: {
        "grant_type" : "urn:ibm:params:oauth:grant-type:apikey",
          "apikey" : "z1VXX9VRFl-AIsz_4g5dyJPnOLRwKITbL70atEjf7WxY"
        },
        options: Options(method: 'post',responseType: ResponseType.json)
    );


    if(detailedResponse.response?.data != null && detailedResponse.response?.statusCode! == 200){
      APP.iBMToken = detailedResponse.response?.data['access_token'];
      print('IBM token ${APP.iBMToken}');
    }

    return detailedResponse;
  }

  static Future<DetailedAPIResponse> askAllam({required String prompt}) async {

    DetailedAPIResponse detailedResponse = await apiIBMRequestTemplate(
        baseUrl: 'https://eu-de.ml.cloud.ibm.com/ml/v1/text',
        url: '/generation?',
        queryParameters: {
          "version" : "2023-05-29",
        },
        data: {
          "input": prompt, //"<s> [INST]  السلام عليكم ورحمة الله هل تستطيع التشكيل و إذا كان الجواب نعم حقاً فأين التشكيل في سؤالي راجع جوابك وأخبرني بها [/INST]",
          "parameters": {
            "decoding_method": "greedy",
            "max_new_tokens": 1024,
            "min_new_tokens": 0,
            "stop_sequences": [],
            "repetition_penalty": 1
          },
          "model_id": "sdaia/allam-1-13b-instruct",
          "project_id": "cee580eb-7dc1-47a2-8ed7-4bc7f9cfd521"
        },
        options: Options(method: 'post',responseType: ResponseType.json, headers: {"Authorization" : "Bearer ${APP.iBMToken}"})
    );


    if(detailedResponse.response?.data != null && detailedResponse.response?.statusCode! == 200){
      //APP.iBMToken = detailedResponse.response?.data['access_token'];
      print('IBM token ${APP.iBMToken}');
    }

    return detailedResponse;
  }


  //@Depreciated
  static Future<DetailedAPIResponse> runTheThread() async {

    DetailedAPIResponse detailedResponse = await apiRequestTemplate(
        url: 'https://api.openai.com/v1/threads/${APP.threadID}/runs',
        data: {
          "assistant_id": "asst_poZKiWjTy0fNyeAYdzPPklbH",
          "stream" : true
        },
        options: Options(method: 'post',responseType: ResponseType.stream,headers: Map.fromEntries([Utils.getDefaultHeader(),Utils.openAIBetaHeader()]))
    );

    if(detailedResponse.response?.data != null && detailedResponse.response?.statusCode! == 200){
      APP.threadID = detailedResponse.response?.data['id'];
      print(APP.threadID);
    }

    return detailedResponse;


  }


}

class PurchaseParams{}