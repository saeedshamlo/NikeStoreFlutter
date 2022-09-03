import 'package:flutter/cupertino.dart';

const defultScrollPhysics = BouncingScrollPhysics();

extension PriceLable on int {
  String get withPriceLable => '$this  تومان';
}

String pricalbe(int? price) {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';


  return "${price.toString().replaceAllMapped(reg, mathFunc)} تومان  ";
}
