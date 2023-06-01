import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mycaterers/utils/common/colors.dart';
import 'package:mycaterers/utils/common/utils.dart';
import 'package:mycaterers/utils/routes/routenames.dart';
import 'package:mycaterers/utils/routes/routes.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: korangeColor
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
   MyApp(),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      fontFamily: 'Rubik',
        appBarTheme: AppBarTheme(
          backgroundColor: korangeColor
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(

          backgroundColor: korangeAccent,
          foregroundColor: Colors.white,

        ),

      ),

      initialRoute:  FirebaseAuth.instance.currentUser != null ?  RouteNames.home : RouteNames.login,

      routes: Routes().getRoute ,




    );
  }
}

