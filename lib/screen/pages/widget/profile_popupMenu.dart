import 'package:flutter/material.dart';

class ProfilePopupMenu {
  static Future<void> show(BuildContext context, Offset position) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    String? selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + 40, // CircleAvatar tagida chiqishi uchun
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      color: Colors.white, // Oq fonda bo‘lishi uchun
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem<String>(
          enabled: false,
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text(
              "Javlon Murodov",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem<String>(
          value: "settings",
          child: Text(
            "My Settings",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuItem<String>(
          value: "logout",
          child: Text(
            "Log Out",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem<String>(
          enabled: false,
          child: StatefulBuilder(
            builder: (context, setState) {
              bool isDarkMode = false;
              return Row(
                children: [
                  Icon(Icons.nightlight_round, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("Dark Mode", style: TextStyle(color: Colors.black)),
                  Spacer(),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );

    if (selected != null) {
      handleMenuSelection(context, selected);
    }
  }

  static void handleMenuSelection(BuildContext context, String value) {
    if (value == "settings") {
      print("object");
      //Navigator.pushNamed(context, '/settings');
    } else if (value == "logout") {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
