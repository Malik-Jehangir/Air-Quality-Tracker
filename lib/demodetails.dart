import 'package:ATrack/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DemoDetails extends StatefulWidget {
  @override
  _DemoDetailsState createState() => _DemoDetailsState();
}

class _DemoDetailsState extends State<DemoDetails> {
  String nav = "Test";
  @override //we will build UI here, so far we retreived server name from asing context in navigation code in main.dart
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(("Connected to ATrack")),
      ),

      //continue with body here
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "68 bpm",
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
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "410 ppm",
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
                    title: const Text('Total Volatile Organic Compounds'),
                    subtitle: Text(
                      'Current Forecast',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "50 ppb",
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
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "4.97 ppm",
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
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "0.11 ppm",
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
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "0.11 ppm",
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
                nav = "410" +
                    "," +
                    "50" +
                    "," +
                    "4.97" +
                    "," +
                    "0.11" +
                    "," +
                    "0.11" +
                    "," +
                    "68";
                _navigateTo(context, nav);
              },
              child:
                  const Text('Process Results', style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String results) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Results(results),
      ),
    );
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
}
