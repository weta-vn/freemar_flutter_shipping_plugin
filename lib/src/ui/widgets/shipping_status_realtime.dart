import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipping_plugin/shipping_plugin.dart';
import 'package:shipping_plugin/src/helpers.dart';
import 'package:shipping_plugin/src/models/ship_pay_method.dart';
import 'package:shipping_plugin/src/models/ship_provider.dart';
import 'package:shipping_plugin/src/ui/widgets/create_info_line.dart';

class ShippingStatusRealtime extends StatefulWidget {
  final ShippingInformation shippingInformation;
  final ShipProvider shipProvider;
  final ShipPayMethod shipPayMethod;
  final bool isShippingFailed;
  final bool isReturn;
  final bool isBuyer;

  const ShippingStatusRealtime(
      {Key key,
      this.shippingInformation,
      this.shipProvider,
      this.shipPayMethod,
      this.isShippingFailed = false,
      this.isReturn = false,
      this.isBuyer})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _ShippingStatusRealtimeState();
  }
}

class _ShippingStatusRealtimeState extends State<ShippingStatusRealtime>
    with TickerProviderStateMixin {
  ShippingAddress shippingAddress;
  String shippingAddressText = '';
  String shipPayMethodDescription = '';

  @override
  void initState() {
    int shippingProviderId = widget.shipProvider.id;
    if (widget.isReturn) {
      if (widget.isBuyer) {
        shippingAddressText = 'Địa chỉ đưa hàng';
        shippingAddress = widget.shippingInformation.shippingFrom;
        if (shippingProviderId == ShipProviderEnum.GIAO_TAN_NOI) {
          shippingAddress = widget.shippingInformation.shippingTo;
        }
      } else {
        shippingAddressText = 'Địa chỉ nhận hàng';
        shippingAddress = widget.shippingInformation.shippingTo;
        if (shippingProviderId == ShipProviderEnum.TU_DEN_LAY) {
          shippingAddress = widget.shippingInformation.shippingFrom;
          shippingAddressText = 'Địa chỉ lấy hàng';
        }
      }
      shipPayMethodDescription = 'Người mua thanh toán';
    } else {
      if (widget.isBuyer) {
        shippingAddressText = 'Địa chỉ nhận hàng';
        shippingAddress = widget.shippingInformation.shippingTo;
        if (shippingProviderId == ShipProviderEnum.TU_DEN_LAY) {
          shippingAddress = widget.shippingInformation.shippingFrom;
          shippingAddressText = 'Địa chỉ lấy hàng';
        }
      } else {
        shippingAddressText = 'Địa chỉ đưa hàng';
        shippingAddress = widget.shippingInformation.shippingFrom;
        if (shippingProviderId == ShipProviderEnum.GIAO_TAN_NOI) {
          shippingAddress = widget.shippingInformation.shippingTo;
        }
      }
      shipPayMethodDescription = widget.shipPayMethod.description;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool inProgress = false;
    if ((widget.shippingInformation?.listStatus != null &&
        widget.shippingInformation.listStatus.length > 0)) {
      inProgress = true;
    }
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
              ),
            ],
            border: Border.all(
              color: inProgress ? Colors.green : Colors.red,
              width: 2.0,
            )),
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              widget.isReturn ? "Trả hàng" : "Giao hàng",
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Divider(),
            createInfoLine(
                context: context,
                label: shippingAddressText,
                message: shippingAddress.toString() ?? "",
                icon: Icon(Icons.home),
                isHorizontal: false),
            createInfoLine(
                context: context,
                label:
                    widget.isReturn ? "Dịch vụ trả hàng" : "Dịch vụ giao hàng",
                message: widget.shipProvider.name,
                subMessage: widget.shipProvider.description,
                icon: Icon(Icons.person_pin),
                isHorizontal: true),
            createInfoLine(
                context: context,
                label: widget.isReturn ? "Phí trả hàng" : "Phí giao hàng",
                message: formatCurrency(
                    widget.shippingInformation?.shippingFee ?? 0),
                subMessage: (widget.shippingInformation.shippingFee > 0)
                    ? "* $shipPayMethodDescription"
                    : "",
                icon: Icon(Icons.ac_unit),
                isHorizontal: true),
            Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Text(
                      widget.isReturn
                          ? 'Trạng thái trả hàng'
                          : 'Trạng thái giao hàng',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  )),
                ],
              ),
            ),
            shippingStatus(),
            widget.isShippingFailed
                ? Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.0)),
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      'Đơn hàng bị gặp sự cố và đang được xử lý. Chúng tôi sẽ liên lạc với bạn khi sự cố được khắc phục. ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  )
                : const SizedBox(),
          ],
        ));
  }

  Widget shippingStatus() {
    return Column(
      children: widget.shippingInformation?.listStatus?.map((status) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    height: 16.0,
                    width: 16.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(status.shippingStatus?.comment ?? ""),
                        Text(DateFormat("yyyy-MM-dd hh:mm:ss")
                            .format(status?.updatedAt ?? DateTime.now()))
                      ],
                    ),
                  )
                ],
              ),
            );
          })?.toList() ??
          [],
    );
  }
}
