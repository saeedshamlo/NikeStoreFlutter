import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const defultScrollPhysics = BouncingScrollPhysics();

extension PriceLable on int {
  String get withPriceLable => this > 0 ? '$sepataterByComma  تومان' : 'رایگان';

  String get withPrice => this > 0 ? '$sepataterByComma ' : 'رایگان';
  String get sepataterByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

