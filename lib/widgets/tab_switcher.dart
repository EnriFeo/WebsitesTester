import 'package:flutter/material.dart';

class TabSwitcher extends StatefulWidget {
  const TabSwitcher({super.key});

  @override
  State<TabSwitcher> createState() => _TabSwitcherState();
}

class _TabSwitcherState extends State<TabSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () => Navigator.pushNamed(context, "/broken_links"),
          child: const Text('Broken Links'),
          //ModalRoute.of(context).settings.name == "broken_links" --> the button has to be focused
        ),
        const SizedBox(width: 40.0),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () => Navigator.pushNamed(context, "/speed_tester"),
          child: const Text('SpeedTester'),
        ),
        Expanded(child: Container()),
        //ModalRoute.of(context).settings.name == "speed_tester" --> the button has to be focused
      ],
    );
  }
}
