import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibrary/provider/member_details/member_details_bloc.dart';
import 'package:mylibrary/provider/seat_allotment/getseat_bloc.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/route/route_generater.dart';
import 'package:mylibrary/utils/theme_changer.dart';

import 'database/table/seat_allotment_db.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetSeatBloc(), // Provide the GetSeatBloc
          ),
          BlocProvider(create: (context) => MemberBloc(SeatAllotment())),
        ],
        child: MaterialApp(
          initialRoute: RoutePath.splash,
          onGenerateRoute: MyRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
          title: 'My Library',
          theme: lightMode,
        ),
      ),
    );
  }
}
