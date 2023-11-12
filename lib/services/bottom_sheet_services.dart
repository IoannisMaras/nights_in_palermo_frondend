import 'package:flutter/material.dart';

class BottomSheetServices {
  static void showErrorBottomSheet(BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 40.0,
              ),
              const SizedBox(height: 10.0),
              Text(
                message,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showCopySuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.check,
                color: Colors.green,
                size: 40.0,
              ),
              SizedBox(height: 10.0),
              Text(
                'Room Id has been copied to clipboard',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }
}
