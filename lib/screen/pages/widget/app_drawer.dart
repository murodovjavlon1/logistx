import 'package:flutter/material.dart';
import 'package:logistx/screen/pages/chat.dart';
import 'package:logistx/screen/pages/my_application.dart';
import 'package:logistx/screen/pages/my_vehicles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Container(
                      height: 40,
                      width: 50,
                      child: Icon(Icons.local_shipping),
                    ),
                  ),
                  // ),
                  SizedBox(width: 10),
                  Text("DRIVER"),
                ],
              ),
              automaticallyImplyLeading: false,
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.grid_view),
                title: const Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            //  const Divider(),
            // Text("Main Menu"),
            Card(
              child: ListTile(
                leading: const Icon(Icons.chat),
                title: const Text("Chat"),
                onTap: () {
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
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_shipping),
                title: const Text("My vehicles"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyVehicles();
                      },
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.apps),
                title: const Text("Applications"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NoDataScreen();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
