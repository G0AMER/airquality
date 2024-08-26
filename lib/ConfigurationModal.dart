import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_srrigation/controller/homecontroller.dart';

class ConfigurationModal extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  ConfigurationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Configuration',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              // Children
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'Ground cover by vegetation',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              // Children
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'Eg: Spacing between emitters',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              // Children
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'E: Line',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'φ: Flow rate',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'H: Pressure',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Title: ETo Parameters
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'ETo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            // ET0 Parameters Table
            Table(
              // Children
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'G: Soil Heat',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'Rn: Net Radiation',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Repeat the above pattern for other parameters
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'GIWR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Table(
              // Children
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'Kc: Crop Coefficient',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Repeat the above pattern for other parameters
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Bnet (NET)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Table(
              // Children
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'Eeff: Irrigation network age',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'RFU',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Table(
              // Children
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            label: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'θ',
                                    style: TextStyle(
                                      fontSize:
                                          12.0, // Adjust the font size here
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'cc',
                                    style: TextStyle(
                                      fontSize:
                                          8.0, // Adjust the font size here
                                    ),
                                  ),
                                  TextSpan(
                                    text: ': Soil texture',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            label: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'θ',
                                    style: TextStyle(
                                      fontSize:
                                          12.0, // Adjust the font size here
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'pfp',
                                    style: TextStyle(
                                      fontSize:
                                          8.0, // Adjust the font size here
                                    ),
                                  ),
                                  TextSpan(
                                    text: ': Soil texture',
                                    style: TextStyle(
                                      fontSize:
                                          12.0, // Adjust the font size here
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'variety',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Table(
              // Children
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'Locale',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // Add your onChanged method here
                          // onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'Introduced',
                            labelStyle: const TextStyle(
                              fontSize: 12.0, // Adjust the font size here
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            // Save the changes
            // Add your save method here
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
