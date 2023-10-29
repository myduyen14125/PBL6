import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/avatar_name.dart';
import 'package:itmentor/screens/account_settings_screen/settings_screens/settings_screen.dart';
import 'package:itmentor/screens/account_settings_screen/utilities_screen/utilities_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<ProfileScreen> {
  final AuthServices authServices = AuthServices();
  String profileName = '';
  bool isLoading = false;
  late BuildContext storedContext; // Store the context during build

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    // Call the functions when the screen is first loaded
    authServices.getToken().then((token) {
      if (token != null && token.isNotEmpty) {
        authServices.fetchProfile(token, storedContext).then((profileData) {
          setState(() {
            profileName = profileData['name'];
            isLoading = false;
          });
        }).catchError((error) {});
      } else {
        print("No valid token found");
      }
    }).catchError((error) {
      print("Error getting token: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Store the context for later use
    storedContext = context;

    final user = Provider.of<UserProvider>(context).user;
    print('account settings: ${user.name}');
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      AvatarName(profileName: profileName),
                      const UtilitiesScreen(),
                      const SettingsScreen(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

