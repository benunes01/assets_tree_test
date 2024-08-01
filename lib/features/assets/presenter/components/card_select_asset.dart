import 'package:flutter/material.dart';
import 'package:tractian_test/ui/text_styles.dart';

class CardSelectAsset extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const CardSelectAsset({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        height: 76,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.settings_system_daydream_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: bodyLarge.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
