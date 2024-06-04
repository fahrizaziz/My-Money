import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mymoney/Model/Utils/assets.dart';
import 'package:mymoney/Model/Utils/colors.dart';
import 'package:mymoney/View/home_screens.dart';
import 'package:mymoney/View/login_screens.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_view/source/source.dart';

import '../ViewModel/auth_providers.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  late Timer _checkLoginTimeOut;
  // _loadIntroductionScreen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool showIntroduction = prefs.getBool('introductionShown') ?? false;
  //   bool isRememberMe = prefs.getBool('remember_me') ?? false;
  //   String token = prefs.getString('data' 'access_token') ?? '';
  //   String username = prefs.getString('data' 'user' 'email') ?? '';
  //   String password = prefs.getString('data' 'user' 'password') ?? '';

  //   await Future.delayed(
  //     const Duration(
  //       seconds: 2,
  //     ),
  //   );

  //   if (showIntroduction) {
  //     checkLogin(isRememberMe, token, username, password);
  //   } else {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const LoginScreens(),
  //       ),
  //     );
  //   }
  // }

  // Future checkLogin(
  //   bool isRememberMe,
  //   String token,
  //   String email,
  //   String password,
  // ) async {
  //   await Future.delayed(
  //     const Duration(
  //       seconds: 1,
  //     ),
  //   );
  //   AuthProviders authProvider = Provider.of(
  //     context,
  //     listen: false,
  //   );
  //   final isLogin = await authProvider.checkLogin();
  //   if (isLogin == true) {
  //     bool isTokenExpired = JwtDecoder.isExpired(token);
  //     if (!isTokenExpired) {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => const HomeScreens(),
  //         ),
  //       );
  //     } else {
  //       if (isRememberMe) {
  //         final authProvider = Provider.of<AuthProviders>(
  //           context,
  //           listen: false,
  //         );
  //         await authProvider.login(
  //           email: email,
  //           password: password,
  //           context: context,
  //         );
  //       } else {
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(
  //             builder: (context) => const HomeScreens(),
  //           ),
  //         );
  //       }
  //     }
  //   } else {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const LoginScreens(),
  //       ),
  //     );
  //   }
  // }

  @override
  void initState() {
    _checkLoginTimeOut = Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreens(),
        ),
      ),
    );

    // _loadIntroductionScreen();
    super.initState();
  }

  @override
  void dispose() {
    _checkLoginTimeOut.cancel();
    super.dispose();
  }

  Future<bool?> _checkLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showIntroduction = prefs.getBool('introductionShown') ?? false;
    bool isRememberMe = prefs.getBool('remember_me') ?? false;
    String token = prefs.getString('data' 'access_token') ?? '';
    String username = prefs.getString('data' 'user' 'email') ?? '';
    String password = prefs.getString('data' 'user' 'password') ?? '';
    if (_checkLoginTimeOut.isActive) {
      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );
      AuthProviders authProvider = Provider.of(
        context,
        listen: false,
      );
      final isLogin = await authProvider.checkLogin();
      if (isLogin == true) {
        bool isTokenExpired = JwtDecoder.isExpired(token);
        if (!isTokenExpired) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreens(),
            ),
          );
        } else {
          if (isRememberMe) {
            final authProvider = Provider.of<AuthProviders>(
              context,
              listen: false,
            );
            await authProvider.login(
              email: username,
              password: password,
              context: context,
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginScreens(),
              ),
            );
          }
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreens(),
          ),
        );
      }
      _checkLoginTimeOut.cancel();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _checkLogin(context);
    });
    return Scaffold(
      body: SplashView(
        backgroundColor: CustomColor.bg,
        bottomLoading: true,
        logo: Image.asset(
          AppAsset.logo,
          fit: BoxFit.cover,
          height: (ResponsiveBreakpoints.of(context).smallerThan(MOBILE))
              ? 200
              : 120,
          width: (ResponsiveBreakpoints.of(context).smallerThan(MOBILE))
              ? 200
              : 120,
        ),
      ),
    );
  }
}
