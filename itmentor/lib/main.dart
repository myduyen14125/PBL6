import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/homepage_navigation_screen.dart';
import 'package:itmentor/screens/splash_screen/splash_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices = AuthServices();
  late Future<bool> isLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = _initialize();
  }

  Future<bool> _initialize() async {
    return authServices.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: isLoggedIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data == true
                ? const HomepageNavigationScreen()
                : SplashScreen();
          } else {
            // Return a loading indicator or another widget while waiting for the result.
            return CircularProgressIndicator(); // You can replace this with a loading indicator widget.
          }
        },
      ),
    );
  }
}

