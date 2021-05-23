import 'package:ATrack/BluetoothDeviceListEntry.dart';
import 'package:ATrack/detailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'demodetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), //here we set the homepage
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  //above, this widgetsBindingObserver helps with keep the UI upto date

  BluetoothState _bluetoothState =
      BluetoothState.UNKNOWN; //starts reading bluetooth devices

  List<BluetoothDevice> devices =
      List<BluetoothDevice>(); //list to hold discovered bluetooth devices

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getBTState();
    _stateChangeListener();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.index == 0) {
      //resume
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      }
    }
  }

  _getBTState() {
    //function to get the bluetooth state
    FlutterBluetoothSerial.instance.state.then((state) {
      _bluetoothState = state;
      if (_bluetoothState.isEnabled) {
        _listBondedDevices(); //to list the bluetooth enabled devices
      } else {
        devices.clear();
      }

      setState(() {}); //we need this to redraw the widget
    });
  }

  _stateChangeListener() {
    //function to read the state we had already get
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      _bluetoothState = state;

      //check to see the connected devices
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      } else {
        devices.clear();
      }

      print("State isEnabled: ${state.isEnabled}");
      setState(() {});
    });
  }

  //function to grab all pair of devices and make sure they can be clickable
  _listBondedDevices() {
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      devices = bondedDevices;
      setState(() {});
    });
  }

  @override //now after all the above, lets draw the UI
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ATrack bluetooth serial"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SwitchListTile(
              title: Text("Enable Bluetooth"),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                future() async {
                  if (value) {
                    //if switch value changes
                    await FlutterBluetoothSerial.instance
                        .requestEnable(); //turn on bluetooth
                  } else {
                    await FlutterBluetoothSerial.instance.requestDisable();
                  }

                  future().then((_) {
                    //update screen when there is an event
                    setState(() {});
                  });
                }
              },
            ), // we added a switch

            ListTile(
              //list of bluetooth devices with a setting button that is clickable, fires onpress event
              title: Text("Bluetooth STATUS"),
              subtitle: Text(_bluetoothState.toString()),
              trailing: RaisedButton(
                child: Text("Settings"),
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
              ),
            ),

            //time to add UI for showing the list of discovered devices and let us add a click functionality
            Expanded(
              child: ListView(
                children: devices
                    .map((_device) => BluetoothDeviceListEntry(
                          //above, in BluetoothDeviceEntry i.e. BluetoothDeviceEntry.dart we set how the device entry (row) will look like
                          device: _device,
                          enabled: true,
                          onTap: () {
                            print("Item");
                            _startConnection(context, _device);
                          },
                        ))
                    .toList(),
              ),
            ),

            //widget 3
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                demo_navigate(context);
              },
              child: const Text('Start without device',
                  style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void demo_navigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DemoDetails(),
      ),
    );
  }

  void _startConnection(BuildContext context, BluetoothDevice server) {
    //when clicked on device , navigate to details page
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailPage(
        server: server,
      );
    }));
  }
}
