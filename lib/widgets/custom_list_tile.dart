import 'package:flutter/material.dart';
import 'package:puppeteer/protocol/page.dart';
import 'package:website_tester/db/app_db.dart';
import 'package:website_tester/widgets/display_image.dart';

class CustomListTile extends StatelessWidget {
  final WebsiteData item;
  final Function delete;

  const CustomListTile({required this.item, required this.delete, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      padding: const EdgeInsets.all(13.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(children: [
        if (item.img != null) ...[
          DisplayImage(item.img!),
          const SizedBox(width: 13.3),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(item.url,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.grey,
                  )),
              Row(
                children: [
                  Text("System Grade: ${item.systemGrade} s"),
                  SizedBox(width: 20),
                  Text("Google Grade: ${item.googleGrade} s"),
                ],
              )
            ],
          ),
        ),
        IconButton(
            onPressed: () => delete(item),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ]),
    );
  }
}

/*

Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (itemWebsite.img != null) ...[
                            DisplayImage(itemWebsite.img!),
                            const SizedBox(width: 13.3),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  itemWebsite.name,
                                ),
                                Text(
                                  itemWebsite.url,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )

 */