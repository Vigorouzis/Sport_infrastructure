import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';
import 'package:sport_infrastructure/ui/place_screen.dart';
import 'detail_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
      builder: () => MaterialApp(
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => DetailScreen(),
          '/place_screen': (context) => PlaceScreen(),
          '/map_screen': (context) => DetailScreen(),
        },
      ),
    );
  }
}
