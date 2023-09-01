
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:parking_app/style/appColors.dart';
import 'package:parking_app/widgets/custom_loading_indicator.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final Widget child;
  const LoadingOverlayWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        useDefaultLoading: false,
        disableBackButton: true,
        closeOnBackButton: false,
        overlayOpacity: 0.8,
        duration: const Duration(milliseconds: 250),
        reverseDuration: const Duration(milliseconds: 250),
        overlayColor: AppColors.textBlack,
        overlayWidget: const CustomLogoLoadingIndicator(),
        child: child);
  }
}
