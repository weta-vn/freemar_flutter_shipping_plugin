import 'package:flutter/material.dart';
import 'package:shipping_plugin/src/bloc/address_bloc.dart';
import 'package:shipping_plugin/src/models/address/district.dart';
import 'package:shipping_plugin/src/models/address/province.dart';
import 'package:shipping_plugin/src/models/address/ward.dart';

class Address extends StatefulWidget {
  final Function callBack;
  final Province province;
  final District district;
  final Ward ward;
//  final String hamlet;
  final String address;

  const Address({
    Key key,
    this.callBack,
    this.province,
    this.district,
    this.ward,
    this.address,
//      this.hamlet
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddressState();
  }
}

class AddressState extends State<Address> {
  AddressBloc _addressBloc;
  Province _province;
  District _district;
  Ward _ward;
//  String _hamlet;
  bool _loadedProvince = false, _loadedDistrict = false;
//  bool _loadedWard = false;

  @override
  void initState() {
    _addressBloc = AddressBloc();
    _province = widget.province;
    _district = widget.district;
    _ward = widget.ward;
    if (_province != null) {
      _loadedProvince = true;
      _addressBloc.loadDistrict(_province.id).then((value) {
        if (value) {
          _addressBloc.loadWard(_district.id);
          _loadedDistrict = true;
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _addressBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        initialData: true,
        stream: _addressBloc.streamLoad,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: <Widget>[
              StreamBuilder(
                  stream: _addressBloc.streamProvince,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Province>> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<Province>(
                            decoration:
                                InputDecoration(labelText: "T???nh/Th??nh Ph???"),
                            value: _province,
                            validator: (value) {
                              if (value == null)
                                return "Vui l??ng l???a ch???n T???nh/Th??nh Ph???";
                              return null;
                            },
                            items: snapshot.data
                                .map((val) => DropdownMenuItem<Province>(
                                      value: val,
                                      child: Text(val.name),
                                    ))
                                .toList(),
                            onChanged: (value) async {
                              setState(() {
                                _province = value;
                                _district = null;
                                _ward = null;
                                _loadedProvince = false;
                              });
                              bool res =
                                  await _addressBloc.loadDistrict(value.id);
                              setState(() {
                                _loadedProvince = res;
                              });
                            },
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    );
                  }),
              _province != null
                  ? StreamBuilder(
                      stream: _addressBloc.streamDistrict,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<District>> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            _loadedProvince) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<District>(
                                decoration:
                                    InputDecoration(labelText: "Qu???n/Huy???n"),
                                validator: (value) {
                                  if (value == null)
                                    return "Vui l??ng l???a ch???n Qu???n/Huy???n";
                                  return null;
                                },
                                value: _district,
                                items: snapshot.data
                                    .map((val) => DropdownMenuItem<District>(
                                          value: val,
                                          child: Text(val.name),
                                        ))
                                    .toList(),
                                onChanged: (value) async {
                                  setState(() {
                                    _district = value;
                                    _ward = null;
                                    _loadedDistrict = false;
                                  });
                                  bool res =
                                      await _addressBloc.loadWard(_district.id);
                                  setState(() {
                                    _loadedDistrict = res;
                                  });
                                },
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        );
                      })
                  : null,
              _district != null
                  ? StreamBuilder(
                      stream: _addressBloc.streamWard,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Ward>> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            _loadedDistrict) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<Ward>(
                                decoration:
                                    InputDecoration(labelText: "Ph?????ng/X??"),
                                value: _ward,
                                validator: (value) {
                                  if (value == null)
                                    return "Vui l??ng l???a ch???n Ph?????ng/X??";
                                  return null;
                                },
                                items: snapshot.data
                                    .map((val) => DropdownMenuItem<Ward>(
                                          value: val,
                                          child: Text(val.name),
                                        ))
                                    .toList(),
                                onChanged: (value) async {
                                  setState(() {
                                    _ward = value;
//                                    _hamlet = null;
//                                    _loadedWard = false;
                                  });
//
//                                  bool res = await _addressBloc.loadHamlet(
//                                      _province.name,
//                                      _district.name,
//                                      _ward.name);
//                                  setState(() {
//                                    _loadedWard = res;
//                                  });
                                },
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        );
                      })
                  : null,
//              _ward != null
//                  ? StreamBuilder(
//                      stream: _addressBloc.streamHamlet,
//                      builder:
//                          (BuildContext context, AsyncSnapshot<List> snapshot) {
//                        if (snapshot.hasData &&
//                            snapshot.data != null &&
//                            _loadedWard) {
//                          return Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: DropdownButtonHideUnderline(
//                              child: DropdownButtonFormField<String>(
//                                decoration: InputDecoration(
//                                    labelText: "Th??n/???p/x??m/t???/ng??"),
//                                value: _hamlet,
//                                validator: (value) {
//                                  if (value == null)
//                                    return "Vui l??ng l???a ch???n Th??n/???p/x??m/t???/ng??";
//                                  return null;
//                                },
//                                items: snapshot.data
//                                    .map((val) => DropdownMenuItem<String>(
//                                          value: val,
//                                          child: Text(val),
//                                        ))
//                                    .toList(),
//                                onChanged: (value) {
//                                  setState(() {
//                                    _hamlet = value;
//                                  });
//                                },
//                              ),
//                            ),
//                          );
//                        }
//                        return Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: CircularProgressIndicator(),
//                        );
//                      })
//                  : null,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "?????a ch??? chi ti???t",
                      helperText:
                          "Eg. S??? nh??, t??a nh??, t??n ???????ng - S???nh T1-Khu ???? th??? TimeCity - Minh Khai"),
                  initialValue: widget.address,
                  validator: (value) {
                    if (value.isEmpty)
                      return "Vui l??ng nh???p ?????a ch???";
                    else if (value.length < 5) return "?????a ch??? kh??ng kh??? d???ng";
                    return null;
                  },
                  onSaved: (value) {
                    widget.callBack(value, _province, _district, _ward);
                  },
                ),
              ),
            ]..removeWhere((widget) => widget == null));
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
