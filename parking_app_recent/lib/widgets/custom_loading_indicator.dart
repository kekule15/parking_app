
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parking_app/widgets/image_widgets.dart';

class CustomLogoLoadingIndicator extends StatelessWidget {
  final double padding;
  const CustomLogoLoadingIndicator({Key? key, this.padding = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: SpinKitPumpingHeart(
        size: 200,
        itemBuilder: (context, index) => ImageWidget(
          asset: appIcon,
          width: 70.w,
          height: 70.w,
        ),
      ),
    ));
  }
}
