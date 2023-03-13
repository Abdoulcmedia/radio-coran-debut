// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide following details for your new account:`
  String get pleaseprovide {
    return Intl.message(
      'Please Provide following details for your new account:',
      name: 'pleaseprovide',
      desc: '',
      args: [],
    );
  }

  /// `Or Click her to Login`
  String get orclick {
    return Intl.message(
      'Or Click her to Login',
      name: 'orclick',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email`
  String get enteremail {
    return Intl.message(
      'Enter Email',
      name: 'enteremail',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enterpassword {
    return Intl.message(
      'Enter Password',
      name: 'enterpassword',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name`
  String get entername {
    return Intl.message(
      'Enter Name',
      name: 'entername',
      desc: '',
      args: [],
    );
  }

  /// `Enter Username`
  String get enterusername {
    return Intl.message(
      'Enter Username',
      name: 'enterusername',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyhave {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyhave',
      desc: '',
      args: [],
    );
  }

  /// `Create an account?`
  String get createanaccount {
    return Intl.message(
      'Create an account?',
      name: 'createanaccount',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailaddress {
    return Intl.message(
      'Email Address',
      name: 'emailaddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmpassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmpassword',
      desc: '',
      args: [],
    );
  }

  /// `Phone No`
  String get phoneno {
    return Intl.message(
      'Phone No',
      name: 'phoneno',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone`
  String get enterphone {
    return Intl.message(
      'Enter Phone',
      name: 'enterphone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacypolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacypolicy',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutus {
    return Intl.message(
      'About Us',
      name: 'aboutus',
      desc: '',
      args: [],
    );
  }

  /// `Share App`
  String get shareapp {
    return Intl.message(
      'Share App',
      name: 'shareapp',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message(
      'Log Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `System Theme`
  String get systemtheme {
    return Intl.message(
      'System Theme',
      name: 'systemtheme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Profile Update Successfully`
  String get profileupdatesuccessfully {
    return Intl.message(
      'Profile Update Successfully',
      name: 'profileupdatesuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `When enabled, automatically follows the Dark and Light skin selection located in your device's settings.`
  String get whenenabled {
    return Intl.message(
      'When enabled, automatically follows the Dark and Light skin selection located in your device\'s settings.',
      name: 'whenenabled',
      desc: '',
      args: [],
    );
  }

  /// `No Song Downloaded`
  String get nosongdownloaded {
    return Intl.message(
      'No Song Downloaded',
      name: 'nosongdownloaded',
      desc: '',
      args: [],
    );
  }

  /// `Song Search`
  String get songsearch {
    return Intl.message(
      'Song Search',
      name: 'songsearch',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get favourite {
    return Intl.message(
      'Favourite',
      name: 'favourite',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Latest Album`
  String get latestalbum {
    return Intl.message(
      'Latest Album',
      name: 'latestalbum',
      desc: '',
      args: [],
    );
  }

  /// `Latest Artist`
  String get latestartist {
    return Intl.message(
      'Latest Artist',
      name: 'latestartist',
      desc: '',
      args: [],
    );
  }

  /// `Trending Songs`
  String get trendingsongs {
    return Intl.message(
      'Trending Songs',
      name: 'trendingsongs',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeall {
    return Intl.message(
      'See All',
      name: 'seeall',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure delete?`
  String get areyousuredelete {
    return Intl.message(
      'Are you sure delete?',
      name: 'areyousuredelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure logout?`
  String get areyousurelogout {
    return Intl.message(
      'Are you sure logout?',
      name: 'areyousurelogout',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Name is empty`
  String get nameisempty {
    return Intl.message(
      'Name is empty',
      name: 'nameisempty',
      desc: '',
      args: [],
    );
  }

  /// `Email is not empty`
  String get emailisnotempty {
    return Intl.message(
      'Email is not empty',
      name: 'emailisnotempty',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Enter Valid Email`
  String get entervalidemail {
    return Intl.message(
      'Enter Valid Email',
      name: 'entervalidemail',
      desc: '',
      args: [],
    );
  }

  /// `Enter password at least 6 character`
  String get enterpasswordatleast {
    return Intl.message(
      'Enter password at least 6 character',
      name: 'enterpasswordatleast',
      desc: '',
      args: [],
    );
  }

  /// `No Favourite`
  String get nofavouritesong {
    return Intl.message(
      'No Favourite',
      name: 'nofavouritesong',
      desc: '',
      args: [],
    );
  }

  /// `No Song`
  String get nosong {
    return Intl.message(
      'No Song',
      name: 'nosong',
      desc: '',
      args: [],
    );
  }

  /// `Enter Both Password are Same!`
  String get enterbothpassword {
    return Intl.message(
      'Enter Both Password are Same!',
      name: 'enterbothpassword',
      desc: '',
      args: [],
    );
  }

  /// `🇺🇸`
  String get flagcode {
    return Intl.message(
      '🇺🇸',
      name: 'flagcode',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get languagename {
    return Intl.message(
      'English',
      name: 'languagename',
      desc: '',
      args: [],
    );
  }

  /// `Player Screen`
  String get playerscreen {
    return Intl.message(
      'Player Screen',
      name: 'playerscreen',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get nodata {
    return Intl.message(
      'No Data',
      name: 'nodata',
      desc: '',
      args: [],
    );
  }

  /// `App Name`
  String get appname {
    return Intl.message(
      'App Name',
      name: 'appname',
      desc: '',
      args: [],
    );
  }

  /// `App Version`
  String get appversion {
    return Intl.message(
      'App Version',
      name: 'appversion',
      desc: '',
      args: [],
    );
  }

  /// `App Author`
  String get appauthor {
    return Intl.message(
      'App Author',
      name: 'appauthor',
      desc: '',
      args: [],
    );
  }

  /// `App Contact`
  String get appcontact {
    return Intl.message(
      'App Contact',
      name: 'appcontact',
      desc: '',
      args: [],
    );
  }

  /// `App Email`
  String get appemail {
    return Intl.message(
      'App Email',
      name: 'appemail',
      desc: '',
      args: [],
    );
  }

  /// `App Developed by`
  String get appdevelopedby {
    return Intl.message(
      'App Developed by',
      name: 'appdevelopedby',
      desc: '',
      args: [],
    );
  }

  /// `Downloaded song not share`
  String get downloadedsongnotshare {
    return Intl.message(
      'Downloaded song not share',
      name: 'downloadedsongnotshare',
      desc: '',
      args: [],
    );
  }

  /// `Phone no is empty`
  String get phonenoisempty {
    return Intl.message(
      'Phone no is empty',
      name: 'phonenoisempty',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone no at least 10 digit`
  String get enterphonenoatleast {
    return Intl.message(
      'Enter phone no at least 10 digit',
      name: 'enterphonenoatleast',
      desc: '',
      args: [],
    );
  }

  /// `No search data found`
  String get nosearchdatafound {
    return Intl.message(
      'No search data found',
      name: 'nosearchdatafound',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get nointernet {
    return Intl.message(
      'No Internet Connection',
      name: 'nointernet',
      desc: '',
      args: [],
    );
  }

  /// `language set successfully`
  String get languagesetsuccessfully {
    return Intl.message(
      'language set successfully',
      name: 'languagesetsuccessfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar', countryCode: 'SA'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
      Locale.fromSubtags(languageCode: 'hi', countryCode: 'IN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
