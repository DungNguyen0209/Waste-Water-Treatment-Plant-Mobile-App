import 'package:dashboardbtl_plc/Manual.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signalr_netcore/hub_connection.dart';

import 'package:signalr_netcore/hub_connection_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // card text style
  var cardTextStyle = TextStyle(
      fontFamily: 'Montserrat Regular',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(63, 63, 63, 1));
  final severUrl = "https://serverplctest.azurewebsites.net/movehub";
  late HubConnection hubConnection;
  String value_1 = "Motor Value",value_2= "Valve Value",value_3="Clo Gas Value", connected ="DisConnect";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSignalR();
    //position=Offset(0.0,-20.0); //default position
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/image/top_header.png')),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 64,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/image/avatar.jpg'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Nhom 4',
                                style: TextStyle(
                                    fontFamily: 'Montserrat Medium',
                                    color: Colors.white,
                                    fontSize: 20)),
                            Text('123456',
                                style: TextStyle(
                                    fontFamily: 'Montserrat Medium',
                                    color: Colors.white,
                                    fontSize: 15))
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      primary: false,
                      children: <Widget>[
                        InkWell(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.network(
                                    'https://image.flaticon.com/icons/svg/1904/1904425.svg',
                                    height: 115),
                                Text(
                                  'Manual',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: (){
                            Route route = MaterialPageRoute(builder: (context) => Manual());
                            Navigator.push(context, route);
                          },
                        ),

                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                  'assets/image/electric-motor.svg',
                                  height: 115),
                              Text(
                                value_1,
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset('assets/image/valve.svg',
                                  height: 115),
                              Text(
                                value_2,
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset('assets/image/oxygen-tank.svg',
                                  height: 115),
                              Text(
                                value_3,
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.only(top: 500),
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.lightGreenAccent,
                  elevation: 10,
                  child: ListTile(
                    leading: const Icon(Icons.adjust_rounded),
                    title: Text(
                        "Connecting Status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        )
                    ),
                    subtitle: Text(connected,style: TextStyle(fontSize: 18,color: Colors.black),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          hubConnection.state == HubConnectionState.Disconnected
              ? await hubConnection.start()
              : await hubConnection.stop();
          setState(() {
            if( hubConnection.state == HubConnectionState.Disconnected)
            {
              value_1 = "Motor Value";
              value_2= "Valve Value";
              value_3="Clo Gas Value";
              connected ="Disconnect";
            }
            else
              {
                connected ="Connected";
              }
          });

          // Update icon
          setState(() {
            print(hubConnection.state == HubConnectionState.Disconnected
                ? 'Stop'
                : 'Start');
          });
        },
        tooltip: 'Start/Stop',
        child: hubConnection.state == HubConnectionState.Disconnected
            ? Icon(Icons.play_arrow,color: Colors.red,)
            : Icon(Icons.stop,color: Colors.lightGreenAccent,),
      ),
    );
  }

  void initSignalR() {
    var e = new Exception('Thông báo lỗi');
    try{
      hubConnection = HubConnectionBuilder().withUrl(severUrl).build();
      hubConnection.on("ReceiveNewPosition", _handleNewPosition);
    }
    catch(e)
    {
      //hubConnection.onclose((Exception exception ) => print('Connection close'));
      print(e);
    }
  }
  void _handleNewPosition(List<dynamic> args) {
    setState(() {
      value_1= args[0];
      value_2 = args[1];
      value_3 = args[2];
    });
  }
}
