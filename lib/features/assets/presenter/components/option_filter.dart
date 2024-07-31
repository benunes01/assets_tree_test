import 'package:flutter/material.dart';

class OptionFilter extends StatelessWidget {
  String title;
  IconData icon;
  void Function()? onTap;
  bool isActive;

  OptionFilter({super.key, required this.title, required this.icon, required this.onTap, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32,
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: isActive ? Colors.blue : Colors.grey)
        ),
        child: Row(
          children: [
            Icon(icon, size: 18,),
            const SizedBox(width: 6,),
            Text(title)
          ],
        ),
      ),
    );
  }

}