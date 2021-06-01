class ApiList {
  static const String API_GET_PROVINCE = "get_province";
  static const String API_GET_DISTRICT = "get_district";
  static const String API_GET_WARD = "get_ward";
  static const String API_GET_SHIPPING_INFORMATION = "get_shipping_information";
  static const String API_UPDATE_SHIPPING_STATUS = "update_shipping_status";
  static const String API_SET_HAMLET = "set_hamlet";
  static const String API_CREATE_GHN_SHOP = "create_ghn_shop";

  ///GHN
  static const String API_GHN_CALCULATE_FEE = "shipping-order/fee";
  static const String API_GHN_CREATE_ORDER = "shipping-order/create";
  static const String API_GHN_CREATE_STORE = "shop/register";
  static const String API_GHN_FIND_AVAILABLE_SERVICES =
      'shipping-order/available-services';

  ///SUPER SHIP
  static const String API_SUPERSHIP_CALCULATE_FEE = "orders/fee";
  static const String API_SUPERSHIP_CREATE_ORDER = "orders/add";
  static const String API_SUPERSHIP_GET_PROVINCE = "areas/province";
  static const String API_SUPERSHIP_GET_DISTRICT = "areas/district";
  static const String API_SUPERSHIP_GET_COMMUNE = "areas/commune";

  ///GHTK
  static const String API_GHTK_CALCULATE_FEE = "shipment/fee";
  static const String API_GHTK_CREATE_ORDER = "shipment/order";
  static const String API_GHTK_GET_ADDRESS_LEVEL_4 = "address/getAddressLevel4";
}
