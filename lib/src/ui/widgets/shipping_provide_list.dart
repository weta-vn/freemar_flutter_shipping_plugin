import 'package:flutter/material.dart';
import 'package:shipping_plugin/src/models/ship_provider.dart';

class ShipProviderList extends StatefulWidget {
  final List<ShipProvider> listShipProvider;

  const ShipProviderList({Key key, this.listShipProvider}) : super(key: key);
  @override
  _ShipProviderList createState() => _ShipProviderList();
}

class _ShipProviderList extends State<ShipProviderList> {
  List<ShipProvider> _listShipProvider;
  @override
  void initState() {
    _listShipProvider = widget.listShipProvider ?? [];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(ShipProviderList oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SimpleDialog(
        contentPadding: EdgeInsets.all(10.0),
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Danh sách đơn vận chuyển",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: size.width * 0.9,
                    height: _listShipProvider.length * 70.0,
                    child: ListView.builder(
                        itemCount: _listShipProvider.length,
                        itemBuilder: (BuildContext context, int idx) {
                          var item = _listShipProvider[idx];
                          return ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            title: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  CircleAvatar(
                                      child: Image.network(
                                    item.logo,
                                    height: 100.0,
                                    width: 100.0,
                                  )), //item.logo
                                  Padding(padding: EdgeInsets.all(5.0)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(item.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        item.description ?? "Đơn vị vận chuyển",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ]),
                                Divider()
                              ],
                            ),
                            onTap: () async {
                              Navigator.pop(context, item);
                            },
                          );
                        }),
                  ),
                ],
              ))
            ],
          )
        ]);
  }
}
