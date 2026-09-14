import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(home: HiveDashboard()));

class HiveDashboard extends StatefulWidget {
  @override
  _HiveDashboardState createState() => _HiveDashboardState();
}

class _HiveDashboardState extends State<HiveDashboard> {
  String hiveId = "Loading...";
  String weight = "0.0";
  String temperature = "0.0";
  String statusMessage = "";

  // Make sure your phone/emulator and laptop are on the same WiFi.
  // Replace this IP with your laptop's IPv4 address (e.g. 192.168.1.5)
  final String apiUrl = "http://10.118.255.158:8000"; 

  @override
  void initState() {
    super.initState();
    fetchHiveStatus();
  }

  fetchHiveStatus() async {
    final response = await http.get(Uri.parse('$apiUrl/hive-status'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        hiveId = data['hive_id'];
        weight = data['weight'].toString();
        temperature = data['temperature'].toString();
      });
    }
  }

  createBlockchainBatch() async {
    setState(() => statusMessage = "Minting to Blockchain...");
    final response = await http.post(
      Uri.parse('$apiUrl/create-batch?hive_id=$hiveId&weight=${double.parse(weight).toInt()}'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        statusMessage = "Success! TX Hash: ${data['tx_hash']}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Beekeeper Dashboard")),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Hive ID: $hiveId", style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text("Live Weight: $weight kg", style: TextStyle(fontSize: 20)),
            Text("Internal Temp: $temperature °C", style: TextStyle(fontSize: 20)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: createBlockchainBatch,
              child: Text("Harvest & Secure on Blockchain"),
            ),
            SizedBox(height: 20),
            Text(statusMessage, style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}