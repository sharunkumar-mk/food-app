import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

const TextStyle titleLabelStyle = TextStyle(
  color: Colors.black87,
  fontSize: 14,
  fontWeight: FontWeight.w900,
);

showLog(String message) {
  debugPrint(message);
}

showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Future<void> showProgress(BuildContext context) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CupertinoActivityIndicator(radius: 20),
        );
      });
}

showUnAuthorisedPopUp() {
  showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text("Session Expired"),
            content: const Text("Please Log In again"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          )).then((value) async {});
}

DateTime getDateTimeFromString({required String stringDate}) {
  String date = stringDate.substring(0, 8);
  return DateTime.parse(date);
}

String getDateStringFromListOfInt(List<int> dateList) {
  String dateString = dateList[0].toString() +
      dateList[1].toString().padLeft(2, '0') +
      dateList[2].toString().padLeft(2, '0');
  return dateString;
}
