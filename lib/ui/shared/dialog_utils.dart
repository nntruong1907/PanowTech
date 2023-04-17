import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(
        'Are you sure?',
        style: TextStyle(
            fontFamily: 'SFCompactRounded', fontWeight: FontWeight.bold),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'No',
            style: TextStyle(
                fontFamily: 'SFCompactRounded', fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text(
            'Yes',
            style: TextStyle(
                fontFamily: 'SFCompactRounded', fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(
        'An Error Occurred!',
        style: TextStyle(
            fontFamily: 'SFCompactRounded', fontWeight: FontWeight.bold),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Okay',
            style: TextStyle(
                fontFamily: 'SFCompactRounded', fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}
