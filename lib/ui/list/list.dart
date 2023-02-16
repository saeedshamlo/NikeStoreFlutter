import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('کفش های ورزشی'),),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }

}