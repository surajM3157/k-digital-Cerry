import 'package:flutter/material.dart';

class GradientDropdownFormField extends StatelessWidget {
  final List<String> items;

  GradientDropdownFormField({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple], // Gradient colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(2), // Padding for the gradient border thickness
              decoration: BoxDecoration(
                color: Colors.white, // Background color for Dropdown
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
                dropdownColor: Colors.white,
                iconSize: 30,
                decoration: InputDecoration(
                  hintText: "Select your Industry",
                  labelText: "Industry",
                  labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
                  hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none, // Border is handled by the container
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
