import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodstorefront/screens/store_screen.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';

class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({super.key});

  @override
  LocationAccessScreenState createState() => LocationAccessScreenState();
}

class LocationAccessScreenState extends State<LocationAccessScreen> {
  // Future<void> _checkLocationPermission() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.always ||
  //       permission == LocationPermission.whileInUse) {
  //     Navigator.pushReplacementNamed(context, '/home');
  //   }
  // }

  // Future<void> _requestLocationPermission() async {
  //   PermissionStatus status = await Permission.location.request();
  //   if (status.isGranted) {
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } else if (status.isDenied || status.isPermanentlyDenied) {
  //     _showSnackBar(
  //         context, 'Location permission is required to use this app.');
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _checkLocationPermission();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light, // For iOS: (dark icons)
          statusBarIconBrightness: Brightness.dark, // For Android: (dark icons)
          statusBarColor: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const SizedBox(height: 50),
            Image.asset(
              ImagesStrings.location,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: const Text(
                'Allow location access on the next screen for:',
                style: TextStyle(
                  height: 1.1,
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: MyColors.lightPrimary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.moped_outlined,
                      color: MyColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Finding the best restaurants\n and shops near you',
                      style: TextStyle(
                          height: 1.1,
                          fontSize: 17,
                          color: MyColors.textSecondary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: MyColors.lightPrimary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.storefront_outlined,
                      color: MyColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Faster and more accurate\n delivery',
                      style: TextStyle(
                          height: 1.1,
                          fontSize: 17,
                          color: MyColors.textSecondary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 241, 241, 241)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoreScreen()),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void openLocationSettings() {
  //   openAppSettings().then((_) {
  //     print('Opened app settings');
  //   }).catchError((error) {
  //     print('Error opening app settings: $error');
  //   });
  // }

  //Start Show Message
  // void _showSnackBar(BuildContext context, String message,
  //     [Color color = Colors.red]) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           const Icon(Icons.error_outline, color: Colors.white),
  //           const SizedBox(width: 8),
  //           Expanded(
  //             child: Text(
  //               message,
  //               textAlign: TextAlign.left,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 16.0,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       backgroundColor: color,
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       margin: const EdgeInsets.all(12),
  //       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }
  //End Show Message
}
