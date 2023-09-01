import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class OverlayService {
  static void showOverlay(BuildContext context) {
    if (context.mounted) {
      context.loaderOverlay.show();
    }
  }

  static void hideOverlay(BuildContext context) {
    if (context.mounted && context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }
}
