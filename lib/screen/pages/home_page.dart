import 'package:flutter/material.dart';
import 'package:logistx/screen/pages/widget/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  print("object");
                },
                icon: Icon(Icons.notifications),
              ),
              Positioned(
                right: 7,
                top: 4,
                child: Container(
                  width: 16,
                  height: 22,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "2",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
             
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                radius: 17,
                backgroundColor: Colors.purple,
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('asset/image/download.jpeg'),
                ),
              ),
            ),
          ),

          //  IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      
                    },
                    child: Text(
                      "Create New Vehicle",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text("Please fill your vehicle information first!"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
