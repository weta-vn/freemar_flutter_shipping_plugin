import 'package:shipping_plugin/shipping_plugin.dart';
import 'package:shipping_plugin/src/models/shipping_address.dart';

class ShippingInformationReturn {
  int id;
  int shippingFee;
  ShippingAddress shippingAddress;
  List<ShippingInformationStatus> listStatus;
  String providerOrderCode;
  DateTime createdAt;
  DateTime updatedAt;

  ShippingInformationReturn(
      {this.id,
      this.shippingFee,
      this.shippingAddress,
      this.providerOrderCode,
      this.listStatus,
      this.createdAt,
      this.updatedAt});

  @override
  factory ShippingInformationReturn.fromJSON(Map<String, dynamic> json) {
    if (json != null) {
      return new ShippingInformationReturn(
        id: json["id"],
        shippingFee: json["shipping_fee"],
        shippingAddress: ShippingAddress.fromJSON(json["shipping_address"]),
        listStatus: List<ShippingInformationStatus>.from(json["status"]?.map((e) => ShippingInformationStatus.fromJSON(e))),
        providerOrderCode: json["provider_order_code"],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'shipping_fee': shippingFee,
    'shipping_address_id': shippingAddress.id,
    'shipping_status': listStatus?.map((s) => s.toJson())?.toList(),
//    'ship_provider_service_id': shipProviderService.id,
    'provider_order_code': providerOrderCode,
  };
}
