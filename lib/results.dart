import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:ATrack/air_model.dart';
import 'package:ATrack/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gauge/flutter_gauge.dart';

String MainString = "";
String FinalString = "Analyzing...";
List<String> sensorValues = new List<String>();
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
Random random = new Random();
double pmValue;

final DateTime now = DateTime.now();
/*final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter. format(now);*/

class Results extends StatefulWidget {
  final String results;

  const Results(this.results, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    MainString = widget.results;
    CallML(MainString);

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Air Analysis Report"),
        ),

        //continue with body here
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Widget 0
            Text(
              "\n\nResults processed at $now\n\n",
              textAlign: TextAlign.center,
              textScaleFactor: 2.0,
              style: TextStyle(color: Colors.blue[200], fontSize: 10.0),
            ),

            //Widget8
            Image.asset(
              "images/earth.gif",
              height: 125.0,
              width: 125.0,
            ),
            //Widget 1
            Text(
              "\n\n$FinalString\n\n",
              textAlign: TextAlign.center,
              textScaleFactor: 2.0,
              style: TextStyle(color: Colors.blue[200], fontSize: 10.0),
            ),

            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
            ),

            //Widget
            Text(
              "\nSummary\n\n",
              textAlign: TextAlign.center,
              textScaleFactor: 2.0,
              style: TextStyle(color: Colors.blue[200], fontSize: 10.0),
            ),

            //Table Widget
            DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  'Air Component',
                  style: TextStyle(color: Colors.amber[300]),
                )),
                DataColumn(
                    label: Text(
                  'Concentration',
                  style: TextStyle(color: Colors.amber[300]),
                )),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text(
                    'Carbondioxide',
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    '${sensorValues[0]} ppm',
                    style: TextStyle(color: Colors.white),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text(
                    'Total Volatile Compounds',
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    '${sensorValues[1]} ppb',
                    style: TextStyle(color: Colors.white),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text(
                    'Carbonmonoxide',
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    '${sensorValues[2]} ppm',
                    style: TextStyle(color: Colors.white),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text(
                    'Nitrogendioxide',
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    '${sensorValues[3]} ppm',
                    style: TextStyle(color: Colors.white),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text(
                    'Ammonia',
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    '${sensorValues[4]} ppm',
                    style: TextStyle(color: Colors.white),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text(
                    'Heart Rate',
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    '${sensorValues[5]} bpm',
                    style: TextStyle(color: Colors.white),
                  ))
                ]),
              ],
            ),

            //Divider
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
            ),
            //Widget
            Text(
              "\nThe Particulate Matter [PM2.5] concentration\n",
              textAlign: TextAlign.center,
              textScaleFactor: 2.0,
              style: TextStyle(color: Colors.blue[200], fontSize: 10.0),
            ),
/*double.parse(sensorValues[1]) +
                  double.parse(sensorValues[3]) +
                  double.parse(sensorValues[4])*/
            //widget gauge

            FlutterGauge(
                secondsMarker: SecondsMarker.none,
                hand: Hand.short,
                handColor: Colors.grey,
                width: 280,
                number: Number.none,
                index: double.parse(sensorValues[1]) +
                    double.parse(sensorValues[3]) +
                    double.parse(sensorValues[4]),
                circleColor: Color(0xFF9DC1DC),
                counterStyle: TextStyle(color: Colors.white, fontSize: 25),
                counterAlign: CounterAlign.center,
                isDecimal: false),

//Widget
            Text(
              "Unhealthy for sensitive individuals\n",
              textAlign: TextAlign.center,
              textScaleFactor: 2.0,
              style: TextStyle(color: Colors.blue[200], fontSize: 10.0),
            ),

            //widget 2
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                _navigateTo(context);
              },
              child: const Text('Your Helpline 24/7',
                  style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 30),

            //widget 3
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                sendAirQualityResults(
                    now.toString(), sensorValues, FinalString);
              },
              child: const Text('Send the Results',
                  style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 30),
          ],
        )));
  }

  void _navigateTo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatBot(),
      ),
    );
  }

  Future<AirModel> getAirQualityResults(List<String> y) async {
    //parsing from string double to string int for machine learning parameters data type
    var y0 = double.parse(y[0]);
    int fy0 = y0.toInt();

    var y1 = double.parse(y[1]);
    int fy1 = y1.toInt();

    var y2 = double.parse(y[2]);
    int fy2 = y2.toInt();

    var y3 = double.parse(y[3]);
    int fy3 = y3.toInt();

    var url =
        'https://ussouthcentral.services.azureml.net/workspaces/78cdf231c2a349bdbff24b561c9f4055/services/3224ac28233b4f9d9b513cb95c1f49a7/execute?api-version=2.0&details=true';
    String data =
        "{\"Inputs\":{\"input1\":{\"ColumnNames\":['CO2','TVOC','CO','NH3','NO2'],\"Values\":[[\"${fy0.toString()}\",\"${fy1.toString()}\",\"${fy2.toString()}\",\"${fy3.toString()}\",\"${y[4]}\"],[\"${fy0.toString()}\",\"${fy1.toString()}\",\"${fy2.toString()}\",\"${fy3.toString()}\",\"${y[4]}\"]]}},\"GlobalParameters\":{}}";
    var response = await http.post(url,
        headers: {
          "Authorization":
              "Bearer i6VSQNF93A1KAI6+d11+JQWMNQYnxA0zq5cnvbI1cU34iJdj9/PKwDl7VjsuHIqC4AhwTVA5MPcHqtkVgblxPw==",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: data);

    var parsedJson = json.decode(response.body);
    var user = AirModel.fromJson(parsedJson);

    setState(() {
      FinalString = user.results.output1.value.values[0][0];
    });
  }

  void CallML(String x) {
    var test = x.split(",");
    for (String alltests in test) {
      sensorValues.add(alltests);
    }
    getAirQualityResults(sensorValues);
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<AirModel> sendAirQualityResults(
      String x, List<String> y, String z) async {
    var url =
        'https://atrackstorage1.table.core.windows.net/atrackreports?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-05-30T22:28:22Z&st=2021-01-26T15:28:22Z&spr=https&sig=nmSFNQ%2B8FBW5fFmii1TrUxNpIkJg9QN%2Fww3suHVLCHU%3D';

    String pkey = getRandomString(10);
    int randomNumber = random.nextInt(100);
    String rkey = randomNumber.toString();

    String data =
        "{\"PartitionKey\":\"${pkey}\",\"RowKey\":\"${rkey}\",\"Carbondioxide\":\"${y[0]}\",\"TVOC\":\"${y[1]}\",\"Carbonmonoxide\":\"${y[2]}\",\"Nitrogendioxide\":\"${y[3]}\",\"Ammonia\":\"${y[4]}\",\"Heart_Rate\":\"${y[5]}\",\"Report\":\"${z}\",\"Test_date\":\"${x}\"}";

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: data);

    _showCupertinoDialog();
    print(response);
  }

  _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Azure Storage Response"),
              content: new Text("Your report has been saved!"),
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
