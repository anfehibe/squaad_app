import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:squaad_app/config/constants/environment.dart';
import 'package:squaad_app/presentation/shared/toast.dart';

import '../entities/license.dart';

class SquaadApiProvider {
  static final String baseUrl = Environment.squaadUrl;
  static final String bearer = Environment.bearerToken;
/*   static final dio = Dio(
    BaseOptions(baseUrl: baseUrl, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $bearer"
    }),
  ); */
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode.toString()[0] == "5") {
      showErrorToast("Server Error");
    }

    if (response.statusCode == 406 ||
        response.statusCode == 422 ||
        response.statusCode == 400 ||
        response.statusCode == 404) {
      showToastResponseError(response);
      // navigateToHome(context);
    }
    return json.decode(response.body);
  }

  static showToastResponseError(http.Response response) {
    Map body = json.decode(response.body);
    String error = "";
    if (body.containsKey("errors")) {
      body["errors"].keys.forEach((key) {
        var value = body["errors"][key];
        if (value is List) {
          for (var element in value) {
            error += element + "";
          }
        } else {
          error += value + "";
        }
      });
      showErrorToast(error);
    } else {
      showErrorToast("An error occurred");
    }
  }

  static Future<Map<String, dynamic>> doGet(String path) async {
    final String endpoint = '$baseUrl$path';
    final response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearer',
    });
    debugPrint(endpoint);
    return _handleResponse(response);
  }

  static Future<License?> getLicenceData(String license) async {
    var response = await doGet('boards/findByLicense?license=$license');

    if (response.containsKey("errors")) {
      return null;
    } else {
      var licenseResponse = License.fromJson(response);
      return licenseResponse;
    }
  }
}
