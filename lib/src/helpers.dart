import 'package:intl/intl.dart';

String formatCurrency(dynamic number, {useNatureExpression = false}) {
  if ((number ?? 0.0) == 0.0)
    return useNatureExpression ? "miễn phí" : ("0" + ' đ');
  else {
    final formatter = new NumberFormat("#,###");
    return formatter.format(number) + ' đ';
  }
}
