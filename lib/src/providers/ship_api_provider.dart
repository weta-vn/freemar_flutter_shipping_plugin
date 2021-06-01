import 'package:shipping_plugin/shipping_plugin.dart';
import 'package:shipping_plugin/src/providers/api_list.dart';
import 'package:shipping_plugin/src/providers/api_provider.dart';

class ShipApiProvider extends ApiProvider {
  ShipApiProvider() : super() {
    apiUrlSuffix = "/ship";
  }

  Future<ShippingInformation> getShippingInformation(Map params) async {
    var jsonData =
        await this.getData(ApiList.API_GET_SHIPPING_INFORMATION, params);
    if (jsonData["status"]) {
      return ShippingInformation.fromJSON(jsonData["data"]);
    }
    throw Exception(jsonData["message"]);
  }

  Future<ShippingInformation> updateShippingStatus(
      Map params, Map<String, String> headers) async {
    var jsonData = await this
        .postData(ApiList.API_UPDATE_SHIPPING_STATUS, params, headers: headers);
    if (jsonData["status"]) {
      return ShippingInformation.fromJSON(jsonData["data"]);
    }
    throw Exception(jsonData["message"]);
  }

  Future<bool> setHamlet(Map params, Map<String, String> headers) async {
    var jsonData =
        await this.postData(ApiList.API_SET_HAMLET, params, headers: headers);
    if (jsonData["status"]) {
      return true;
    }
    return false;
  }

  Future<bool> createGhnShop(
      String accessToken, int shippingAddressId, int ghnShopId) async {
    var jsonData = await this.postData(ApiList.API_CREATE_GHN_SHOP,
        {'shipping_address_id': shippingAddressId, 'ghn_shop_id': ghnShopId},
        headers: {'Authorization': 'Bearer $accessToken'});
    if (jsonData["status"]) {
      return true;
    }
    throw Exception(jsonData["message"]);
  }
}
