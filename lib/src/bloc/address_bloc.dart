import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shipping_plugin/src/models/address/district.dart';
import 'package:shipping_plugin/src/models/address/province.dart';
import 'package:shipping_plugin/src/models/address/ward.dart';
import 'package:shipping_plugin/src/providers/address_api_provider.dart';

class AddressBloc {
  final _addressApiProvider = AddressApiProvider();

  /// Province
  PublishSubject<List<Province>> _provinceController = PublishSubject<List<Province>>();
  Stream<List<Province>> get streamProvince => _provinceController.stream;
  Sink<List<Province>> get provinceSink => _provinceController.sink;

  /// District
  PublishSubject<List<District>> _districtController = PublishSubject<List<District>>();
  Stream<List<District>> get streamDistrict => _districtController.stream;
  Sink<List<District>> get districtSink => _districtController.sink;

  /// Ward
  PublishSubject<List<Ward>> _wardController = PublishSubject<List<Ward>>();
  Stream<List<Ward>> get streamWard => _wardController.stream;
  Sink<List<Ward>> get wardSink => _wardController.sink;

  ///Hamlet
//  PublishSubject<List> _hamletController = PublishSubject<List>();
//  Stream<List> get streamHamlet => _hamletController.stream;
//  Sink<List> get hamletSink => _hamletController.sink;

  /// Load
  PublishSubject<bool> _loadController = PublishSubject<bool>();

  Stream<bool> get streamLoad => _loadController.stream;

  Sink<bool> get loadSink => _loadController.sink;

  AddressBloc({insertAllProvinces = false}) {
    loadSink.add(true);
    _addressApiProvider.getProvince().then((values) {
      if (!_provinceController.isClosed) {
        if (insertAllProvinces) values.insert(0, Province(id: 0, name: 'Tất cả'));
        provinceSink.add(values);
        loadSink.add(false);
      }
    });
  }

  Future<bool> loadDistrict(int provinceId) async {
    Map params = Map();
    params['province_id'] = provinceId;
    loadSink.add(true);
    return await _addressApiProvider.getDistrict(params).then((values) {
      if (!_districtController.isClosed) {
        districtSink.add(values);
        loadSink.add(false);
        return true;
      }
      return false;
    });
  }

  Future<bool> loadWard(int districtId) async {
    Map params = Map();
    params['district_id'] = districtId;
    loadSink.add(true);
    return await _addressApiProvider.getWard(params).then((values) {
      if (!_wardController.isClosed) {
        wardSink.add(values);
        loadSink.add(false);
        return true;
      }
      return false;
    });
  }

  ///Load from ghtk
//  Future<bool> loadHamlet(
//      String provinceName, String districtName, String wardName) async {
//    Map params = Map();
//    params['province'] = provinceName;
//    params['district'] = districtName;
//    params['ward_street'] = wardName;
//    return await _ghtkApiProvider.getAddressLevel4(params,
//        {"Token": "0cB1E62a480143a0ABA5C12FFa70BED070c0BBd1"}).then((values) {
//      if (values != null && !_hamletController.isClosed) {
//        hamletSink.add(values);
//        loadSink.add(false);
//        return true;
//      }
//      return false;
//    });
//  }

  void dispose() {
    _loadController.close();
    _provinceController.close();
    _districtController.close();
    _wardController.close();
//    _hamletController.close();
  }
}
