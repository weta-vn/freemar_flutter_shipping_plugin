///Status for shipping and return shipping
import 'package:shipping_plugin/src/models/shipping_status.dart';

class ShippingInformationStatus {
  int id;
  ShippingStatus shippingStatus;
  DateTime createdAt;
  DateTime updatedAt;

  ShippingInformationStatus({
    this.id,
    this.shippingStatus,
    this.createdAt,
    this.updatedAt
});

  @override
  factory ShippingInformationStatus.fromJSON(Map<String, dynamic> json) {
    if (json != null) {

      return new ShippingInformationStatus(
        id: json["id"].runtimeType == 'String' ? int.tryParse(json['id']) : json['id'],
        shippingStatus: ShippingStatus.fromJSON(json['status']),
        createdAt: DateTime.parse(json["created_at"]??DateTime.now()),
        updatedAt: DateTime.parse(json["updated_at"]??DateTime.now()),

      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'master_shipping_status_id': shippingStatus.id,
  };
}