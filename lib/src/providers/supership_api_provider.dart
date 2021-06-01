import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shipping_plugin/src/providers/api_list.dart';

import 'api_provider.dart';

class SuperShipApiProvider extends ApiProvider {
  SuperShipApiProvider() : super() {
    if (kReleaseMode)
      apiBaseUrl = "https://api.mysupership.vn";
    else
      apiBaseUrl = "https://api.mysupership.xyz";
    apiVersion = "v1/partner";
  }

  Future<dynamic> calculateFee(Map params) {
    return this.getData(ApiList.API_SUPERSHIP_CALCULATE_FEE, params);
  }

  // Future<dynamic> getProvince(Map params) async {
  //   return this.getData(ApiList.API_SUPERSHIP_GET_PROVINCE, params);
  // }
  //
  // Future<dynamic> getDistrict(Map params) async {
  //   return this.getData(ApiList.API_SUPERSHIP_GET_DISTRICT, params);
  // }
  //
  // Future<dynamic> getCommune(Map params) async {
  //   return this.getData(ApiList.API_SUPERSHIP_GET_COMMUNE, params);
  // }
}
