class ShipProviderEnum {
  static const int SUPERSHIP = 1;
  static const int GHN = 2;
  static const int GIAO_TAN_NOI = 3;
  static const int TU_DEN_LAY = 4;
  static const int GHTK = 5;
}

class ShippingStatusEnum {
  static const int PENDING = 1;
  static const int CREATE_SHIPPING_ORDER = 2;
  static const int PICK_UP = 3;
  static const int PICKED_UP = 4;
  static const int PICKUP_FAILED = 5;
  static const int DELIVERING = 6;
  static const int DELIVERED = 7;
  static const int DELIVER_FAILED = 8;
  static const int RETURN = 9;
  static const int RETURNED = 10;
  static const int LOST = 11;
}
