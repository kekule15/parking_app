import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AppOverlayWidget extends ConsumerWidget {
  final Widget child;
  final String loadingText;
  const AppOverlayWidget(
      {required this.child, required this.loadingText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoaderOverlay(
      useDefaultLoading: false,
      disableBackButton: false,
      closeOnBackButton: true,
      overlayOpacity: 0.8,
      overlayColor: Colors.black,
      overlayWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitDoubleBounce(
            color: Colors.grey,
          ),
          SizedBox(height: 10.h),
          Material(
              color: Colors.transparent,
              child: Text(
                loadingText,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ))
        ],
      ),
      child: child,
    );
  }
}
