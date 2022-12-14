import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  String url;
  Function setUrl;
  bool isLoading;
  Function buttonOnPressed;

  MyWidget({
    required this.url,
    required this.setUrl,
    required this.isLoading,
    required this.buttonOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 1000.0,
          child: TextFormField(
            initialValue: url,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter url',
            ),
            onChanged: (e) => setUrl(e.characters.string),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: isLoading
              ? const Image(
                  image: AssetImage('assets/images/loading.gif'),
                  width: 35.0,
                )
              : TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () async => buttonOnPressed(),
                  child: const Text('vai'),
                ),
        )
      ],
    );
  }
}
