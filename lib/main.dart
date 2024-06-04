import 'package:flutter/material.dart';
import 'package:mymoney/View/splash_screens.dart';
import 'package:mymoney/ViewModel/auth_providers.dart';
import 'package:mymoney/ViewModel/history_providers.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryProviders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, widget) => ResponsiveBreakpoints.builder(
          child: widget!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        home: const SplashScreens(),
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Responsive Framework Demo'),
//       ),
//       body: Center(
//         child: Container(
//           width: 200,
//           height: 200,
//           color: Colors.blue,
//           child: (ResponsiveBreakpoints.of(context).smallerThan(MOBILE)) ? Text('Hi') : Text('Yoh'),
//         ),
//       ),
//     );
//   }
// }
