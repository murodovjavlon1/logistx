import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            
            centerTitle: true,
            backgroundColor: Colors.greenAccent,
          //  title: const Text("Ho'sh kelibsiz"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Do'kon"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Buyurtmalar"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/orders");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Mahsulotlarni Boshqarish "),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/menag_produc");
            },
          ),
          const Divider()
        ],
      ),
    );
  }
}
