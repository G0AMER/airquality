import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:smart_srrigation/controller/authcontroller.dart';

class CurrentTask extends StatefulWidget {
  const CurrentTask({super.key});

  @override
  _CurrentTaskState createState() => _CurrentTaskState();
}

class _CurrentTaskState extends State<CurrentTask> {
  bool isLoading = false; // Loading state
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = homecontroller.fetchSystemData();
    _fetchData(); // Fetch system data when initializing
  }

  Future<void> _fetchData() async {
    setState(() {
      homecontroller.fetchSystemData();
      isLoading = true; // Set loading to true
    });

    try {
      await homecontroller.fetchSystemData(); // Fetch system data
    } catch (e) {
      Logger().e('Error fetching data: $e');
    }

    setState(() {
      isLoading = false; // Set loading to false after data is fetched
    });
  }

  Widget _getIconForDataType(String dataType, double parentWidth) {
    double iconSize = parentWidth * 0.15; // Slightly larger icon

    switch (dataType) {
      case 'temperature':
        return Image.asset('assets/temperature.png',
            width: iconSize, height: iconSize);
      case 'humidity':
        return Image.asset('assets/moisture.png',
            width: iconSize, height: iconSize);
      case 'pressure':
        return Image.asset('assets/ec.png', width: iconSize, height: iconSize);
      case 'CO2':
        return Image.asset('assets/o2.png', width: iconSize, height: iconSize);
      default:
        return Image.asset('assets/404.png', width: iconSize, height: iconSize);
    }
  }

  Widget _getTextWidget(String text, double fontSizeMultiplier) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double parentWidth = constraints.maxWidth;
        double fontSize = parentWidth * fontSizeMultiplier;
        return Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Change to black for better contrast
          ),
        );
      },
    );
  }

  Widget _getSubtitleForDataType(
      String dataType, dynamic value, DateTime currentTimestamp) {
    var logger = Logger();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double parentWidth = constraints.maxWidth;
        if (value is Map<String, dynamic>) {
          try {
            String timestampString = value['timestamp'].toString();
            DateTime timestamp = DateTime.parse(timestampString);
            Duration difference = currentTimestamp.difference(timestamp);
            String timestampDifference = _formatTimestampDifference(difference);

            return Text(
              '$timestampDifference ago',
              style: TextStyle(
                fontSize: parentWidth * 0.05,
                color: Colors.black54, // Lighter black for contrast
              ),
            );
          } catch (e) {
            logger.e(e);
          }
        }
        return const Text("N/A");
      },
    );
  }

  String _formatTimestampDifference(Duration difference) {
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return '${difference.inSeconds}s';
    }
  }

  String _getUnitForDataType(String dataType) {
    switch (dataType) {
      case 'temperature':
        return '°C';
      case 'humidity':
        return '%'; // Humidity is typically shown as a percentage
      case 'pressure':
        return 'hPa'; // Pressure in Pascals
      case 'CO2':
        return 'ppm'; // CO2 concentration in parts per million
      default:
        return ''; // No unit for unknown data types
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text(
                'Current Data',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // Title color for contrast
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RefreshIndicator(
                  onRefresh: _fetchData, // Call fetchData on refresh
                  child: FutureBuilder<void>(
                    future: _fetchDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show CircularProgressIndicator while data is being fetched
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        ));
                      } else if (snapshot.hasError) {
                        // Handle errors
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: homecontroller.latestData.isNotEmpty
                              ? homecontroller.latestData[0].keys.length -
                                  1 // Exclude timestamp
                              : 0,
                          itemBuilder: (context, index) {
                            String key = homecontroller.latestData[0].keys
                                .toList()[index + 1]; // Skip timestamp
                            String unit =
                                _getUnitForDataType(key); // Get the unit

                            return GestureDetector(
                              onTap: () {
                                // Handle tap for more details or interaction
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      _getTextWidget(key, 0.06),
                                      _getTextWidget(
                                        '${homecontroller.latestData[0][key]} $unit',
                                        // Display value with unit
                                        0.1,
                                      ),
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          return SizedBox(
                                            width: constraints.maxWidth * 0.4,
                                            height: constraints.maxWidth * 0.4,
                                            child: _getIconForDataType(
                                                key, constraints.maxWidth),
                                          );
                                        },
                                      ),
                                      _getSubtitleForDataType(
                                        key,
                                        homecontroller.latestData[0],
                                        DateTime.now(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
