import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_hacks/bluetooth_controller/bluetooth_controller.dart';
import 'package:provider/provider.dart';  
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
  
void main() => runApp(MyApp());  

class SwitchModel extends ChangeNotifier {
  bool _value = false;

  bool get value => _value;

  set value(bool newValue) {
    _value = newValue;
    notifyListeners();
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SwitchModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 125, 59, 75),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[MySwitch(), BluetoothPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Title'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(label: 'Switch', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Bluetooth', icon: Icon(Icons.settings)),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MySwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final switchModel = Provider.of<SwitchModel>(context);
    return Container(
      alignment: Alignment.center,
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Switch(
            value: switchModel.value,
            onChanged: (bool value) {
              switchModel.value = value;
            },
            activeColor: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 16.0),
          Text(
            switchModel.value ? 'Switch is on' : 'Switch is off',
            style: TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }
}

class BluetoothPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BluetoothController>(
        init: BluetoothController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.blue,
                  child: const Center(
                    child: Text ("Bluetooth Configuration", 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), 
                Center(
                  child: ElevatedButton(
                    onPressed: () => controller.scanDevices(),
                    style: ElevatedButton.styleFrom (
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(350, 55),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )
                    ),
                    child: const Text(
                      "Scan",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                          final data = snapshot.data![index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(data.device.name),
                              subtitle: Text(data.device.id.id),
                              trailing: Text(data.rssi.toString()),
                            ),
                          );
                        });
                    } else {
                      return const Center(
                        child: Text("No devices found"),
                      );
                    }
                  })
              ],
            ),
          );
        }),
    );
  }
}

