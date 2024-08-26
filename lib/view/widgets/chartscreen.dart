import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:logger/logger.dart';

class chartscreen extends StatefulWidget {
  final List<Map<String, dynamic>> fetchedData;

  const chartscreen({super.key, required this.fetchedData});

  @override
  _chartscreenState createState() => _chartscreenState();
}

class _chartscreenState extends State<chartscreen> {
  late TooltipBehavior _tooltipBehavior;
  late List<Map<String, dynamic>> _liveData; // Store live data here
  var logger = Logger();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, shadowColor: Colors.green);
    _liveData = List<Map<String, dynamic>>.from(
        widget.fetchedData); // Initialize live data
    _liveData.sort((a, b) {
      // Compare timestamps as strings
      return a['timestamp'].compareTo(b['timestamp']);
    });
    logger.w(_liveData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts'),
      ),
      body: ListView.builder(
        itemCount: widget.fetchedData[0].length - 1, // Exclude timestamp
        itemBuilder: (context, index) {
          String key =
              widget.fetchedData[0].keys.elementAt(index + 1); // Skip timestamp
          return _buildChart(key); // Build chart for each value
        },
      ),
    );
  }

  Widget _buildChart(String key) {
    Color backgroundColor;
    Color color;

    // Define background color and series color based on the key
    switch (key) {
      case 'humidity':
        backgroundColor = Colors.blue.withOpacity(0.1); // Set background color
        color = Colors.blue; // Set series color
        break;
      case 'temperature':
        backgroundColor = Colors.red.withOpacity(0.1);
        color = Colors.red;
        break;
      case 'pressure':
        backgroundColor = Colors.purple.withOpacity(0.1);
        color = Colors.purple;
        break;
      case 'co2':
        backgroundColor = Colors.orange.withOpacity(0.1);
        color = Colors.orange;
        break;

      default:
        backgroundColor =
            Colors.grey.withOpacity(0.1); // Default background color
        color = Colors.grey; // Default series color
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Text(
          //   key.toUpperCase(),
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor, // Set background color
              borderRadius:
                  BorderRadius.circular(10), // Optional: Add border radius
            ),
            child: SfCartesianChart(
              tooltipBehavior: _tooltipBehavior,
              // Chart title text
              // title: ChartTitle(text: 'Measurements'),
              // Enables the legend
              legend: Legend(isVisible: true, iconBorderColor: color),
              primaryXAxis: DateTimeAxis(
                dateFormat:
                    DateFormat('EEE hh:mm'), // Show only day of the week
              ),
              series: [
                SplineAreaSeries<Map<String, dynamic>, DateTime>(
                  dataSource: _liveData
                      .where((data) => data[key] != null)
                      .toList(), // Use live data
                  xValueMapper: (data, _) =>
                      data['timestamp'], // Using DateTime directly
                  yValueMapper: (data, _) {
                    if (data[key] is String) {
                      try {
                        return double.tryParse(data[
                            key]); // Convert string to double if moisture is a string
                      } catch (e) {
                        logger.e("Error parsing $key: $e");
                        return null; // Return null if parsing fails
                      }
                    } else {
                      return data[key];
                    }
                  },
                  name: key,
                  color: color, // Set series color
                  gradient: LinearGradient(colors: [
                    color.withOpacity(0.3), // Set gradient color
                    color.withOpacity(0.3), // Set gradient color
                  ]),
                  borderWidth: 2,
                  borderColor: color.withOpacity(0.7), // Set border color

                  // dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
              zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true, // Enable pinch zoom
                enableDoubleTapZooming: true, // Enable double tap zooming
              ),
              // trackballBehavior: TrackballBehavior(
              //   enable: true, // Enable trackball
              //   activationMode: ActivationMode.singleTap, // Set activation mode
              //   tooltipSettings:
              //       InteractiveTooltip(enable: true), // Enable tooltip
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
