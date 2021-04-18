import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_infrastructure/ui/app_screen.dart';
import 'package:sport_infrastructure/ui/event_screens/event_list_screen.dart';

import 'package:sport_infrastructure/ui/search_result_screen.dart';
import 'package:sport_infrastructure/ui/sing_in_up_screens/sing_in_screen.dart';
import 'package:sport_infrastructure/ui/sing_in_up_screens/sing_up_screen.dart';
import 'detail_screen.dart';
import 'event_screens/event_details_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MaterialApp(
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (_) => SingInScreen(),
          '/search_result_screen': (_) => SearchResultScreen(),
          '/detail_screen': (_) => DetailScreen(),
        },
      ),
    );
  }
}
