import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:willow/model/doctor_info_model.dart';
import 'package:willow/model/schedule_model.dart';
import 'apis_url.dart';

enum RequestType { post, get, put, delete }

class ApiProvider {
  var _headers = {
    'Content-Type': 'application/json',
  };

  var _headersWithToken = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer \$accessToken'
  };

  initialHeader() {
    _headers = {
      'Content-Type': 'application/json',
    };

    _headersWithToken = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer \$accessToken '
    };
  }

  /// This function instead of _dataLoader() function to get response like mock API
  Future<String> _loadAsset(String name) async {
    try {
      print('jsonFiles/${name}.json');
      return await rootBundle.loadString('assets/jsonFiles/${name}.json');
    } catch (e) {
      print('ghfhgfhg  ' + e.toString());
      return '';
    }
  }

  ///The main function to get API response
  _dataLoader(RequestType requestType, String url,
      {Map<String, dynamic>? body,
      bool isFormData = false,
      bool isNeedToken = false,
      headerOp}) async {
    if (kDebugMode) {
      print(url);
    }
    Response<dynamic> response;
    if (requestType == RequestType.post || requestType == RequestType.put) {
      try {
        log('body: ${json.encode(body)}');
      } catch (e) {
        if (kDebugMode) {
          print('error: $e');
        }
      }

      response = await _dioRequest(url, body!,
          isFormData: isFormData,
          requestType: requestType,
          header: (headerOp != null)
              ? headerOp
              : ((isNeedToken) ? _headersWithToken : _headers));
    } else {
      response = await _dioGetRequest(url,
          header: (headerOp != null)
              ? headerOp
              : ((isNeedToken) ? _headersWithToken : _headers));
    }

    // log('response: ${response.toString()}');

    if (kDebugMode) {
      print('status code: ${response.statusCode}');
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.toString();
    } else if (response.statusCode == 401) {
      if (kDebugMode) {
        print('No auth ${response.statusCode}');
      }
      Fluttertoast.showToast(msg: 'You should login again');
    } else {
      if (kDebugMode) {
        print('response: ${response.data['message']}');
      }
      String msg = response.data['message'] ?? 'Something went wrong';
      Fluttertoast.showToast(msg: msg);

      return '';
    }
  }

  _dioRequest(String url, Map<String, dynamic> body,
      {Map<String, String>? header,
      bool isFormData = false,
      RequestType requestType = RequestType.post}) async {
    var dio = Dio();
    header ??= _headers;
    if (kDebugMode) {
      print('headers: ${json.encode(header)}');
    }

    try {
      var _formData = FormData.fromMap(body);
      if (isFormData) {
        if (kDebugMode) {
          print('form data: ${_formData.fields}');
        }
      }
      Response response;
      if (requestType == RequestType.put) {
        response = await dio.put(url,
            data: isFormData ? _formData : json.encode(body),
            options: Options(headers: header, responseType: ResponseType.json));
      } else {
        response = await dio.post(url,
            data: isFormData ? _formData : json.encode(body),
            options: Options(headers: header, responseType: ResponseType.json));
      }
      if (kDebugMode) {
        print('response: ${response.data}');
      }
      return response;
    } on DioError catch (error) {
      String status = '${error.response?.statusCode ?? ''}';
      Fluttertoast.showToast(msg: 'No connection $status');
      if (kDebugMode) {
        print('error: ${error.response?.statusCode}');
        print('error response: ${error.response}');
      }

      if (error.response != null) {
        return error.response;
      } else {
        if (error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.sendTimeout ||
            error.type == DioErrorType.receiveTimeout) {}
        if (kDebugMode) {
          print('error: ${error.error}');
        }
      }
    }
  }

  _dioGetRequest(String url, {required Map<String, String> header}) async {
    var dio = Dio();
    header = {'Content-Type': 'application/json', 'accept': 'application/json'};
    if (kDebugMode) {
      print('headers: ${json.encode(header)}');
    }

    try {
      final response = await dio.get(url,
          options: Options(headers: header, responseType: ResponseType.json));
      if (kDebugMode) {
        print('response: ${response.data}');
      }
      return response;
    } on DioError catch (error) {
      Fluttertoast.showToast(msg: 'noConnection');

      if (kDebugMode) {
        print('error request:-- $error');
        print('error response: ${error.response}');
      }

      if (error.response != null) {
        return error.response;
      } else {
        if (error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.sendTimeout ||
            error.type == DioErrorType.receiveTimeout) {}
        if (kDebugMode) {
          print('request error: ${error.error}');
        }
      }
    }
  }

  Future<ScheduleModel> getAppointments() async {
    /*
    ///Todo: When API is ready from backend side will call the following below function
    var response = await _dataLoader(
      RequestType.get,
      APIsUrl.schedule,
    );
    */

    var response = await _loadAsset('schedule');

    if (kDebugMode) {
      print('response---: $response');
    }

    return ScheduleModel.fromJson(jsonDecode(response));
  }

  Future<DoctorInfoModel> getDoctorInfo(int id) async {
    /*
    ///Todo: When API is ready from backend side will call the following below function
    var response = await _dataLoader(
      RequestType.get,
      APIsUrl.schedule,
    );
    */

    var response = await _loadAsset('info$id');

    if (kDebugMode) {
      print('response---: $response');
    }

    return DoctorInfoModel.fromJson(jsonDecode(response));
  }
}

final apiProvider = ApiProvider();
