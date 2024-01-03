// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/rate.dart';
import '../services/rate_api.dart';

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int? y;
  final Color? color;
}

class comment extends StatefulWidget {
  final int tap;
  const comment({
    Key? key,
    required this.tap,
  }) : super(key: key);

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
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
        0: ' Bảo vệ,nhân viên không nhiệt tình ',
        1: 'Bác sĩ khám điều trị yếu kém',
        2: 'Chi phí cao',
        3: 'Chăm sóc sau điều trị kém'
      }
    },
    1: {
      'Tạm ổn': {
        0: 'Bảo vệ,nhân viên bình thường',
        1: 'Bác sĩ khám điều trị bình thường',
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
    Timer.periodic(Duration(seconds: 3000), (Timer timer) {
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
    int tap = widget.tap;
    final List<ChartData> chartData1 = [
      ChartData('Comment 1', cmt[tap]?[0], Colors.red),
      ChartData(
          'Comment 2', cmt[tap]?[1], const Color.fromARGB(255, 70, 244, 54)),
      ChartData('Comment 3', cmt[tap]?[2], Color.fromARGB(255, 54, 57, 244)),
      ChartData(
          'Commnet 4', cmt[tap]?[3], const Color.fromARGB(255, 244, 54, 158)),
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(47, 179, 178, 0.8),
          title: Text('Đánh giá trung bình'),
        ),
        body: Column(
          children: [
             SizedBox(
            height: 40,
          ),
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries>[
                  ColumnSeries<ChartData, String>(
                    dataSource: chartData1,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text('Comment ${index+1} :'+emotions[tap]!
                              .values
                              .single
                              .values
                              .elementAt(index)
                              ),
                              
                              );
                    }))
          ],
        ));
  }
}
