import 'dart:io';
import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:website_tester/models/models.dart';

import 'package:path/path.dart' as p;

class GenerateReport {
  static Future<String> run(String baseUrl, List<UrlOk> list) async {
    /*final f = File("prova_report.docx");
    final docx = await DocxTemplate.fromBytes(await f.readAsBytes());*/

    String urlName = __getName(baseUrl);

    final folder = await getApplicationDocumentsDirectory();

    Content c = Content();

    /* POPULATE DOCUMENT */

    c.add(TextContent("docname", "$urlName Report"));

    /*c.add(ListContent("list", [
      TextContent("value", "Engine"),
        //..add(ListContent("listnested", contentList)),
      TextContent("value", "Gearbox"),
      TextContent("value", "Chassis")]));*/

    c.add(
      ListContent(
        "list",
        list
            .map((url) => TextContent(
                  "value",
                  "${url.url} - errore: ${url.statusCode}",
                ))
            .toList(),
      ),
    );

    /* POPULATE DOCUMENT */

    final f = File('template.docx');
    await DocxTemplate.fromBytes(await f.readAsBytes()).then((docx) async {
      await docx.generate(c).then((data) async {
        await File(p.join(folder.path,
                "reports/${urlName.replaceAll(" ", "_")}_error_report.docx"))
            .create(recursive: true)
            .then((of) async {
          if (data != null) {
            await of.writeAsBytes(data);
          }
        }).catchError((error) {
          print("file aperto da un'altra parte");
        });
      });
    });

    return folder.path;
    /*final d = await docx.generate(c);
    final of = File('generated.docx');
    if (d != null) await of.writeAsBytes(d);*/
  }

  static String __getName(String url) {
    if (RegExp(r'https?:\/\/(www\.{1})?(\w+|(\w+(-|\.)\w+)+)\.\w+\/?.*')
        .hasMatch(url)) {
      return url
          .replaceFirst("https://", "")
          .replaceFirst("www.", "")
          .replaceFirst(RegExp(r'\.\w+\/?.*'), "")
          .replaceAll("-", " ");
    }
    return url;
  }
}
