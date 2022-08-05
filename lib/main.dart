
import 'package:flutter/material.dart';
import 'features/presentation/page/credential/sign_up_page.dart';
import 'features/presentation/page/main_screen/main_screen.dart';

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
      home: MainScreen(),
    );
  }
}


