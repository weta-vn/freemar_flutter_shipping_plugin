import 'package:shipping_plugin/src/models/shipping_address.dart';
import 'package:shipping_plugin/src/providers/ghn_api_provider.dart';

mixin GHNMixin {
  Map ghn;
  GHNApiProvider ghnApiProvider = GHNApiProvider();
  Future<List> ghnFindAvailableServices(ShippingAddress shippingFrom, ShippingAddress shippingTo) async {
    Map requestParameters = {
      'shop_id': ghn['ghn_shop_default'],
      "from_district": shippingFrom.district.id,
      "to_district": shippingFrom.district.id
    };
    var response = await ghnApiProvider.findAvailableServices(requestParameters, {'token': ghn['ghn_token']});
    if (response != null && response["code"] == 200) {
      List<int> servicesCode = [];
      (response['data'] as List).forEach((service) {
        if (service['service_type_id'] > 0) servicesCode.add(service['service_type_id']);
      });
      return servicesCode;
    }
    return [];
  }
}
