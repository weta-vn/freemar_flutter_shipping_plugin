import 'package:flutter/material.dart';

Widget createInfoLine(
    {BuildContext context,
    String label,
    TextStyle labelStyle,
    String message,
    String subMessage,
    TextStyle messageStyle,
    bool isHorizontal = true,
    Icon icon,
    double padding = 10.0}) {
  return isHorizontal
      ? Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              icon != null
                  ? Row(children: <Widget>[
                      icon,
                      Padding(padding: EdgeInsets.all(5.0)),
                      Text(label,
                          style: labelStyle ??
                              Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.grey.shade600))
                    ])
                  : Text(label,
                      style: labelStyle ??
                          Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Colors.grey.shade600)),
              SizedBox(width: 15.0),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(message,
                          style: messageStyle ??
                              Theme.of(context).textTheme.headline6)),
                  subMessage != null
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(subMessage,
                              style: TextStyle(
                                  fontSize: 10.0, fontStyle: FontStyle.italic)))
                      : SizedBox(),
                ],
              ))
            ],
          ))
      : Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              icon != null
                  ? Row(children: <Widget>[
                      icon,
                      Padding(padding: EdgeInsets.all(5.0)),
                      Text(label,
                          style: labelStyle ??
                              Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.grey.shade600))
                    ])
                  : Text(label,
                      style: labelStyle ??
                          Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Colors.grey.shade600)),
              Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(message,
                          style: messageStyle ??
                              Theme.of(context).textTheme.headline6)))
            ],
          ));
}
