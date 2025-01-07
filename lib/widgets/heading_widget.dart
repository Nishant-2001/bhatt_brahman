import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final VoidCallback onTap;
  final String buttonText;

  const HeadingWidget(
      {super.key,
      required this.headingTitle,
      required this.onTap,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              headingTitle,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff373A40),
                  fontFamily: "Work Sans"),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w500,
                  color: Color(0xff29306E),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xff29306E),
                  decorationThickness: 2.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
