class Province {
  int id;
  String name;
  String ghnCode;

  Province({this.id, this.name, this.ghnCode});

  @override
  factory Province.fromJSON(Map<String, dynamic> json) {
    if (json != null) {
      return Province(
          id: json["id"], name: json["name"], ghnCode: json["ghn_code"]);
    }
    return null;
  }

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is Province &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
