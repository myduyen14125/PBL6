import 'package:flutter/material.dart';
import 'package:itmentor/screens/home_screens/expertise/blockchain.dart';
import 'package:itmentor/screens/home_screens/expertise/game_development.dart';
import 'package:itmentor/screens/home_screens/expertise/information_security.dart';
import 'package:itmentor/screens/home_screens/expertise/mobile_development.dart';
import 'package:itmentor/screens/home_screens/expertise/networking.dart';
import 'package:itmentor/screens/home_screens/expertise/web_development.dart';

class RelatedFieldScreen extends StatefulWidget {
  final List<String> expertiseId;
  const RelatedFieldScreen({super.key, required this.expertiseId});

  @override
  State<RelatedFieldScreen> createState() => _RelatedFieldScreenState();
}

class _RelatedFieldScreenState extends State<RelatedFieldScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NetworkingScreen(
                        networkingId: widget.expertiseId[0],
                      );
                    }));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/networking_icon.png',
                        width: 50,
                        height: 100,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Mạng \nmáy tính',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WebMentorsScreen(
                          webDevelopmentId: widget.expertiseId[3]);
                    }));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/web_development.png',
                        width: 50,
                        height: 100,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Lập trình\n\t\t\t\tWeb',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MobileMentorsScreen(
                          mobileDevelopmentId: widget.expertiseId[4]);
                    }));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/mobile_development.png',
                        width: 50,
                        height: 100,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Lập trình\n\t\tMobile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GameMentorsScreen(
                          gameDevelopmentId: widget.expertiseId[5]);
                    }));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/game_development.png',
                        width: 50,
                        height: 100,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Lập trình\n\t\tGame',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SecurityScreen(securityId: widget.expertiseId[1]);
                    }));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/security.png',
                        width: 50,
                        height: 100,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'An toàn\nthông tin',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BlockchainMentors(
                          blockchainId: widget.expertiseId[2]);
                    }));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/ai.png',
                        width: 50,
                        height: 100,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '\t\t\t\tKhác\t\t\t\n',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
