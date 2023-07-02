import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  RoundedButton({required this.color, required this.label, required this.onPressed}); // required keyword makes sure that these parameters are provided at compile time

  final Color color;
  final String label;
  final Function() onPressed; // Since the onPressed function is a void callback function, it needs to be defined a little differently
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color, // Assign colour from parameters
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed, // Assign onPressed callback function from parameters
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label, // Assign MaterialButton text label from parameters
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}