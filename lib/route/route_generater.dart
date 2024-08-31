import 'package:flutter/material.dart';
import 'package:mylibrary/view/home_screen.dart';
import 'package:mylibrary/view/login_screen.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/view/member.dart';
import 'package:mylibrary/view/verifyOtp.dart';

import '../splash.dart';

class MyRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    /// Splash Screen
      case RoutePath.splash:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

    ///HomeScreen screen
      case RoutePath.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());


    ///Login screen
      case RoutePath.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

    /// OTP Verify Screen
      case RoutePath.otpVerify:
        return MaterialPageRoute(
          builder: (_) => VerifyOtpScreen(),
        );

    /// Member Screen
      case RoutePath.memberScreen:
        return MaterialPageRoute(
          builder: (context) {
            final args = settings.arguments as MemberScreen;
            return MemberScreen(
              title: args.title,
              message: args.message,
            );
          },
        );
    //
    // /// Notification Screen
    //   case RoutePath.notification:
    //     return MaterialPageRoute(
    //       builder: (_) => NotificationScreen(),
    //     );
    //
    // /// AboutUs Screen
    //   case RoutePath.aboutUs:
    //     return MaterialPageRoute(
    //       builder: (_) => AboutUsScreen(),
    //     );
    //
    // /// Terms Screen
    //   case RoutePath.termsAndConditions:
    //     return MaterialPageRoute(
    //       builder: (_) => TermsConditionScreen(),
    //     );
    //
    // /// Version Screen
    //   case RoutePath.versionScreen:
    //     return MaterialPageRoute(
    //       builder: (_) => VersionScreen(),
    //     );
    //
    // /// Legal Screen
    //   case RoutePath.legalScreen:
    //     return MaterialPageRoute(
    //       builder: (_) => LegalScreen(),
    //     );
    //
    // /// PrivacyPolicy Screen
    //
    //   case RoutePath.privacyPolicyScreen:
    //     return MaterialPageRoute(
    //       builder: (_) => PrivacyPolicy(),
    //     );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }

//   static void navigateToHome(BuildContext context) {
//     Navigator.pushAndRemoveUntil(
//         context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
//   }
//
//   static void navigateToSettingsScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.settingScreen);
//   }
//
//   static void navigateToNotificationScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.notification);
//   }
//
//   static void navigateToLegalScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.legalScreen);
//   }
//
//   static void navigateToVersionScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.versionScreen);
//   }
//
//   static void navigateToAboutScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.aboutUs);
//   }
//
//   static void navigateToTermsScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.termsAndConditions);
//   }
//
//   static void navigateToPolicyScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.privacyPolicyScreen);
//   }
//
//   static void navigateToProfileScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.profile);
//   }
//
//   static void navigateToProfileEditScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.editProfile);
//   }
// //
// // static void navigateToOtpScreen(BuildContext context, String mobileNumber) {
// //   Navigator.pushNamed(context, '/otp_screen', arguments: mobileNumber);
// // }
// //
// // static void navigateToProfile({required BuildContext context, String? argument1, int? argument2, bool? argument3}) {
// //   Navigator.pushNamed(context, '/profile', arguments: {
// //     'argument1': argument1,
// //     'argument2': argument2,
// //     'argument3': argument3,
// //   });
// // }
// }
}