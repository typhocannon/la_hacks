import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  
  
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
    return Center(
      child: Text(
        'Bluetooth Settings',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}