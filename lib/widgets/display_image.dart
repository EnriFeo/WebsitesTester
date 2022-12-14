import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DisplayImage extends StatelessWidget {
  String img;

  DisplayImage(this.img, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white70),
        child: img.endsWith("svg")
            ? Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: SvgPicture.network(
                    img,
                    semanticsLabel: 'SVG From Network',
                    placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator(),
                    ),
                    fit: BoxFit.cover, //placeholder while downloading file.
                  ),
                ),
              )
            : Image(
                image: NetworkImage(img),
                height: 40.0,
                fit: BoxFit.fitHeight,
                isAntiAlias: true,
              ),
      ),
    );
  }
}
