import 'dart:async';

import 'package:appdanhgia/screen/EmotionScreen.dart';
import 'package:appdanhgia/screen/comment.dart';
import 'package:flutter/material.dart';

import '../model/rate.dart';
import '../services/rate_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int? y;
  final Color? color;
}

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  bool isTapped1 = false;
  bool isTapped2 = false;
  bool isTapped3 = false;
  bool isTapped4 = false;

  int selectedEmotion = -1;
  List<Rate> rates = [];
  Map<int, dynamic> emoji = {0: 0, 1: 0, 2: 0, 3: 0};
  Map<int, Map<int, int>> cmt = {
    0: {0: 0, 1: 0, 2: 0, 3: 0, 4: 0},
    1: {0: 0, 1: 0, 2: 0, 3: 0, 4: 0},
    2: {0: 0, 1: 0, 2: 0, 3: 0, 4: 0},
    3: {0: 0, 1: 0, 2: 0, 3: 0, 4: 0}
  };
  Map<int, Map<String, Map<int, String>>> emotions = {
    0: {
      'Tệ': {
        0: ' Bảo vệ,nhân viên\n không nhiệt tình ',
        1: 'Bác sĩ khám điều\n trị yếu kém',
        2: 'Chi phí cao',
        3: 'Chăm sóc sau\n điều trị kém'
      }
    },
    1: {
      'Tạm ổn': {
        0: 'Bảo vệ,nhân \nviên bình thường',
        1: 'Bác sĩ khám điều\n trị bình thường',
        2: 'Chi phí vừa phải',
        3: 'test'
      },
    },
    2: {
      'Tốt': {
        0: 'Bảo vệ,nhân viên nhiệt tình',
        1: 'Bác sĩ khám điều trị tốt',
        2: 'Chăm sóc sau điều trị tốt',
        3: 'test'
      },
    },
    3: {
      'Hoàn hảo': {
        0: 'Bảo vệ,nhân viên rất nhiệt tình ',
        1: 'Bác sĩ khám điều trị rất tốt',
        2: 'Chăm sóc sau điều trị chu đáo',
        3: 'test'
      }
    }
  };
  @override
  void initState() {
    super.initState();
    // Fetch data immediately
    fetchData();
    // Schedule fetching data every 30 seconds (adjust as needed)
    Timer.periodic(Duration(seconds: 300), (Timer timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    final response = await RateApi.fetchRate();
    setState(() {
      rates = response;
      locRates();
    });
  }

  void locRates() {
    // Reset data to avoid accumulation
    emoji = {0: 0, 1: 0, 2: 0, 3: 0};
    cmt = {
      0: {0: 0, 1: 0, 2: 0, 3: 0, 4: 0},
      1: {0: 0, 1: 0, 2: 0, 3: 0, 4: 0},
      2: {0: 0, 1: 0, 2: 0, 3: 0, 4: 0},
      3: {0: 0, 1: 0, 2: 0, 3: 0, 4: 0}
    };

    for (var i = 0; i < rates.length; i++) {
      int currentId = rates[i].id;
      emoji[currentId]++;

      for (var j = 0; j < rates[i].comments.length; j++) {
        int currentComment = rates[i].comments.elementAt(j);
        cmt[currentId]?.update(j, (value) => value + 1, ifAbsent: () => 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Tệ', emoji[0], Colors.teal),
      ChartData('Tạm ổn', emoji[1], Colors.orange),
      ChartData('Tốt', emoji[2], Colors.brown),
      ChartData('Hoàn hảo', emoji[3], Colors.deepOrange)
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(47, 179, 178, 0.8),
          title: Text('Đánh giá trung bình'),
        ),
        body: Column(children: [
          SizedBox(height: 40,),
          Container(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <CartesianSeries>[
                ColumnSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color)
              ])),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      isTapped1 = !isTapped1;
                      isTapped2 = false;
                      isTapped3 = false;
                      isTapped4 = false;
                      if (isTapped1) {
                        selectedEmotion = 0;
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>comment(tap: 0,)));
                      } else {
                        selectedEmotion = -1;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.electric_meter_rounded,
                        size: 80,
                        color: isTapped1
                            ? const Color.fromARGB(255, 241, 244, 54)
                            : Colors.grey,
                      ),
                      Text("Tệ")
                    ],
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      isTapped2 = !isTapped2;
                      isTapped1 = false;
                      isTapped3 = false;
                      isTapped4 = false;
                      if (isTapped2) {
                        selectedEmotion = 1;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>comment(tap: 1,)));
                      }
                      if (!isTapped2) {
                        selectedEmotion = -1;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.face_5_rounded,
                        size: 80,
                        color: isTapped2
                            ? const Color.fromARGB(255, 241, 244, 54)
                            : Colors.grey,
                      ),
                      Text("Tạm ổn")
                    ],
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      isTapped3 = !isTapped3;
                      isTapped2 = false;
                      isTapped1 = false;
                      isTapped4 = false;
                      if (isTapped3) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>comment(tap: 2,)));
                      } else {
                        selectedEmotion = -1;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.emoji_emotions_outlined,
                        size: 80,
                        color: isTapped3
                            ? const Color.fromARGB(255, 241, 244, 54)
                            : Colors.grey,
                      ),
                      Text("Tốt")
                    ],
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      isTapped4 = !isTapped4;
                      isTapped2 = false;
                      isTapped3 = false;
                      isTapped1 = false;
                      if (isTapped4) {
                        selectedEmotion = 3;
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>comment(tap: 3,)));
                      } else {
                        selectedEmotion = -1;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.emoji_emotions_sharp,
                        size: 80,
                        color: isTapped4
                            ? const Color.fromARGB(255, 241, 244, 54)
                            : Colors.grey,
                      ),
                      Text("Hoàn Hảo")
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            // Xác định màu sắc dựa trên trạng thái của nút
            if (states.contains(MaterialState.pressed)) {
              // Trạng thái khi nút được nhấn
              return Colors.red;
            } else {
              // Trạng thái mặc 
              return Color.fromRGBO(47, 179, 178, 0.8);
            }})),
              onPressed: _navigator, child: Text("Chuyển sang trang đánh giá"))
        ]));
  }

  void _navigator() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EmotionScreen()));
  }


//   void _showSimpleDialog(BuildContext context, int tap) {
//     final List<ChartData> chartData1 = [
//       ChartData(emotions[tap]!.values.single.values.elementAt(0), cmt[tap]?[0],
//           Colors.red),
//       ChartData(emotions[tap]!.values.single.values.elementAt(1), cmt[tap]?[1],
//           const Color.fromARGB(255, 70, 244, 54)),
//       ChartData(emotions[tap]!.values.single.values.elementAt(2), cmt[tap]?[2],
//           Color.fromARGB(255, 54, 57, 244)),
//       ChartData(emotions[tap]!.values.single.values.elementAt(3), cmt[tap]?[3],
//           const Color.fromARGB(255, 244, 54, 158)),
//     ];
//    showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return Scaffold( // Bọc Container bởi Scaffold
//       body: Column(
//         children: [
//           Container(
//             color: Color.fromARGB(255, 255, 255, 255),
//             child: SfCartesianChart(
//               primaryXAxis: CategoryAxis(),
//               series: <CartesianSeries>[
//                 ColumnSeries<ChartData, String>(
//                   dataSource: chartData1,
//                   xValueMapper: (ChartData data, _) => data.x,
//                   yValueMapper: (ChartData data, _) => data.y,
//                   pointColorMapper: (ChartData data, _) => data.color,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   },

 
// );

//   }
}
