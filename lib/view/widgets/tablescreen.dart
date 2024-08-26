import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TableScreen extends StatelessWidget {
  final List<Map<String, dynamic>> fetchedData;

  const TableScreen({Key? key, required this.fetchedData}) : super(key: key);

  Future<void> _exportToCSV(BuildContext context) async {
    final List<List<dynamic>> csvData = [];

    // Add header row
    csvData.add([
      'Timestamp',
      'Humidity',
      'Temperature',
      'Pressure',
      'CO2',
    ]);

    // Add data rows
    fetchedData.forEach((data) {
      csvData.add([
        data['timestamp'],
        data['humdity'],
        data['temperature'],
        data['pressure'],
        data['CO2'],
      ]);
    });

    // Get the document directory using path_provider package
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/data.csv';
    var directory1;
    directory1 = Directory('/storage/emulated/0/Download');
    // Write data to CSV file
    final File file = File(filePath);
    final pathOfTheFileToWrite1 = directory1!.path + "/" + "data" + ".csv";
    print(pathOfTheFileToWrite1);
    File file1 = File(pathOfTheFileToWrite1);
    await file1.writeAsString(const ListToCsvConverter().convert(csvData));

    // Show a dialog to indicate export success
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exportation terminée'),
          content: Text(
              'Les données ont été exportées avec succès vers $pathOfTheFileToWrite1'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau des données'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _exportToCSV(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Timestamp')),
              DataColumn(label: Text('Humidity')),
              DataColumn(label: Text('Temperature')),
              DataColumn(label: Text('Pressure')),
              DataColumn(label: Text('CO2')),
            ],
            rows: fetchedData.map((data) {
              return DataRow(cells: [
                DataCell(Text(data['timestamp'].toString())),
                DataCell(Text(data['humidity'].toString())),
                DataCell(Text(data['temperature'].toString())),
                DataCell(Text(data['pressure'].toString())),
                DataCell(Text(data['CO2'].toString())),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
