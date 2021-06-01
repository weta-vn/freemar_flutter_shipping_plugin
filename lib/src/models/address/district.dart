class District {
  int id;
  String name;
  int provinceId;
  String ghnCode;

  District({this.id, this.name, this.provinceId, this.ghnCode});

  @override
  factory District.fromJSON(Map<String, dynamic> json) {
    if (json != null) {
      return District(
          id: json["id"],
          name: json["name"],
          provinceId: json["province_id"],
          ghnCode: json["ghn_code"]);
    }
    return null;
  }

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is District &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
