import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/route/route_generater.dart';


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
      child: MaterialApp(
        initialRoute: RoutePath.splash,
        onGenerateRoute: MyRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
       // home: LanguageSelectionPage(),
      ),
    );
  }
}
