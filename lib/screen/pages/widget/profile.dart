// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:logistx/screen/pages/chat.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//   Future<Position?> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // GPS yoqilganligini tekshiramiz
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     print('Location xizmati yoqilmagan');
//     return null;
//   }

//   // Ruxsatlarni tekshiramiz
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       print('Foydalanuvchi joylashuv ruxsatini rad etdi');
//       return null;
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     print('Foydalanuvchi joylashuv ruxsatini butunlay rad etdi');
//     return null;
//   }

//   // Joylashuvni olish
//   return await Geolocator.getCurrentPosition();
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Profile")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('asset/image/download.jpeg'),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Javlon Murodov",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const Text(
//               "murodovjavlon05@gmail.com",
//               style: TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white54,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               icon: Icon(Icons.location_on),
//               label: Text("Location"),
//               onPressed: () {},
//             ),
//             SizedBox(height: 10),

//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white54,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               icon: Icon(Icons.message),
//               label: Text("Send Message"),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return ChatPage();
//                     },
//                   ),
//                 );
//                 // context.go('/chat');
//               },
//             ),

//             // Buttons
//             const SizedBox(height: 20),
//             _buildStatCard("309", "Total Cargoes", Icons.local_shipping),
//             _buildStatCard("309", "Complete", Icons.flag),
//             _buildStatCard("17:04", "Avg Check Out Time", Icons.access_time),
//             _buildStatCard("Employee Predicate", "Role Model", Icons.person),

//             const SizedBox(height: 20),
//             const AttendanceHistoryPage(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _buildStatCard(String value, String title, IconData icon) {
//   return Card(
//     // color: //Colors.grey,
//     margin: const EdgeInsets.symmetric(vertical: 8),
//     child: ListTile(
//       leading: Icon(icon, color: Colors.blue),
//       title: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
//       subtitle: Text(title, style: const TextStyle(color: Colors.grey)),
//     ),
//   );
// }

// class AttendanceHistoryPage extends StatelessWidget {
//   const AttendanceHistoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Attendance History",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),

//         Row(
//           children: [
//             ElevatedButton(onPressed: () {}, child: const Text("Sort")),
//             const SizedBox(width: 10),
//             ElevatedButton(onPressed: () {}, child: const Text("Filter")),
//           ],
//         ),

//         const SizedBox(height: 10),
//         _buildAttendanceCard("March 08 2023", "08:53", "17:15", "Time"),
//         _buildAttendanceCard("March 07 2023", "08:27", "17:09", "Late"),
//         _buildAttendanceCard("March 06 2023", "-", "-", "Absent"),

//         // Pagination (Just UI representation)
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(5, (index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5),
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: index == 0 ? Colors.blue : Colors.white,
//                 ),
//                 child: Text("${index + 1}"),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }

// Widget _buildAttendanceCard(
//   String date,
//   String checkIn,
//   String checkOut,
//   String status,
// ) {
//   return Card(
//     // color: const Color(0xFF1E293B),
//     margin: const EdgeInsets.symmetric(vertical: 8),
//     child: Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.access_time, color: Colors.black),
//               const SizedBox(width: 8),
//               Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
//               const Spacer(),
//               Text(
//                 status,
//                 style: TextStyle(
//                   color:
//                       status == "Late"
//                           ? Colors.orange
//                           : status == "Absent"
//                           ? Colors.red
//                           : Colors.white54,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Check In Time",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                   Text(
//                     checkIn,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Check Out Time",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                   Text(
//                     checkOut,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logistx/screen/pages/chat.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String locationText = "Joylashuv olinmagan";

  Future<void> _getLocation() async {
    Position? position = await determinePosition();
    if (position != null) {
      setState(() {
        // locationText = "Lat: \${position.latitude}, Lng: \${position.longitude}";
      });
    }
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location xizmati yoqilmagan');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Foydalanuvchi joylashuv ruxsatini rad etdi');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Foydalanuvchi joylashuv ruxsatini butunlay rad etdi');
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('asset/image/download.jpeg'),
            ),
            const SizedBox(height: 10),
            const Text(
              "Javlon Murodov",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "murodovjavlon05@gmail.com",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.location_on),
              label: Text("Location"),
              onPressed: _getLocation,
            ),
            SizedBox(height: 10),
            Text(locationText, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.message),
              label: Text("Send Message"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatPage();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildStatCard("309", "Total Cargoes", Icons.local_shipping),
            _buildStatCard("309", "Complete", Icons.flag),
            _buildStatCard("17:04", "Avg Check Out Time", Icons.access_time),
            _buildStatCard("Employee Predicate", "Role Model", Icons.person),
            const SizedBox(height: 20),
            const AttendanceHistoryPage(),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatCard(String value, String title, IconData icon) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(title, style: const TextStyle(color: Colors.grey)),
    ),
  );
}

class AttendanceHistoryPage extends StatelessWidget {
  const AttendanceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Attendance History",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton(onPressed: () {}, child: const Text("Sort")),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: () {}, child: const Text("Filter")),
          ],
        ),
        const SizedBox(height: 10),
        _buildAttendanceCard("March 08 2023", "08:53", "17:15", "Time"),
        _buildAttendanceCard("March 07 2023", "08:27", "17:09", "Late"),
        _buildAttendanceCard("March 06 2023", "-", "-", "Absent"),
      ],
    );
  }
}

Widget _buildAttendanceCard(
  String date,
  String checkIn,
  String checkOut,
  String status,
) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.black),
              const SizedBox(width: 8),
              Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(
                status,
                style: TextStyle(
                  color:
                      status == "Late"
                          ? Colors.orange
                          : status == "Absent"
                          ? Colors.red
                          : Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Check In Time",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    checkIn,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Check Out Time",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    checkOut,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
