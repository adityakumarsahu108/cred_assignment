import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String ctaText;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.ctaText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple[400],
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            child: Text(
              ctaText, 
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
