
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/features/presentation/page/credential/sign_in_page.dart';
import 'features/presentation/page/credential/sign_up_page.dart';
import 'features/presentation/page/main_screen/main_screen.dart';
import 'on_generate_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram Clone",
      darkTheme: ThemeData.dark(),
      onGenerateRoute: OnGenerateRoute.route,
      initialRoute: "/",
      routes: {
        "/": (context) {
          return SignInPage();
        }
      },
    );
  }
}


