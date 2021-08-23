import 'package:ace/home/home_view.dart';
import 'package:ace/theme/app_theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppThemeWidget());
}

class AppThemeWidget extends StatelessWidget {
  const AppThemeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppThemeProvider>(
      create: (context) => AppThemeProvider(),
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACE',
      theme: Provider.of<AppThemeProvider>(context).appThemeData,
      home: HomeView(),
    );
  }
}
