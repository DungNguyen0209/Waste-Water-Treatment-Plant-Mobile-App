import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Manual extends StatefulWidget {
  const Manual({Key? key}) : super(key: key);

  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text("Manual"),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                subtitle: Text(
                  "Các ô ký hiệu sẽ biểu hiện cho từng thiết bị của nó , ở dưới chính là thông số của các thiết bị . ",
                ),
              ),
              ListTile(
                  leading: Icon(Icons.arrow_forward_ios),
                  subtitle: Text(
                    "Sau khi mở app , ta ấn vào nút nhỏ ở góc dưới bên phải để kết nối với máy chủ . Trạng thái hoạt động sẽ được thể hiện ở ô CONNECT STATUS,",
                  ),
              )
            ],
          ),
        ));
  }
}
