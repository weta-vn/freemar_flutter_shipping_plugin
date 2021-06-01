import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shipping_plugin/src/providers/api_list.dart';

import 'api_provider.dart';

class GHTKApiProvider extends ApiProvider {
  GHTKApiProvider() : super() {
    if (kReleaseMode)
      apiBaseUrl = "https://services.giaohangtietkiem.vn";
    else
      apiBaseUrl = "https://khachhang.ghtklab.com";
    apiVersion = "services";
  }

  Future<dynamic> calculateFee(Map params, Map<String, String> headers) {
    return this.getData(ApiList.API_GHTK_CALCULATE_FEE, params, headers: headers);
  }

  Future<dynamic> createOrder(Map params, Map<String, String> headers) {
    return this.postData(ApiList.API_GHTK_CREATE_ORDER, params, headers: headers);
  }

  Future<List> getAddressLevel4(Map params, Map<String, String> headers) async {
    Map response = await this.getData(ApiList.API_GHTK_GET_ADDRESS_LEVEL_4, params, headers: headers);
    if (response != null && response['success']) {
      return response['data'];
    }
    return null;
  }
}
