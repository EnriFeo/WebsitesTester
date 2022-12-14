import 'package:flutter/material.dart';
import 'package:website_tester/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text(
            "Website Tester",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          TabSwitcher(),
        ],
      ),
    );
  }
}
