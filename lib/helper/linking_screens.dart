import 'package:flutter/cupertino.dart';

class LinkingScreens {
  Future goToNextScreen(BuildContext context, Widget widget,
      {bool isReplacement = false}) async {
    if (isReplacement) {
      await Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (BuildContext context) {
        return widget;
      }));
    } else {
      await Navigator.of(context)
          .push(CupertinoPageRoute(builder: (BuildContext context) {
        return widget;
      }));
    }
  }

  Future goToNextScreenAndRemove(BuildContext context, Widget widget) async {
    await Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);
  }

  Future goBack(BuildContext context) async {
    Navigator.pop(context);
  }
}

LinkingScreens linkingScreens = LinkingScreens();
