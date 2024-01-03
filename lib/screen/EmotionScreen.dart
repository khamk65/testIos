// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:database/database.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:appdanhgia/screen/PayCheck.dart';
import 'package:appdanhgia/screen/home.dart';
import 'package:appdanhgia/screen/rate.dart';

import '../aqiget.dart';

class EmotionScreen extends StatefulWidget {
  @override
  _EmotionScreenState createState() => _EmotionScreenState();
}

class _EmotionScreenState extends State<EmotionScreen> {
   List selectCmt = [false, false, false, false];
   List cmt=[];
  bool isTapped1 = false;
  bool isTapped2 = false;
  bool isTapped3 = false;
  bool isTapped4 = false;

  int selectedEmotion = -1;
  String selectedComment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(47, 179, 178, 0.8),
          title: Center(
            child: Text(
              'Mời bạn đánh giá',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      body: Column(children: [
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
             selectCmt = [false, false, false, false];
             cmt=[];
                    } else {
                      selectedEmotion = -1;
                    }
                    print(selectedComment);
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
                     selectCmt = [false, false, false, false];
                     cmt=[];
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
                      selectedEmotion = 2;
          selectCmt = [false, false, false, false];
          cmt=[];
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
                      cmt=[];
                   selectCmt = [false, false, false, false];
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
          height: 30,
        ),
        Comment(
          selectedEmotion: selectedEmotion,
          selec: selectCmt, resetCmt: cmt,
        ),
      ]),
    );
  }
}

class Comment extends StatefulWidget {
  final int selectedEmotion;
  List resetCmt;
  List selec;
  Comment({
    Key? key,
    required this.selectedEmotion,
    required this.resetCmt,
    required this.selec,
  }) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {

final pb = PocketBase('http://127.0.0.1:8090');
  Future<void> postData(List cmt, int selectedEmoji) async {
    final apiUrl = 'https://api.mockfly.dev/mocks/1b1eb603-acdd-4440-aec4-21f4ed51e9b0/kham5';
final body = <String, dynamic>{
  "field": "JSON"
};

final record = await pb.collection('post').create(body: body);
    // Tạo body request từ danh sách comment và emoji được chọn
    final Map<String, dynamic> requestBody = {
      'rate': {
        'comments': cmt,
        'selectedEmoji': selectedEmoji,
      }
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        // Xử lý khi nhận được phản hồi từ API
        print('Dữ liệu đã được gửi thành công');
        print(response.body);
      } else {
        // Xử lý khi có lỗi từ phía server
        print('Lỗi: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      // Xử lý khi có lỗi kết nối
      print('Lỗi kết nối: $e');
    }
  }



  void _postApi() {
  
  
    postData(widget.resetCmt, widget.selectedEmotion);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }



  Map<int, Map<String, Map<int, String>>> emotions = {
    0: {
      'Tệ': {
        0: 'Bảo vệ,nhân viên không nhiệt tình',
        1: 'Bác sĩ khám điều trị yếu kém',
        2: 'Chi phí cao',
        4: 'Chăm sóc sau điều trị kém'
      }
    },
    1: {
      'Tạm ổn': {
        0: 'Bảo vệ,nhân viên bình thường',
        1: 'Bác sĩ khám điều trị bình thường',
        2: 'Chi phí vừa phải',
      },
    },
    2: {
      'Tốt': {
        0: 'Bảo vệ,nhân viên nhiệt tình',
        1: 'Bác sĩ khám điều trị tốt',
        2: 'Chăm sóc sau điều trị tốt',
      },
    },
    3: {
      'Hoàn hảo': {
        0: 'Bảo vệ,nhân viên rất nhiệt tình ',
        1: 'Bác sĩ khám điều trị rất tốt',
        2: 'Chăm sóc sau điều trị chu đáo',
      }
    }
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          if (widget.selectedEmotion != -1)
            Column(
              children: [
                Container(
                  height: 250,
                  child: ListView.builder(
                    itemCount:
                        emotions[widget.selectedEmotion]?.values.single.length,
                    itemBuilder: (context, index) {
                      final value =
                          emotions[widget.selectedEmotion]?.values.single.values;
print(widget.selec);
                      return Container(
                        margin:
                            EdgeInsets.only(bottom: 10), // Adjust the spacing here
                        child: ListTile(
                          tileColor: widget.selec[index]
                              ? Colors.amberAccent
                              : const Color.fromARGB(255, 255, 255, 255),
                          title: Text(
                            emotions[widget.selectedEmotion]!
                                .values
                                .single
                                .values
                                .elementAt(index),
                          ),
                          trailing: widget.selec[index]
                              ? Icon(Icons.check, color: Colors.green)
                              : null,
                          iconColor: !widget.selec[index]
                              ? Colors.amberAccent
                              : const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onTap: () {
                            setState(() {
                            

print(widget.resetCmt);
                              widget.selec[index] = !widget.selec[index];
                              if (widget.selec[index] && !widget.resetCmt.contains(index)) {
                                widget.resetCmt.add(index);
                              } 
                              print(index);
                              print(widget.resetCmt);
                              print(widget.selectedEmotion);
                              print(
                                emotions[widget.selectedEmotion]
                                    ?.values
                                    .single
                                    .entries
                                    .length,
                              );
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Color.fromRGBO(47, 179, 178, 0.8)),
                    onPressed: _postApi,
                    child: Text("SANG BƯỚC XÁC NHẬN GIÁ",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 20)
                            )
                            )
              ],
            ),
          if (widget.selectedEmotion == -1) ManHinhcho()
        ]),
        SizedBox(height:30),
        ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            // Xác định màu sắc dựa trên trạng thái của nút
            if (states.contains(MaterialState.pressed)) {
              // Trạng thái khi nút được nhấn
              return Colors.red;
            } else {
              // Trạng thái mặc 
              return Color.fromRGBO(47, 179, 178, 0.8);
            }})),onPressed: _navigator, child: Text("Chuyển sang trang đánh giá trung bình"))
      ],
    );
  }
  void _navigator(){
Navigator.push(context,MaterialPageRoute(builder: (context)=>RateScreen()));
  }
}

class ManHinhcho extends StatelessWidget {
  const ManHinhcho({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          child: Image.asset('assets/images/pk.jpg'),
        ),
        
      ],
    );
  }

}
