import 'package:flutter/material.dart';

class DialogHelper {
  static void showDialogWithIcon(
      BuildContext context, String title, String message, bool isSuccess,
      [VoidCallback? onOkPressed]) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
              size: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
              ),
            ),
          ],
        ),
        content: Text(message, textDirection: TextDirection.rtl),
        actions: [
          TextButton(
            onPressed: onOkPressed ?? () => Navigator.of(context).pop(),
            child: const Text('موافق', textDirection: TextDirection.rtl),
          ),
        ],
      ),
    );
  }
}
