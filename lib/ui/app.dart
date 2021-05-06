import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_infrastructure/ui/app_screen.dart';

import 'package:sport_infrastructure/ui/search_result_screen.dart';
import 'detail_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (_) =>  AppScreen(),
          '/search_result_screen': (_) => SearchResultScreen(),
          '/detail_screen': (_) => DetailScreen(),
        },
      ),
    );
  }
}
