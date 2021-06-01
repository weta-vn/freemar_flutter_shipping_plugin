import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shipping_plugin/src/models/address/district.dart';
import 'package:shipping_plugin/src/models/address/province.dart';
import 'package:shipping_plugin/src/models/address/street.dart';
import 'package:shipping_plugin/src/models/address/ward.dart';
import 'package:shipping_plugin/src/models/shipping_address.dart';
import 'package:shipping_plugin/src/ui/widgets/address.dart';

class ShippingAddressList extends StatefulWidget {
  final List<ShippingAddress> shippingAddress;
  final ShippingAddress currentShippingAddress;
  final Function callBack;
  final Key shippingAddressListKey;

  const ShippingAddressList(
      {Key key,
      this.shippingAddress,
      this.currentShippingAddress,
      this.callBack,
      this.shippingAddressListKey})
      : super(key: key);

  @override
  ShippingAddressListState createState() => ShippingAddressListState();
}

class ShippingAddressListState extends State<ShippingAddressList> {
  List<ShippingAddress> _shippingAddress;
  ShippingAddress _currentShippingAddress;
  final GlobalKey<AddShippingFieldsState> addShippingFieldState =
      GlobalKey<AddShippingFieldsState>();

  @override
  void initState() {
    _shippingAddress = widget.shippingAddress ?? [];
    _currentShippingAddress = widget.currentShippingAddress;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void resultUpdate(bool res) {
    addShippingFieldState.currentState.result(res);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(contentPadding: EdgeInsets.all(10.0), children: <
        Widget>[
      new Row(
        children: <Widget>[
          new Flexible(
              child: Column(
            children: <Widget>[
              Text(
                "Địa chỉ giao hàng",
                style: new TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Divider(),
              Container(
                  width: 450,
                  height: _shippingAddress.length * 120.0,
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 475),
                  child: _shippingAddress.length > 0
                      ? ListView.builder(
                          itemCount: _shippingAddress.length,
                          itemBuilder: (BuildContext content, int index) {
                            ShippingAddress item = _shippingAddress[index];
                            return ListTile(
                              title: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(item.name),
                                  Text(
                                    "${item.address} "
                                    "${item.ward != null ? (" - " + item.ward.name) : ""}"
                                    "${item.district != null ? (" - " + item.district.name) : ""} - "
                                    "${item.province != null ? (item.province.name) : ""}",
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
//                                  Row(
//                                    children: <Widget>[
////                                      GestureDetector(
////                                        child: Icon(Icons.edit, size: 22.0),
////                                        onTap: () async {
////                                          Navigator.push(
////                                              context,
////                                              MaterialPageRoute(
////                                                  builder: (BuildContext
////                                                          context) =>
////                                                      Scaffold(
////                                                          appBar: AppBar(
////                                                              title: Text(
////                                                                  'Cập nhật địa chỉ')),
////                                                          body:
////                                                              AddShippingFields(
////                                                            shippingAddress:
////                                                                item,
////                                                            callBack:
////                                                                (ShippingAddress
////                                                                    shippingAddress) {
////                                                              widget.callBack(
////                                                                  shippingAddress);
////                                                            },
////                                                            key:
////                                                                addShippingFieldState,
////                                                          ))));
////                                        },
////                                      ),
////                                      SizedBox(
////                                        width: 5.0,
////                                      ),
////                                      GestureDetector(
////                                        child: Icon(Icons.delete, size: 22.0),
////                                        onTap: () {
////                                          showDialog(
////                                              context: context,
////                                              builder: (BuildContext context) {
////                                                return AlertDialog(
////                                                  title: Text("Are you sure?"),
////                                                  actions: <Widget>[
////                                                    FlatButton(
////                                                      onPressed: () =>
////                                                          Navigator.of(context)
////                                                              .pop(false),
////                                                      child: new Text('No'),
////                                                    ),
////                                                    FlatButton(
////                                                      onPressed: () {},
////                                                      child: new Text('Yes'),
////                                                    ),
////                                                  ],
////                                                );
////                                              });
////                                        },
////                                      ),
//                                    ],
//                                  ),
                                  Divider()
                                ],
                              ),
                              trailing: (item.id == _currentShippingAddress?.id)
                                  ? Icon(Icons.check)
                                  : null,
                              onTap: () async {
                                Navigator.pop(context, item);
                              },
                            );
                          })
                      : null),
              Divider(),
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: RaisedButton.icon(
                      color: Colors.white,
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Scaffold(
                                    appBar:
                                        AppBar(title: Text('Thêm địa chỉ mới')),
                                    body: AddShippingFields(
                                      shippingAddress: null,
                                      callBack:
                                          (ShippingAddress shippingAddress) {
                                        widget.callBack(shippingAddress);
                                      },
                                      key: addShippingFieldState,
                                    ))));
                      },
                      icon: Icon(Icons.add),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      label: Flexible(
                          child: Text(
                        "Thêm địa chỉ mới",
                        overflow: TextOverflow.ellipsis,
                      ))))
            ],
          ))
        ],
      )
    ]);
  }
}

class AddShippingFields extends StatefulWidget {
  final ShippingAddress shippingAddress;
  final Function callBack;
  final Key addShippingFieldState;

  const AddShippingFields(
      {Key key,
      this.shippingAddress,
      this.callBack,
      this.addShippingFieldState})
      : super(key: key);

  @override
  AddShippingFieldsState createState() => AddShippingFieldsState();
}

class AddShippingFieldsState extends State<AddShippingFields> {
  final _formKey = GlobalKey<FormState>();
  String _fullName, _phoneNumber, _address;
  Province _province;
  District _district;
  Ward _ward;
  bool _saving = false;

  @override
  void initState() {
    if (widget.shippingAddress != null) {
      _fullName = widget.shippingAddress.name;
      _phoneNumber = widget.shippingAddress.phoneNumber;
      _address = widget.shippingAddress.address;
      _province = widget.shippingAddress.province;
      _district = widget.shippingAddress.district;
      _ward = widget.shippingAddress.ward;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void result(bool res) {
    Navigator.of(context).pop();
  }

  _submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      String fullName = _fullName.trim();
      String phoneNumber = _phoneNumber.trim();
      String address = _address.trim();

      if (this._province != null &&
          this._district != null &&
          this._ward != null) {
        // Create new shipping address
        var addr = ShippingAddress(
          id: widget.shippingAddress?.id ?? null,
          name: fullName,
          phoneNumber: phoneNumber,
          address: address,
          province: this._province,
          district: this._district,
          ward: this._ward,
        );
        if (addr != null) {
          setState(() {
            _saving = true;
          });
          widget.callBack(addr);
        }
      }
    }
  }

  Widget addShippingFields(context) {
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Họ và tên"),
                        initialValue: _fullName,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Vui lòng nhập họ tên";
                          else if (value.length < 2)
                            return "Họ và tên có độ dài từ 2 - 50 ký tự";
                          else
                            _fullName = value;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Số điện thoại"),
                        initialValue: _phoneNumber,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Vui lòng nhập số điện thoại";
                          else if (value.length > 11 || value.length < 10)
                            return "Số điện thoại không hợp lệ";
                          else
                            _phoneNumber = value;
                          return null;
                        },
                      ),
                    ),
                    Address(
                      callBack: (String address, Province province,
                          District district, Ward ward) {
                        this._address = address;
                        this._province = province;
                        this._district = district;
                        this._ward = ward;
//                          this._street = street;
                      },
                      province: this._province,
                      district: this._district,
                      ward: this._ward,
                      address: this._address,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 30.0),
                      width: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Lưu",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                        onPressed: () {
                          _submit();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: _saving, child: addShippingFields(context));
  }
}
