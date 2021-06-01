import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shipping_plugin/src/providers/api_list.dart';
import 'api_provider.dart';

class GHNApiProvider extends ApiProvider {
  GHNApiProvider() : super() {
    if (kReleaseMode)
      apiBaseUrl = "https://online-gateway.ghn.vn/shiip/public-api";
    else
      apiBaseUrl = "https://dev-online-gateway.ghn.vn/shiip/public-api";
    apiVersion = "v2";
  }

  Future<dynamic> calculateFee(Map params, Map<String, String> headers) {
    return this.postData(ApiList.API_GHN_CALCULATE_FEE, params, headers: headers);
  }

  Future<dynamic> findAvailableServices(Map params, Map<String, String> headers) {
    return this.postData(ApiList.API_GHN_FIND_AVAILABLE_SERVICES, params, headers: headers);
  }
}
