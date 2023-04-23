import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  BluetoothController(): super();
  // Bluetooth instances
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  // scam devices for bluetooth connection
  Future scanDevices() async {
    // scans for 5 seconds
    flutterBlue.startScan(timeout: const Duration(seconds: 5));
    // stopping the scan
    flutterBlue.stopScan();
  }

  // show all available devices
  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;



}