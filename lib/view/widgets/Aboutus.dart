import 'package:flutter/material.dart';
import 'package:smart_srrigation/constants.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'mater';
class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 157, 248, 160),
                Color.fromARGB(255, 186, 230, 247)
              ],
              stops: [0.4, 1.3],
            ),
          ),
        ),
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Color.fromARGB(255, 38, 38, 38),
            fontSize: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'AirQuality',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'Our aim is to address the challenges encountered by farmers through the provision of cutting-edge solutions that incorporate modern technology.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Established in 2024-2025 by a team of college friends, we take pride in our ability to design a system to continuously assess and analyze the air within enclosed spaces, ensuring it is safe and healthy for occupants. By tracking levels of pollutants such as carbon dioxide, volatile organic compounds, particulate matter, and humidity, the system helps identify potential hazards that could affect well-being and productivity. The data collected can be used to improve ventilation, manage air purification systems, and take proactive measures to maintain optimal indoor air quality, ultimately protecting the health of individuals and enhancing overall comfort.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 27),
              Text(
                'Values:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '- Customer satisfaction is our top priority',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '- We strive for continuous improvement',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '- We value honesty and integrity in all our actions',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 9),
              //contact information
              Divider(
                thickness: 0.6,
                color: buttonColor,
              ),
              Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Us:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Hydatis'),
                        subtitle: Text('Tunis, TUNISIA'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('+216 36 21 64 06'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.email),
                        title: Text('contact@hydatis.com'),
                      ),
                    ],
                  )),

              //social media
              Divider(
                thickness: 0.6,
                color: buttonColor,
              ),
              Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Follow Us:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                          leading: const Icon(Icons.link),
                          title: const Text('Facebook'),
                          onTap: () async {
                            await launchUrl(Uri.parse(
                                'https://www.facebook.com/hydatis.world/'));
                          }),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text('Linkedin'),
                        onTap: () => launchUrl(Uri.parse(
                            'https://www.linkedin.com/company/hydatis/')),
                      ),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text('Instagram'),
                        onTap: () => launchUrl(Uri.parse(
                            'https://www.instagram.com/hydatis.world/')),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
