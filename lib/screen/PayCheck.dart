import 'package:flutter/material.dart';

import '../aqiget.dart';
import 'endScreen.dart';

class PayCheck extends StatelessWidget {
  final ApiService apiService;

  PayCheck({required this.apiService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: apiService.fetchServiceAmount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          double serviceAmount = snapshot.data!;
          return Column(
            children: [
              Container(
                height: 60,
                color: Color.fromRGBO(0, 0, 0, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "MỜI ANH ",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    Text(
                      "ĐÁNH GIÁ",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(222, 238, 5, 1),
                      ),
                    ),
                    Text(
                      " CHẤT LƯỢNG DỊCH VỤ",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                color: const Color.fromARGB(66, 104, 86, 86),
                child: Text("Dịch vụ đã sử dụng : $serviceAmount" ,style: TextStyle(
                        fontSize: 24,),)
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text("Anh vui lòng thanh toán đúng số tiền: $serviceAmount",style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                     Navigator.push(
                      context,
      MaterialPageRoute(builder: (context) =>EndScreen())
      
                     );         
                    },
                    child: Text("Xác nhận đúng"),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
