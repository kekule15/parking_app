import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/constants.dart';
import 'package:parking_app/providers/providers.dart';
import 'package:parking_app/screens/splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_app/services/overlay_service.dart';
import 'package:parking_app/style/theme.dart';
import 'package:parking_app/utils/temporary_storage.dart';
import 'package:parking_app/widgets/loading_overlay_widget.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //await _configureLocalTimeZone();

  runApp( ProviderScope(child: MyApp()));
}
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
 

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final themeDataMode = ref.watch(themeDataProvider);

    ref.listen(loadingState.select((value) => value), (
      previous,
      current,
    ) {
      if (current) {
        OverlayService.showOverlay(context);
      } else {
        OverlayService.hideOverlay(context);
      }
    });
    return ScreenUtilInit(
        designSize: const Size(360, 700),
        builder: (widget, child) => LoadingOverlayWidget(
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                    statusBarBrightness: themeDataMode.isdarkTheme!
                        ? Brightness.dark
                        : Brightness.light,
                    statusBarIconBrightness: themeDataMode.isdarkTheme!
                        ? Brightness.light
                        : Brightness.dark,
                    statusBarColor: Colors.transparent),
                child: GetMaterialApp(
                  darkTheme: themeDataMode.isdarkTheme!
                      ? themeDataMode.darkTheme
                      : themeDataMode.lightTheme,
                  themeMode: ThemeMode.system,
                  theme: themeDataMode.isdarkTheme!
                      ? themeDataMode.darkTheme
                      : themeDataMode.lightTheme,
                  debugShowCheckedModeBanner: false,
                  title: Constants.appName,
                  home: Splash(),
                  // home: userLoggedIn == ''
                  //     ? const OnBoardingPage()
                  //     : const HomePage(),
                ),
              ),
            ));
  }
}