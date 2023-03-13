import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:musicplayer/Constants/Custom_widget/musicloader.dart';
import 'package:musicplayer/Constants/Language/language_constant.dart';
import 'package:musicplayer/Constants/audio_constant.dart';
import 'package:musicplayer/Ads/appAds.dart';
import 'package:musicplayer/Language/AppLanguage.dart';
import 'package:musicplayer/UI/DownloadScreen/downloadscreen.dart';
import 'package:musicplayer/firebase_options.dart';
import 'package:musicplayer/theme/app_theme.dart';
import 'package:musicplayer/theme/theme.dart';
import 'package:musicplayer/theme/themeNotifier.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/user_controller.dart';
import 'UI/BottomNavigatorBar/bottomnavigatorbar.dart';
import 'UI/OnBoardingScreen/onboardingscreen.dart';
import 'UI/SplashScreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ///one signal notification

  const String oneSignalAppId = "27222528-9375-40f3-88e6-857a62b8cc31";
  OneSignal.shared.setAppId(oneSignalAppId);
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {});

  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    event.complete(event.notification);
  });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {});

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {});

  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {});

  OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {});

  SharedPreferences.getInstance().then((prefs) {
    themeMode = prefs.getInt('themeMode') ?? 0;
    runApp(
      ChangeNotifierProvider<ThemeModeNotifier>(
        create: (_) {
          ThemeModeNotifier(ThemeMode.values[themeMode]).setThemeMode(themeMode == 0
              ? ThemeMode.system
              : themeMode == 1
                  ? ThemeMode.light
                  : ThemeMode.dark);
          return ThemeModeNotifier(ThemeMode.values[themeMode]);
        },
        child: const MyApp(),
      ),
    );
  });


}/// work on mac

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override


  void initState() {
    portraitModeOnly();
    getAdData();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    portraitModeOnly();
    getAdData();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Portrait Up
  void portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
    if (themeMode == 0) {
      if (brightness == Brightness.dark) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
        );
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
          ),
        );
      }
    }
    super.didChangePlatformBrightness();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          final Brightness brightness = SchedulerBinding.instance.window.platformBrightness;

          if (themeMode == 0) {
            if (brightness == Brightness.dark) {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.dark.copyWith(
                  systemNavigationBarColor: Colors.black,
                  systemNavigationBarIconBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.transparent,
                  statusBarBrightness: Brightness.dark,
                ),
              );
            } else {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.light.copyWith(
                  systemNavigationBarColor: Colors.white,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.transparent,
                  statusBarBrightness: Brightness.light,
                ),
              );
            }
          } else if (themeMode == 1) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.light.copyWith(
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.light,
              ),
            );
          } else {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.dark.copyWith(
                systemNavigationBarColor: Colors.black,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.dark,
              ),
            );
          }
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModeNotifier>(context);

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        assetsAudioPlayer.stop();
        Get.off(() =>  DownloadScreen(), transition: Transition.native);
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          userController.getuser().whenComplete(() {
            Get.off(() => userController.userId != null || userController.isguest.value  ? MyBottomNavigationBar() : OnBoardingScreen());
          });
        });
      }
    });

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, abc) {
        return GetMaterialApp(
          translations: AppTranslations(),
          locale: Locale('en', 'US'),
          // supportedLocales: S.delegate.supportedLocales,
          // localizationsDelegates: const [
          //   S.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // localeResolutionCallback: (locale, supportedLocales) {
          //   for (var supportedLocale in supportedLocales) {
          //     if (supportedLocale.languageCode == locale?.languageCode && supportedLocale.countryCode == locale?.countryCode) {
          //       return supportedLocale;
          //     }
          //   }
          //   return supportedLocales.first;
          // },
          title: 'Musicplayer',
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          themeMode: themeNotifier.getThemeMode(),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
