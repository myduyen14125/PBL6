import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/avatar_name.dart';
import 'package:itmentor/screens/account_settings_screen/settings_screens/settings_screen.dart';
import 'package:itmentor/screens/account_settings_screen/utilities_screen/utilities_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String aToken = '';
  String rToken = '';

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aToken = prefs.getString('x-auth-token') ?? '';
      rToken = prefs.getString('x-refresh') ?? '';
    });
  }

  Map<String, dynamic> myProfileData = {};

  void getProfileData() async {
    try {
      myProfileData = await AuthServices().fetchProfile(aToken, context);

      print("Profile Data: $myProfileData");
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    // Call the functions when the screen is first loaded
    authServices.getToken().then((token) {
      print('settings token: $token');
      if (token != null && token.isNotEmpty) {
        authServices.fetchProfile(token, storedContext).then((profileData) {
          print('profile data: $profileData');
          setState(() {
            profileName = profileData['name'];
            isLoading = false;
          });
          print('bio awards: ${profileData['bio']['awards']}');
        }).catchError((error) {});
        // getProfileData();
      } else {
        print("No valid token found");
      }
    }).catchError((error) {
      print("Error getting token: $error");
    });

    getAccessToken(); // Call the function to retrieve the access token
  }

  @override
  Widget build(BuildContext context) {
    // Store the context for later use
    storedContext = context;

    final user = Provider.of<UserProvider>(context).user;
    print('account settings: ${user.name}');

    print('aToken: $aToken');
    print('rToken: $rToken');
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
                      // AvatarName(profileName: profileName),
                      const UtilitiesScreen(),
                      SettingsScreen(token: aToken),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
