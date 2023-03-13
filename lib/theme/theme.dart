import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/Custom_widget/textwidget.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/theme/themeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/user_controller.dart';
import '../generated/l10n.dart';

var themeMode;

class ThemeChoice extends StatefulWidget {
  const ThemeChoice({Key? key}) : super(key: key);

  @override
  ThemeChoiceState createState() => ThemeChoiceState();
}

class ThemeChoiceState extends State<ThemeChoice> {
  ThemeMode? _selectedThemeMode;

  void _setSelectedThemeMode(ThemeMode mode, ThemeModeNotifier themeModeNotifier) async {
    themeModeNotifier.setThemeMode(mode);
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', mode.index);
    themeMode = mode.index;
    setState(() {
      _selectedThemeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeModeNotifier = Provider.of<ThemeModeNotifier>(context);
    setState(() {
      _selectedThemeMode = themeModeNotifier.getThemeMode();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget.regular('theme'.tr, fontSize: 20.sp, fontWeight: FontWeight.normal, fontFamily: 'Poppins-Bold'),
      ),
      body: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).colorScheme.onSecondaryContainer,
            title: TextWidget.regular('systemtheme'.tr,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',
                textAlign: TextAlign.start),
            trailing: Transform.scale(
                scale: 0.80,
                child: CupertinoSwitch(
                    value: themeMode == 0 ? true : false,
                    activeColor: green,
                    onChanged: (val) async {
                      setState(() {
                        if (val == true) {
                          _setSelectedThemeMode(ThemeMode.system, themeModeNotifier);
                        } else {
                          _setSelectedThemeMode(ThemeMode.light, themeModeNotifier);
                        }
                      });
                    })),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5.h)),
          Padding(
            padding: EdgeInsets.all(8.h),
            child: TextWidget.regular('whenenabled'.tr,fontFamily: "Poppins-Regular",fontSize: 13.sp,textAlign: TextAlign.left),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5.h)),
          ListTile(
            tileColor: Theme.of(context).colorScheme.onSecondaryContainer,
            onTap: themeMode != 0
                ? () {
                    _setSelectedThemeMode(ThemeMode.light, themeModeNotifier);
                  }
                : null,
            title: TextWidget.regular('light'.tr,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',
                textAlign: TextAlign.start),
            trailing: themeMode == 1
                ? SvgPicture.asset(
                    'assets/icons/done.svg',
                    height: 30.w,
                    width: 30.w,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : const SizedBox(),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5.h)),
          ListTile(
            tileColor: Theme.of(context).colorScheme.onSecondaryContainer,
            onTap: themeMode != 0
                ? () {
                    _setSelectedThemeMode(ThemeMode.dark, themeModeNotifier);
                  }
                : null,
            title: TextWidget.regular('dark'.tr,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins-Regular',
                textAlign: TextAlign.start),
            trailing: themeMode == 2
                ? SvgPicture.asset(
                    'assets/icons/done.svg',
                    height: 30.w,
                    width: 30.w,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
