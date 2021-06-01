import 'package:shipping_plugin/shipping_plugin.dart';
import 'package:shipping_plugin/src/bloc/mixins/ghn_mixin.dart';
import 'package:shipping_plugin/src/bloc/mixins/ghtk_mixin.dart';
import 'package:shipping_plugin/src/bloc/mixins/supership_mixin.dart';
import 'package:shipping_plugin/src/models/master_data.dart';
import 'package:shipping_plugin/src/providers/ship_api_provider.dart';
import 'package:uuid/uuid.dart';

class ShippingBloc with GHTKMixin, SuperShipMixin, GHNMixin {
  ShipApiProvider _shipApiProvider = ShipApiProvider();

  ShippingBloc(Map ghn, Map superShip, Map ghtk) {
    this.ghn = ghn;
    this.superShip = superShip;
    this.ghtk = ghtk;
  }

  Future<int> calculateFee(ShippingAddress shippingFrom, ShippingAddress shippingTo, ShipProvider shipProvider,
      ShipProviderService shipProviderService, Map params) async {
    switch (shipProvider.id) {
      case ShipProviderEnum.GHN:
        int weight = (params['weight'] * 1000).round();
        Map requestParameters = {
          "from_district_id": shippingFrom.district.id,
          "service_id": null,
          "service_type_id": shipProviderService.serviceCode,
          "to_district_id": shippingTo.district.id,
          "to_ward_code": shippingTo.ward.ghnCode,
          "height": params["height"],
          "length": params["length"],
          "width": params["width"],
          'weight': weight,
          "insurance_fee": (params["price"]).ceil(),
          "coupon": null
        };
        var res = await ghnApiProvider
            .calculateFee(requestParameters, {'Token': '${ghn["ghn_token"]}', "ShopId": '${ghn["ghn_shop_default"]}'});
        if (res != null && res['code'] == 200) {
          return res['data']['total'];
        }
        return -1;
        break;
      case ShipProviderEnum.SUPERSHIP:
        Map requestParameters = {
          'receiver_province': shippingTo.province.name,
          'receiver_district': shippingTo.district.name,
          'sender_province': shippingFrom.province.name,
          'sender_district': shippingFrom.district.name,
          'weight': (params['weight'] * 1000).round(),
          'price': params['price']
        };
        var res = await superShipApiProvider.calculateFee(requestParameters);
        if (res != null && res['status'] == 'Success') {
          return res['results'][0]['fee'];
        }
        return -1;
        break;
      case ShipProviderEnum.GIAO_TAN_NOI:
        return 0;
        break;
      case ShipProviderEnum.TU_DEN_LAY:
        return 0;
        break;
      case ShipProviderEnum.GHTK:
        Map requestParameters = {
          "pick_province": shippingFrom.province.name,
          "pick_district": shippingFrom.district.name,
          "province": shippingTo.province.name,
          "district": shippingTo.district.name,
          "address": shippingTo.address,
          "weight": (params['weight'] * 1000).round(),
          "value": params['price'],
          "transport": "road"
        };
        var res = await ghtkApiProvider
            .calculateFee(requestParameters, {'Token': ghtk["ghtk_token"], 'Content-Type': 'application/json'});
        if (res != null && res['success']) {
          return res['fee']['fee'];
        }
        return -1;
        break;
      default:
        break;
    }
    return -1;
  }

  Future<ShippingInformation> getShippingInformation(int shippingId, String accessToken) {
    return _shipApiProvider.getShippingInformation({'shipping_id': shippingId, 'access_token': accessToken});
  }

  Future<ShippingInformation> updateShippingStatus(int shippingStatus, int shippingId, String accessToken) {
    return _shipApiProvider.updateShippingStatus({
      'shipping_id': shippingId,
      'shipping_status': shippingStatus,
    }, {
      'Authorization': 'Bearer $accessToken'
    });
  }

  Future<bool> setHamlet(int shippingAddressId, String hamlet, String accessToken) {
    return _shipApiProvider.setHamlet({
      'shipping_address_id': shippingAddressId,
      'hamlet': hamlet,
    }, {
      'Authorization': 'Bearer $accessToken'
    });
  }
}
