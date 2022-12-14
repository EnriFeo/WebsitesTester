import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:website_tester/db/app_db.dart';
import 'package:website_tester/widgets/app_bar.dart';
import 'package:website_tester/widgets/custom_list_tile.dart';
import 'package:website_tester/widgets/display_image.dart';

import '../utils/utils.dart';

class SpeedTester extends StatefulWidget {
  final AppDB db = AppDB();

  String _url_inserted = "";

  WebsiteCompanion? currentWebsite;

  bool _added = false;

  /*DateTime lastModifiedInput = DateTime.now();*/
  bool _isLoadingAdding = false;

  SpeedTester({super.key});

  @override
  State<SpeedTester> createState() => _SpeedTesterState();
}

class _SpeedTesterState extends State<SpeedTester> {
  void _setUrlInserted(String value) {
    setState(() {
      widget._url_inserted = value;
    });
    /*_setLastModified(DateTime.now());*/
    _setAdded(false);
    if (widget._url_inserted != "") {
      waitAndGet();
    }
    if (widget._url_inserted.isEmpty) {
      print("ci siamo");
      _setCurrentWebsite(null);
    }
  }

  Future<void> waitAndGet() async {
    String urlTmp = widget._url_inserted;
    await Future.delayed(
      const Duration(milliseconds: 1000),
      () async {
        if (urlTmp == widget._url_inserted) {
          await _getWebsite();
        }
      },
    );
  }

  void _setCurrentWebsite(WebsiteCompanion? value) {
    //print("immagine svg: ${value?.img.runtimeType}");

    setState(() {
      widget.currentWebsite = value;
    });
  }

  void _setAdded(bool value) {
    setState(() {
      widget._added = value;
    });
  }

  /*void _setLastModified(DateTime now) {
    setState(() {
      widget.lastModifiedInput = now;
    });
  }*/

  void _setIsLoadingAdding(bool value) {
    setState(() {
      widget._isLoadingAdding = value;
    });
  }

  Future<void> _add() async {
    if (!widget._added && widget.currentWebsite != null) {
      //DA LEVARE /*
      print("cliccato");
      _setIsLoadingAdding(true);
      widget.currentWebsite = WebsiteCompanion(
        name: widget.currentWebsite!.name,
        url: widget.currentWebsite!.url,
        img: widget.currentWebsite?.img ?? const drift.Value(null),
        googleGrade: drift.Value(double.parse(
                (await Requests.getGoogleSpeed(widget._url_inserted))
                    .toString()) /
            1000),
        systemGrade: drift.Value(double.parse(
                (await Requests.getSystemSpeed(widget._url_inserted))
                    .toString()) /
            1000),
      );
      print("fatto");
      //DA LEVARE */

      _setIsLoadingAdding(false);
      widget.db.insertWebsite(widget.currentWebsite!);

      _setAdded(true);
    }
  }

  Future<void> _getWebsite() async {
    WebsiteCompanion? tmp = await Requests.getWebsite(widget._url_inserted);
    if (tmp != null) {
      _setCurrentWebsite(tmp);
      print("sito preso");
    } else {
      _setCurrentWebsite(null);
    }
  }

  void removeWebsite(WebsiteData wb) {
    widget.db.deleteWebsite(wb);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container()),
                Container(
                  height: 100.0,
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 5.6),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(13.3),
                    ),
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: [
                      if (widget.currentWebsite?.img.value != null) ...[
                        DisplayImage(widget.currentWebsite!.img.value!),
                        const SizedBox(width: 23.3),
                      ],
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.currentWebsite?.name != null) ...[
                            SizedBox(
                              width: 400,
                              child: Text(
                                widget.currentWebsite!.name.value,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                          SizedBox(
                            width: 400.0,
                            child: TextFormField(
                              initialValue: widget._url_inserted,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'url',
                              ),
                              onChanged: (e) => _setUrlInserted(e),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                widget._isLoadingAdding
                    ? const Image(
                        image: AssetImage('assets/images/loading.gif'),
                        width: 35.0,
                      )
                    : TextButton(
                        onPressed: () async => _add(),
                        child: const Text("Aggiungi"),
                      ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: widget.db.watchAllWebsites(),
              builder: (context, AsyncSnapshot<List<WebsiteData>> snapshot) {
                final websites = snapshot.data ?? [];

                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView.builder(
                    itemCount: websites.length,
                    itemBuilder: (_, index) {
                      final itemWebsite = websites[index];
                      return CustomListTile(
                        item: itemWebsite,
                        delete: removeWebsite,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
