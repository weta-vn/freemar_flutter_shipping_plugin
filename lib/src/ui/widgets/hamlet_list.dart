import 'package:flutter/material.dart';
import 'package:shipping_plugin/shipping_plugin.dart';
import 'package:shipping_plugin/src/bloc/ghtk_bloc.dart';

class HamletListWidget extends StatefulWidget {
  final ShippingAddress shippingAddress;
  final Map ghtk;

  const HamletListWidget({Key key, this.shippingAddress, this.ghtk})
      : super(key: key);

  @override
  _HamletListWidgetState createState() => _HamletListWidgetState();
}

class _HamletListWidgetState extends State<HamletListWidget> {
  GHTKBloc _ghtkBloc;
  @override
  void initState() {
    _ghtkBloc = GHTKBloc(widget.ghtk);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SimpleDialog(
        contentPadding: EdgeInsets.all(10.0),
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                  child: Column(
                children: <Widget>[
                  Text(
                    'Danh sách Thôn/xóm/tổ/ấp/ngõ...',
                    style: new TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Divider(),
                  FutureBuilder(
                    future: _ghtkBloc.loadHamlet(
                        widget.shippingAddress.province.name,
                        widget.shippingAddress.district.name,
                        widget.shippingAddress.ward.name),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List hamlets = snapshot.data;
                        int lenHamlets = hamlets.length;
                        return Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          width: size.width,
                          height: lenHamlets * 75.0,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: lenHamlets,
                              itemBuilder: (BuildContext context, int idx) {
                                var item = hamlets[idx];
                                return ListTile(
                                  contentPadding: EdgeInsets.all(0.0),
                                  title: Text(item),
                                  subtitle: Divider(),
                                  trailing: Icon(Icons.arrow_right),
                                  onTap: () async {
                                    Navigator.pop(context, item);
                                  },
                                );
                              }),
                        );
                      }
                      return Container(
                          width: size.width * 0.9,
                          height: size.height * 0.7,
                          child: Center(child: CircularProgressIndicator()));
                    },
                  )
                ],
              ))
            ],
          )
        ]);
  }
}
