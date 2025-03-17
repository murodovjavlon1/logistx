import 'package:flutter/material.dart';

class NoDataScreen extends StatefulWidget {
  @override
  _NoDataScreenState createState() => _NoDataScreenState();
}

class _NoDataScreenState extends State<NoDataScreen> {
  String selectedFilter = "All";

  void _onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("My Application")),
      // backgroundColor: Color(0xFF121212),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFilterButton(
                  "All",
                  selectedFilter == "All",
                  0,
                  _onFilterSelected,
                ),
                _buildFilterButton(
                  "Pending",
                  selectedFilter == "Pending",
                  0,
                  _onFilterSelected,
                ),
                _buildFilterButton(
                  "Accept",
                  selectedFilter == "Accept",
                  0,
                  _onFilterSelected,
                ),
                _buildFilterButton(
                  "Decline",
                  selectedFilter == "Decline",
                  0,
                  _onFilterSelected,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sentiment_neutral, color: Colors.black, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "No data",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    String text,
    bool isSelected,
    int count,
    Function(String) onSelected,
  ) {
    return GestureDetector(
      onTap: () => onSelected(text),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.grey[700],
              child: Text(
                "$count",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
