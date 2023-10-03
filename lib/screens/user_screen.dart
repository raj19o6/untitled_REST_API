import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:untitled/screens/model/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  Future<void> _launchPhoneCall(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        automaticallyImplyLeading: false,
        toolbarHeight: 300,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 10, color: Colors.white)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    user.picture.large,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Gap(20),
            Text(
              user.fullName,
              style: const TextStyle(fontSize: 25),
            ),
            const Gap(10),
            Text(
              user.email,
              style: const TextStyle(color: Colors.white54, fontSize: 15),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
                    color: Colors
                        .white, // Replace with your desired background color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey, // Choose the shadow color
                        blurRadius: 5.0, // Adjust the blur radius as needed
                        offset:
                            Offset(0, 2), // Adjust the offset (x, y) as needed
                        spreadRadius: 2.0, // Adjust the spread radius as needed
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            CupertinoIcons.person,
                            size: 50,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          const Text(
                            "Details",
                            style: TextStyle(fontSize: 25),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () {
                              _launchPhoneCall(user.cell);
                              print("called");
                            },
                            child: Text(
                              "Phone: ${user.cell}",
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text("Gender: ${user.gender}"),
                          Text("Date of Birth: ${user.dob.date.toLocal()}"),
                          Text("Age: ${user.dob.age}"),
                          const Gap(20),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                const Text("Address:"),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Street: ${user.location.street.name} ${user.location.street.number}"),
                      Text("City: ${user.location.city}"),
                      Text("State: ${user.location.state}"),
                      Text("Country: ${user.location.country}"),
                      Text("Postal Code: ${user.location.postalcode}"),
                    ],
                  ),
                ),
                const Gap(20),
                const Text("Location on Map:"),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                        double.parse(user.location.cordinated.latitude),
                        double.parse(user.location.cordinated.longitude),
                      ),
                      zoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 45.0,
                            height: 45.0,
                            point: LatLng(
                              double.parse(user.location.cordinated.latitude),
                              double.parse(user.location.cordinated.longitude),
                            ),
                            builder: (ctx) => Container(
                              child: const Icon(
                                Icons.location_pin,
                                size: 45.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
