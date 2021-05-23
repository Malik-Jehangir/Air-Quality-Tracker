import 'dart:io';
import 'dart:typed_data';
import 'package:ATrack/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:convert' show utf8;
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';

class DetailPage extends StatefulWidget {
  final BluetoothDevice server;

  const DetailPage({this.server});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  BluetoothConnection connection;
  bool isConnecting = true;

  bool get isConnected => connection != null && connection.isConnected;
  bool isDisconnecting = false;

  String _selectedFrameSize;
  String MainString1 = "";
  String MainString2 = "";
  String MainString3 = "";
  String MainString4 = "";
  String MainString5 = "";
  String MainString6 = "";

  List<List<int>> chunks = <List<int>>[];
  List<String> sensorValues = new List<String>();
  String nav = "Test";
  List<String> CO2 = new List<String>();
  List<String> TVOC = new List<String>();
  List<String> CO = new List<String>();
  List<String> NO2 = new List<String>();
  List<String> NH3 = new List<String>();
  List<String> HR = new List<String>();

  int contentLength = 0;
  Uint8List _bytes;

  RestartableTimer _timer;

  @override
  void initState() {
    super.initState();
    _getBTConnection();
    _timer = new RestartableTimer(Duration(seconds: 5), _drawImage);
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    _timer.cancel();
    super.dispose();
  }

  _getBTConnection() {
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      connection = _connection;
      isConnecting = false;
      isDisconnecting = false;
      setState(() {});
      connection.input.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally');
        } else {
          print('Disconnecting remotely');
        }
        if (this.mounted) {
          setState(() {});
        }
        Navigator.of(context)
            .pop(); //to return to pervious homeage after disconnection
      });
    }).catchError((error) {
      Navigator.of(context)
          .pop(); //to return to pervious homeage after disconnection
    });
  }

  String test = "";
  _drawImage() {
    if (chunks.length == 0 || contentLength == 0) return;

    _bytes = Uint8List(contentLength);
    int offset = 0;
    for (final List<int> chunk in chunks) {
      _bytes.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
      //print("Hello chunks" + utf8.decode(chunk));
      test = test + utf8.decode(chunk);
    }
    //print(test);

    var test2 = test.split(",");
    for (String alltests in test2) {
      sensorValues.add(alltests);
    }
    for (int i = 0; i < sensorValues.length; i++) {
      //print(i.toString() + " " + sensorValues[i]);
      CO2.add(sensorValues[0]);
      TVOC.add(sensorValues[1]);
      CO.add(sensorValues[2]);
      NO2.add(sensorValues[3]);
      NH3.add(sensorValues[4]);
      HR.add(sensorValues[5]);
    }

    //print(i.toString() + " " + sensorValues[i]);
    //Only print last values of these arrays
    /*print("Carbondioxide: " + CO2.last);
    print("Total Volatile Compounds: " + TVOC.last);
    print("Carbon Monoxide: " + CO.last);
    print("Nitrogen: " + NO2.last);
    print("Ammonia: " + NH3.last);
    print("Heart Rate: " + HR.last);*/

    MainString1 = CO2.last;

    MainString2 = TVOC.last;

    MainString3 = CO.last;

    MainString4 = NO2.last;

    MainString5 = NH3.last;

    MainString6 = HR.last;

    sensorValues.clear();
    test = "";
    setState(() {});

    contentLength = 0;
    chunks.clear();
  }

  ///
  void _onDataReceived(Uint8List data) {
    if (data != null && data.length > 0) {
      chunks.add(data);
      contentLength += data.length;
      _timer.reset();
    }

    //print("Data Length: ${data.length}, chunks: ${chunks.length} : " +
    //utf8.decode(data));
  }

  @override //we will build UI here, so far we retreived server name from asing context in navigation code in main.dart
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: (isConnecting
              ? Text('Connecting to ${widget.server.name} ...')
              : isConnected
                  ? Text('Connected with ${widget.server.name}')
                  : Text('Disconnected with ${widget.server.name}')),
        ),

        //continue with body here
        body: SingleChildScrollView(
          child: isConnected
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //widget 1
                    /*new Text(
                      "$MainString",
                      style: new TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),*/
//Widget 7
                    //widget HR
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: const Text('Heart Rate'),
                            subtitle: Text(
                              'Current Forecast',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "$MainString6 bpm",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogHR();
                                },
                                child: const Text(
                                    'INFORMATION'), //pop up on what to do when gas is too much?
                              ),
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogHRalert();
                                },
                                child: const Text(
                                    'QUICK ACTION'), //pop up on what to do when gas is too much?
                              ),
                            ],
                          ),
                          Image.network(
                              'https://i.pinimg.com/originals/b3/70/5c/b3705cc2edf8f527789e6e2be29f6267.gif'),
                        ],
                      ),
                    ),

                    //widget 2
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: const Text('Carbondioxide'),
                            subtitle: Text(
                              'Current Forecast',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "$MainString1 ppm",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogCarbon();
                                },
                                child: const Text(
                                    'INFORMATION'), //pop up on what to do when gas is too much?
                              ),
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogCarbonalert();
                                },
                                child: const Text(
                                    'QUICK ACTION'), //pop up on what to do when gas is too much?
                              ),
                            ],
                          ),
                          //Image.asset('assets/card-sample-image.jpg'),
                          //Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),
                    //widget 3
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title:
                                const Text('Total Volatile Organic Compounds'),
                            subtitle: Text(
                              'Current Forecast',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "$MainString2 ppb",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogTvoc();
                                },
                                child: const Text(
                                    'INFORMATION'), //pop up on what to do when gas is too much?
                              ),
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogTvocalert();
                                },
                                child: const Text(
                                    'QUICK ACTION'), //pop up on what to do when gas is too much?
                              ),
                            ],
                          ),
                          //Image.asset('assets/card-sample-image.jpg'),
                          //Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),

                    //widget 4
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: const Text('Carbon Monoxide'),
                            subtitle: Text(
                              'Current Forecast',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "$MainString3 ppm",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogCO();
                                },
                                child: const Text(
                                    'INFORMATION'), //pop up on what to do when gas is too much?
                              ),
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogCOalert();
                                },
                                child: const Text(
                                    'QUICK ACTION'), //pop up on what to do when gas is too much?
                              ),
                            ],
                          ),
                          //Image.asset('assets/card-sample-image.jpg'),
                          //Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),

                    //widget 5
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: const Text('Nitrogendioxide'),
                            subtitle: Text(
                              'Current Forecast',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "$MainString4 ppm",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogNo();
                                },
                                child: const Text(
                                    'INFORMATION'), //pop up on what to do when gas is too much?
                              ),
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogNoalert();
                                },
                                child: const Text(
                                    'QUICK ACTION'), //pop up on what to do when gas is too much?
                              ),
                            ],
                          ),
                          //Image.asset('assets/card-sample-image.jpg'),
                          //Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),

                    //Widget 6
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: const Text('Ammonia'),
                            subtitle: Text(
                              'Current Forecast',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "$MainString5 ppm",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogNh();
                                },
                                child: const Text(
                                    'INFORMATION'), //pop up on what to do when gas is too much?
                              ),
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  _showCupertinoDialogNhalert();
                                },
                                child: const Text(
                                    'QUICK ACTION'), //pop up on what to do when gas is too much?
                              ),
                            ],
                          ),
                          //Image.asset('assets/card-sample-image.jpg'),
                          //Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),

                    //widget 9
                    const SizedBox(height: 30),
                    RaisedButton(
                      onPressed: () {
                        nav = MainString1 +
                            "," +
                            MainString2 +
                            "," +
                            MainString3 +
                            "," +
                            MainString4 +
                            "," +
                            MainString5 +
                            "," +
                            MainString6;
                        _navigateTo(context, nav);
                      },
                      child: const Text('Process Results',
                          style: TextStyle(fontSize: 15)),
                    ),
                    const SizedBox(height: 30),
                  ],
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    "\n\n\n\n\n\n\n\nConnecting....", //show black screen with "connecting..." in white text
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
        ));
  }

  void _navigateTo(BuildContext context, String results) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Results(results),
      ),
    );
  }

  _showCupertinoDialogCarbon() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Carbondioxide quick action"),
              content: new Text(
                  "Moderate to high levels of carbon dioxide can cause headaches and fatigue, and higher concentrations can produce nausea, dizziness, and vomiting. Loss of consciousness can occur at extremely high concentrations."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogTvoc() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Total Volatile Compounds"),
              content: new Text(
                  "Volatile organic compounds are compounds that have a high vapor pressure and low water solubility. Many VOCs are human-made chemicals that are used and produced in the manufacture of paints, pharmaceuticals, and refrigerants."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogCO() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Carbonmonoxide"),
              content: new Text(
                  "Household appliances, such as gas fires, boilers, central heating systems, water heaters, cookers, and open fires which use gas, oil, coal and wood may be possible sources of CO gas. It happens when the fuel does not burn fully. Running a car engine in an enclosed space can cause CO poisoning."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogNo() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Nitrogendioxide"),
              content: new Text(
                  "Nitrogen dioxide causes a range of harmful effects on the lungs, including: ... Reduced lung function; Increased asthma attacks; and. Greater likelihood of emergency department and hospital admissions."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogNh() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Ammonia"),
              content: new Text(
                  "It is found in water, soil, and air, and is a source of much needed nitrogen for plants and animals. Most of the ammonia in the environment comes from the natural breakdown of manure and dead plants and animals. Ammonia is considered a severe health hazard due to its toxicity. Exposure to 300 ppm is immediately dangerous to life and health (IDLH) and can be fatal within a few breaths. Ammonia is corrosive to the skin, eyes and lungs."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogHRalert() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Lower the Heart Rate"),
              content: new Text(
                  "To relax your heart, try the Valsalva maneuver: “Quickly bear down as if you are having a bowel movement,” Elefteriades says. “Close your mouth and nose and raise the pressure in your chest, like you're stifling a sneeze.” Breathe in for 5-8 seconds, hold that breath for 3-5 seconds, then exhale slowly."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogCarbonalert() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Carbondioxide quick action"),
              content: new Text(
                  "To prevent or reduce high concentrations of carbon dioxide in a building or room, fresh air should be supplied to the area."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogTvocalert() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("TVOC quick action"),
              content: new Text(
                  "Increasing ventilation through opening windows, clearing air vents, installing under door vents, are each small changes that can help combat high levels, A great way to optimize indoor ventilation is to monitor indoor air quality and adjust ventilation based on the results."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogCOalert() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Carbonmonoxide quick action"),
              content: new Text(
                  "If you or someone you're with develops signs or symptoms of carbon monoxide poisoning — headache, dizziness, nausea, shortness of breath, weakness, confusion — get into fresh air immediately and call 112 or emergency medical help."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogNoalert() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Nitrogendioxide quick action"),
              content: new Text(
                  "Keep gas appliances properly adjusted. Consider purchasing a vented space heater when replacing an un-vented one. Use proper fuel in kerosene space heaters. Install and use an exhaust fan vented to outdoors over gas stoves."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogNhalert() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Ammonia quick action"),
              content: new Text(
                  "There is no antidote for ammonia poisoning, but ammonia's effects can be treated, and most people recover. Persons who have experienced serious signs and symptoms (such as severe or persistent coughing or burns in the throat) may need to be hospitalized."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialogHR() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Heart Rate"),
              content: new Text(
                  "A normal resting heart rate for adults ranges from 60 to 100 beats per minute. Generally, a lower heart rate at rest implies more efficient heart function and better cardiovascular fitness. For example, a well-trained athlete might have a normal resting heart rate closer to 40 beats per minute."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
