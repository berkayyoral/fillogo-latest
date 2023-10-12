import 'package:flutter/cupertino.dart';

import '../../../export.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._init();
  static AppTheme get instance => _instance;

  AppTheme._init();

  ThemeData get lightTheme => ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: AppConstants().ltMainRed,
        ),
        colorScheme: const ColorScheme.light(),
        primaryColor: AppConstants().ltMainRed,
        fontFamily: AppConstants.fontFamily,
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppConstants().ltMainRed,
        ),
        iconTheme: IconThemeData(color: AppConstants().ltWhite),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppConstants().ltMainRed,
          selectionColor: const Color(
            0xffDDA3A2,
          ),
          selectionHandleColor: AppConstants().ltMainRed,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppConstants().ltDarkGrey,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: AppConstants().ltDarkGrey,
          // labelStyle: TextConstants.instance.label1,
          // unselectedLabelStyle: TextConstants.instance.label1,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
            color: AppConstants().ltDarkGrey,
            width: 2.5,
          )),
        ),
        textTheme: TextTheme(
            bodyLarge: TextStyle(
          color: AppConstants().ltMainRed,
        )),
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: const ColorScheme.dark(),
        fontFamily: AppConstants.fontFamily,
        scaffoldBackgroundColor: Colors.black,
      );
}
