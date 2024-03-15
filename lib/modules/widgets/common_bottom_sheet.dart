import 'package:flutter/material.dart';

class CommonBottomSheet {
  final String? title;
  final BuildContext context;
  final Widget childWidget;
  CommonBottomSheet(
      {required this.childWidget, required this.context, this.title});

  show() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        context: context,
        builder: (context) {
          return ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey),
                              width: 65.0,
                              height: 6.0,
                            )
                          ],
                        ),
                      ),
                      if (title != null)
                        Text(
                          title!,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      childWidget
                    ]),
              ),
            ),
          );
        });
  }
}
