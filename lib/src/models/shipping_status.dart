///Master data shipping status
class ShippingStatus {
  int id;
  String name;
  String comment;

  ShippingStatus({this.id, this.name, this.comment});

  @override
  factory ShippingStatus.fromJSON(Map<String, dynamic> json) {
    if (json != null) {
      return new ShippingStatus(
          id: json["id"].runtimeType == 'String' ? int.tryParse(json['id']) : json['id'] , name: json["name"], comment: json["comment"]);
    }
    return null;
  }
}
