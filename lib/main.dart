import 'dart:async';

import 'package:appdanhgia/screen/EmotionScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        '/home': (context) => EmotionScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  List<String> _images = [
    'assets/images/logo.jpg',
    'assets/images/doingubacsi.jpg',
    'assets/images/pk.jpg'
  ];

  @override
  void initState() {
    super.initState();

    // Tự động chuyển trang sau 3 giây
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _navigateToEmotionScreen() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 179, 178, 0.8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400, // Điều chỉnh kích thước của hình ảnh
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
            SizedBox(height: 30),
            Text(
              'CHÀO MỪNG ĐẾN VỚI ',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'NHA KHOA VIỆT PHÁP',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              
              onPressed: _navigateToEmotionScreen,
              child: Text('VÀO TRANG ĐÁNH GIÁ',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
              style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.all(20),
                          backgroundColor: Color.fromRGBO(47, 179, 178, 0.8)
            ),
         ) ],
        ),
      ),
    );
  }
}
