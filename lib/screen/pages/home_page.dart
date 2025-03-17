import 'package:flutter/material.dart';
import 'package:logistx/screen/pages/view_model/hpme_provider.dart';
import 'package:logistx/screen/pages/widget/app_drawer.dart';
import 'package:logistx/screen/pages/widget/show_dialog_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleItem = Provider.of<HomeProvider>(context);
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
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(100, 100, 0, 0),
                items: <PopupMenuEntry<SampleItem>>[
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.itemOne,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.plumbing),
                        ),
                        Text('Javlon'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.itemTwo,
                    child: Text('Item Two'),
                  ),
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.itemThree,
                    child: Text('Item Three'),
                  ),
                ],
              ).then((SampleItem? item) {
                if (item != null) {
                  sampleItem.selectItem(
                    item,
                  ); // Provider orqali holatni yangilash
                }
              });
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => VehicleDialog(),
                      );
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
