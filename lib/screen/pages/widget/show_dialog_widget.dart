import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehicleDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AlertDialog(
            // backgroundColor: Color(0xFF1E1E1E), // Qorong'i fonda modal oyna
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              "Create new vehicle",
              style: TextStyle(color: Colors.white),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Color(0xFF292929), // Input orqa foni
                        prefixIcon: Icon(
                          Icons.directions_car,
                          color: Colors.grey,
                        ),
                        labelText: "Vehicle Number",
                        labelStyle: TextStyle(color: Colors.grey),
                        //   hintText: "Vehicle Number",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),

                  // _buildTextFormField(Icons.scale, "Load Capacity (ton)"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Color(0xFF292929), // Input orqa foni
                        prefixIcon: Icon(Icons.scale, color: Colors.grey),
                        labelText: "Load Capacity (ton)",
                        labelStyle: TextStyle(color: Colors.grey),
                        //   hintText: "Vehicle Number",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),

                  // _buildTextFormField(Icons.directions_car_filled, "Vehicle Model"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Color(0xFF292929), // Input orqa foni
                        prefixIcon: Icon(
                          Icons.directions_car_filled,
                          color: Colors.grey,
                        ),
                        labelText: "Vehicle Model",
                        labelStyle: TextStyle(color: Colors.grey),
                        //   hintText: "Vehicle Number",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),

                  // _buildTextFormField(Icons.calendar_today, "Vehicle Year",
                  //     hintText: "Enter year (YYYY)"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: _dateController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.black),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                        labelText: "Vehicle Year",
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: "Enter year (YYYY)",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  //  _buildDropdown("Cargo Type"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      //  dropdownColor: Color(0xFF292929),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Color(0xFF292929),
                        labelText: 'Cargo Type',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      items:
                          [
                                "Yuk Mashinasi",
                                "Avtomobil",
                                "Avtobus",
                                "Miniven",
                                "Motosikl",
                              ]
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Body Type",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      items:
                          ["TENT", "REF", "IZOTERMIK"]
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                  //   _buildDropdown("Body Type"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Continue"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

