import 'package:shipping_plugin/shipping_plugin.dart';
import 'package:shipping_plugin/src/models/shipping_address.dart';
import 'package:shipping_plugin/src/models/shipping_information_status.dart';

class ShippingInformation {
  int id;
  int shippingFee;
  ShippingAddress shippingFrom;
  ShippingAddress shippingTo;
  List<ShippingInformationStatus> listStatus;
  String providerOrderCode;
  ShipProviderService shipProviderService;
  int type;
  String orderCode;
  DateTime createdAt;
  DateTime updatedAt;

  ShippingInformation(
      {this.id,
      this.shippingFee = 0,
      this.shippingFrom,
      this.shippingTo,
      this.listStatus,
      this.providerOrderCode,
      this.shipProviderService,
      this.type,
      this.orderCode,
      this.createdAt,
      this.updatedAt});

  @override
  factory ShippingInformation.fromJSON(Map<String, dynamic> json) {
    if (json != null) {
      return new ShippingInformation(
        id: json["id"],
        shippingFee: json["shipping_fee"],
        shippingFrom: ShippingAddress.fromJSON(json["shipping_from"]),
        shippingTo: ShippingAddress.fromJSON(json["shipping_to"]),
        listStatus: List<ShippingInformationStatus>.from(
            json["status"]?.map((e) => ShippingInformationStatus.fromJSON(e))),
        providerOrderCode: json["provider_order_code"],
        shipProviderService:
            ShipProviderService.fromJSON(json["ship_provider_service"]),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'shipping_fee': shippingFee,
        'shipping_to': shippingTo.toJson(),
        'shipping_from': shippingFrom.toJson(),
        'ship_provider_service_id': shipProviderService?.id ?? null,
        'provider_order_code': providerOrderCode,
      };
}
