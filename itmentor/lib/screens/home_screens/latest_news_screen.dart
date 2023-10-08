import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LatestNewsScreen extends StatefulWidget {
  const LatestNewsScreen({super.key});

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            // call api get all latest-news
            // hard code first
            Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Text('Tin tức công nghệ sáng 31//7'),
                    Text('Twitter đổi tên sang X'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: const [
                              Icon(Icons.calendar_month),
                              Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text('07/10/2023')),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xFF195A94), // Đặt màu nền của ElevatedButton
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Đặt bán kính bo tròn
                              ),
                            ),
                            child: Row(
                              children: const [
                                Text('Xem tiếp'),
                                Icon(
                                  Icons.arrow_circle_right,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
