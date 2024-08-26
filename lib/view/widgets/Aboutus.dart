import 'package:smart_srrigation/constants.dart';
import 'package:flutter/material.dart';
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
                'PFA(Smart Irrigation)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'Our aim is to address the challenges encountered by farmers through the provision of cutting-edge solutions that incorporate modern technology.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Established in 2023-2024 by a team of college friends, we take pride in our ability to address irrigation issues and minimize water wastage in agricultural processes through the utilization of the fuzzy logic and machine learning , which predicts the minimum amount of water required for irrigation.',
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
                        title: Text('ENIS'),
                        subtitle: Text('SFAX, TUNISIA'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('+216 -- --- ---'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.email),
                        title: Text('ZED@ZED.ZED'),
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
                            await launchUrl(
                                Uri.parse('https://www.facebook.com'));
                          }),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text('Twitter'),
                        onTap: () => launchUrl(
                            Uri.parse('https://www.twitter.com/')),
                      ),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text('Instagram'),
                        onTap: () => launchUrl(
                            Uri.parse('https://www.instagram.com/')),
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
