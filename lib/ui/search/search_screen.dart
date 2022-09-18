import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/theme.dart';

class SerachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 56,
        title: Text("جستجو"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Column(children: [
          Divider(),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(CupertinoIcons.search),
                fillColor: LightThemeColors.primatyColor,
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
                label: Text('جستجو کنید...')),
          ),
        
        ]),
      ),
    );
  }
}
