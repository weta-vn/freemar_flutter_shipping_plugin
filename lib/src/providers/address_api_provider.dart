import 'package:shipping_plugin/src/models/address/district.dart';
import 'package:shipping_plugin/src/models/address/province.dart';
import 'package:shipping_plugin/src/models/address/ward.dart';
import 'package:shipping_plugin/src/providers/api_list.dart';
import 'package:shipping_plugin/src/providers/api_provider.dart';

class AddressApiProvider extends ApiProvider {
  AddressApiProvider() : super() {
    apiUrlSuffix = "/address";
  }

  Future<List<Province>> getProvince() async {
    var jsonData = await this.getData(ApiList.API_GET_PROVINCE, null, cache: true);

    if (jsonData != null) {
      return List<Province>.from(jsonData['data'].map((e) => Province.fromJSON(e)));
    }
    return null;
  }

  Future<List<District>> getDistrict(Map params) async {
    var jsonData = await this.getData(ApiList.API_GET_DISTRICT, params);

    if (jsonData != null) {
      return List<District>.from(jsonData['data'].map((e) => District.fromJSON(e)));
    }
    return null;
  }

//  Future<List<Street>> getStreet(Map params) async {
//    var jsonData = await this.getData(ApiList.API_GET_STREET, params);
//
//    if (jsonData != null) {
//      return new List<Street>.from(
//          jsonData['data'].map((e) => Street.fromJSON(e)));
//    }
//
//    return null;
//  }

  Future<List<Ward>> getWard(Map params) async {
    var jsonData = await this.getData(ApiList.API_GET_WARD, params);

    if (jsonData != null) {
      return new List<Ward>.from(jsonData['data'].map((e) => Ward.fromJSON(e)));
    }

    return null;
  }
}
