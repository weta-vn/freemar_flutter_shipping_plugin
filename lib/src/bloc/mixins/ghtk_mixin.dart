import 'package:shipping_plugin/src/providers/ghtk_api_provider.dart';

mixin GHTKMixin {
  GHTKApiProvider ghtkApiProvider = GHTKApiProvider();
  Map ghtk;

  Future<List> loadHamlet(
      String provinceName, String districtName, String wardName) async {
    Map params = Map();
    params['province'] = provinceName;
    params['district'] = districtName;
    params['ward_street'] = wardName;
    return await ghtkApiProvider
        .getAddressLevel4(params, {"Token": ghtk['ghtk_token']}).then((values) {
      if (values != null) {
        if (!values.contains('Khác')) {
          values.add('Khác');
        }
        return values;
      }
      return ['Khác'];
    });
  }
}
