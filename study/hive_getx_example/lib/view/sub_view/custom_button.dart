import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,
    required this.onPressed,
    required this.title,
    required this.icon,
    this.height = 40.0,
    this.color,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: color ?? Theme.of(context).primaryColor,
            ),
            child: TextButton.icon(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              label: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
