import 'package:flutter/material.dart';
import 'package:nike_store/common/exception.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException appException;
  final GestureTapCallback onTryAgainClick;
  const AppErrorWidget({
    Key? key,
    required this.appException,
    required this.onTryAgainClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(appException.message!),
          ElevatedButton(
              onPressed: onTryAgainClick, child: const Text('تلاش دوباره'))
        ],
      ),
    );
  }
}