import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({super.key, required this.text, required this.onPressed, this.backgroundColor = Colors.green});

  final String text;
  final GestureTapCallback onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(    
        elevation: MaterialStateProperty.all(10) ,                
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        )
      ),
      onPressed: onPressed,
      child: Container(
        height: 40,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        )
      )
    );
  }
}