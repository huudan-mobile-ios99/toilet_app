import 'package:flutter/material.dart';
import 'package:toilet_client_web_v2/utils/padding.dart';
import 'package:toilet_client_web_v2/utils/text.dart';

Future showDialogWaiting({context, dismissDuration}) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return FutureBuilder(
        future: Future.delayed(dismissDuration).then((value) => true),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Navigator.of(context).pop();
          }
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Use min to limit size
              children: [
                Image.asset(
                  'assets/waiting.png', // Replace with your image path
                  height: 150, // Adjust the height as needed
                  width: 150, // Adjust the width as needed
                ),
                const SizedBox(
                    height: PaddingDefault.pading08), // Add some space between image and text
                text_custom(
                    text: 'Your feedback is being sent, please wait a moment',
                    size: 16,
                    weight: FontWeight.w500),
              ],
            ),
            // actions: [
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text('Close'),
            //   ),
            // ],
          );
        },
      );
    },
  );
}
