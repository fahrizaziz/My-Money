import 'package:flutter/material.dart';

class PageNavigator {
  BuildContext? ctx;

  PageNavigator({
    this.ctx,
  });

  void nextPageOnly({Widget? page}) {
    Navigator.pushAndRemoveUntil(
      ctx!,
      MaterialPageRoute(
        builder: (context) => page!,
      ),
      (route) => false,
    );
  }
}
