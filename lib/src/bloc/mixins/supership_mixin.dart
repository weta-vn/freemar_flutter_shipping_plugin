import 'package:shipping_plugin/src/providers/supership_api_provider.dart';

mixin SuperShipMixin {
  SuperShipApiProvider superShipApiProvider = SuperShipApiProvider();
  Map superShip;

  Future<bool> checkSupportedAddress(String senderProvince,
      String senderDistrict, double weight, double price) async {
    String receiverProvince = "Thành phố Hà Nội";
    String receiverDistrict = "Quận Hai Bà Trưng";
    Map requestParameters = {
      'receiver_province': receiverProvince,
      'receiver_district': receiverDistrict,
      'sender_province': senderProvince,
      'sender_district': senderDistrict,
      'weight': (weight * 1000).round(),
      'price': price
    };
    var res = await superShipApiProvider.calculateFee(requestParameters);
    if (res != null && res['status'] == 'Success') {
      return true;
    }
    return false;
  }
}
