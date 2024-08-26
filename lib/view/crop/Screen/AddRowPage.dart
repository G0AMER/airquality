import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddRowPage extends StatefulWidget {
  const AddRowPage({super.key});

  @override
  State<AddRowPage> createState() => _AddRowPageState();
}

class _AddRowPageState extends State<AddRowPage> {
  late Stream<QuerySnapshot> _wheatStream;

  @override
  void initState() {
    super.initState();
    _wheatStream = FirebaseFirestore.instance.collection('wheat').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wheat')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset('assets/water_plant.json', height: 270, width: 270),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: _wheatStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final List<DataRow> tableRows = snapshot.data!.docs.map((doc) {
                  final number = doc['number'];
                  final plant = doc['plant'];
                  final date = doc['date'];
                  final age = doc['age'];

                  return DataRow(
                    cells: [
                      DataCell(Text(number)),
                      DataCell(Text(plant)),
                      DataCell(Text(date)),
                      DataCell(Text(age)),
                    ],
                  );
                }).toList();

                return Column(
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Number')),
                        DataColumn(label: Text('Plant')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Age')),
                      ],
                      rows: tableRows,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _AddRowDialog();
                          },
                        );
                      },
                      child: const Text('Add Row'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AddRowDialog extends StatelessWidget {
  final _numberController = TextEditingController();
  final _plantController = TextEditingController();
  final _dateController = TextEditingController();
  final _ageController = TextEditingController();
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Row'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Number'),
            ),
            TextField(
              controller: _plantController,
              decoration: const InputDecoration(labelText: 'Plant'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final docData = {
              'number': _numberController.text,
              'plant': _plantController.text,
              'date': _dateController.text,
              'age': _ageController.text,
            };
            FirebaseFirestore.instance.collection('wheat').add(docData);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}