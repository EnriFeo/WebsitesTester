import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:website_tester/APIs/apis.dart';
import 'package:website_tester/db/app_db.dart';

import '../models/url_ok.dart';

class Requests {

  static Future<int?> getSystemSpeed(String url) async {

    return await puppeteer.launch(headless: true).then(
          (browser) async => await browser.newPage().then(
            (page) async {
              var startTime = DateTime.now();
              return await page.goto(url).then(
                (res) {
                  browser.close().then(
                        (value) => print("browser chiuso"),
                      );
                  return DateTime.now().difference(startTime).inMilliseconds;
                },
              );
            },
          ),
        );
  }

  static Future<int?> getGoogleSpeed(String url) async {
    final String GOOGLE_URL =
        "https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=$url&strategy=desktop&key=$GOOGLE_SPEED_TESTER_API";
    print(GOOGLE_URL);
    return await http.get(Uri.parse(GOOGLE_URL)).then((res) {
      if (res.statusCode == 200) {
        print(jsonDecode(res.body)['lighthouseResult']['audits']['metrics']
                ['details']['items'][0]['speedIndex']
            .toString());
        return int.parse(jsonDecode(res.body)['lighthouseResult']['audits']
                ['metrics']['details']['items'][0]['speedIndex']
            .toString());
      }
    }).catchError((error, stackTrace) {
      print(error);
      return -1;
    });
  }

  static Future<List<UrlOk>> getBrokenLinks(final String url) async {
    List? list;
    try {
      list = await http
          .get(Uri.parse(url))
          .then((value) => Document.html(value.body)
              .querySelectorAll("a")
              .map((e) => e.attributes['href'])
              .toList())
          .catchError((error, stackTrace) {
        print(url);
        return <String>[];
      });
    } catch (e) {
      print(e);
    }

    List<String> newList = list!.whereType<String>().toList();

    var baseUrl = RegExp(r"https?:\/\/(www\.{1})?(\w+|(\w+(-|\.)\w+)+)\.\w+")
        .stringMatch(url);

    List<String> filteredList = <String>[];
    for (var ele in newList) {
      if (RegExp(r'https?:\/\/(www\.{1})?(\w+|(\w+(-|\.)\w+)+)\.\w+\/?.*')
          .hasMatch(ele)) {
        if (ele.startsWith("/")) {
          ele.replaceFirst("/", "");
        }
        filteredList.add(ele);
      } else if (RegExp(r'\/\w+\/?.*').hasMatch(ele)) {
        if (ele.split("").first == "/") {
          filteredList.add("$baseUrl$ele");
        } else {
          filteredList.add("$baseUrl/$ele");
        }
      }
    }

    try {
      return await _getBrokenLinksFunc(filteredList);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<UrlOk>> _getBrokenLinksFunc(List<String> list) async {
    return ((await Future.wait(
      list.map(
        (url) => http
            .get(Uri.parse(url.trim()))
            .then((res) => UrlOk(
                url: url,
                statusCode: res
                    .statusCode)) //trovare un modo per gestire errore 429(too many requests)
            .catchError(
          (error) {
            if (error is HandshakeException) {
              return UrlOk(url: url, statusCode: 525);
            } else {
              return UrlOk(url: url, statusCode: -1);
            }
          },
        ),
      ),
    ).catchError((error) => print(error)))
        .where(
            (element) => element.statusCode < 200 || element.statusCode > 299)
        .toList());
  }

  static Uri _fixUri(Uri uri) {
    if (uri.hasScheme) {
      String scheme = uri.scheme;
      String noScheme = uri.toString().replaceRange(0, scheme.length + 3, "");
      String fixed = noScheme.replaceAll(RegExp(r"//"), "/");

      return Uri.parse("$scheme://$fixed");
    } else {
      return uri;
    }
  }

  static Future<String?> _getImage(String url, Document doc) async {
    String imgPath = doc
        .querySelectorAll("link")
        .where((link) => link.attributes["rel"]?.contains('icon') != null
            ? link.attributes["rel"]!.contains('icon')
            : false)
        .first
        .attributes["href"]!;

    Uri imgPathParsed = Uri.parse(imgPath);

    Uri finalUri;
    String? base;
    if (imgPathParsed.isAbsolute) {
      finalUri = imgPathParsed;
    } else if (RegExp(
            r'\/\/(www\.{1})?(\w+|(\w+(-|\.)\w+)+)\.(net|com|org|es)\/?.*') // da modificare per idealista
        .hasMatch(imgPath)) {
      finalUri = Uri.parse("https:$imgPath");
    } else {
      base = doc.querySelector("base")?.attributes["href"];
      if (base != null) {
        finalUri =
            _fixUri(Uri.parse(url).resolve("$base$imgPath").normalizePath());
        print("entro giusto");
      } else {
        finalUri = _fixUri(Uri.parse("$url$imgPath").normalizePath());
      }
    }
    print("base: $url,\nrelative: $imgPath,\nbase: $base,\nfinal: $finalUri");

    _fixUri(finalUri);

    return await http.get(finalUri).then(
      (res) async {
        if (res.statusCode == 200) {
          print("restituisce questo");
          //return res.bodyBytes;
          return finalUri.toString();
        } else {
          final originUri =
              _fixUri(Uri.parse(Uri.parse(url).origin).resolve(imgPath));
          return await http.get(originUri).then((res) {
            if (res.statusCode == 200) {
              print("printo questo e ho macinato $originUri");
              //return res.bodyBytes;
              return originUri.toString();
            } else {
              return null;
            }
          });
        }
      },
    );
  }

  static Future<WebsiteCompanion?> getWebsite(String url) async {
    print(url);
    if (RegExp(
            r"https?:\/\/(www\.{1})?(\w+|(\w+(-|\.)\w+)+)\.(net|com|org|es|it)\/?.*")
        .hasMatch(url)) {
      print("ci entro");
      return await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.userAgentHeader:
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36"
        },
      ).then((res) async {
        if (res.statusCode == 200) {
          print("ho macinato la richiesta");
          Document doc = Document.html(res.body);
          print("doc creato");
          String name = doc.querySelector("title")!.innerHtml;
          print("titolo preso");
          String? img =
              await _getImage(url, doc).onError((error, stackTrace) => null);
          /*try {
            img =
                await _getImage(url, doc).onError((error, stackTrace) => null);
          } catch (e) {
            img = null;
            print("hai beccato un sito senza immagine");
          }*/
          print("immagine presa");
          return WebsiteCompanion(
            img: Value(img),
            name: Value(name),
            url: Value(url.trim()),
          );
        } else {
          print("hai beccato un sito un po bastardo");
        }
      }).catchError((e) => print(e));
    } else {
      return null;
    }
  }
}
