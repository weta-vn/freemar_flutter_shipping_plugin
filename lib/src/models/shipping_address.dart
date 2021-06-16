import 'package:shipping_plugin/shipping_plugin.dart';
import 'package:shipping_plugin/src/models/address/district.dart';
import 'package:shipping_plugin/src/models/address/province.dart';
import 'package:shipping_plugin/src/models/address/ward.dart';

class ShippingAddress {
  int id;
  String name;
  String address;
  String phoneNumber;
  Province province;
  District district;
  Ward ward;
  String hamlet;
  int ghnShopId;

  ShippingAddress(
      {this.id,
      this.name,
      this.address,
      this.phoneNumber,
      this.province,
      this.district,
      this.ward,
      this.hamlet,
      this.ghnShopId});

  @override
  factory ShippingAddress.fromJSON(Map<String, dynamic> json) {
    if (json != null) {
      return new ShippingAddress(
          id: json["id"],
          name: json["name"],
          address: json["address"],
          phoneNumber: json["phone_number"],
          province: Province.fromJSON(json["province"]),
          district: District.fromJSON(json["district"]),
          ward: Ward.fromJSON(json["ward"]),
          hamlet: json['hamlet'],
          ghnShopId: json["ghn_shop_id"]);
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'phone_number': phoneNumber,
        'province_id': province.id,
        'district_id': district.id,
        'ward_id': ward.id,
        'hamlet': hamlet,
        'ghn_shop_id': ghnShopId
      };

  @override
  String toString() {
    return "$name, $address, ${province.name}, ${district.name}, ${ward.name}";
  }

  String toAddress(int shippingProviderId) {
    if (shippingProviderId == ShipProviderEnum.GIAO_TAN_NOI || shippingProviderId == ShipProviderEnum.TU_DEN_LAY) {
      return "$name - $phoneNumber \n$address, ${province.name}, ${district.name}, ${ward.name}";
    }
    return "$name, $address, ${province.name}, ${district.name}, ${ward.name}";
  }
}
