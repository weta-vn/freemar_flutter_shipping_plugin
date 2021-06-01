class ShipPayMethod {
  int id;
  String name;
  String description;

  ShipPayMethod({this.id, this.name, this.description});

  @override
  factory ShipPayMethod.fromJSON(Map<String, dynamic> json) {
    if (json != null) {
      return new ShipPayMethod(
          id: json["id"],
          name: json["name"],
          description: json["description"]);
    }
    return null;
  }
}
