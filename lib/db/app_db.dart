import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:website_tester/db/data/website.dart';

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final DbFolder = await getApplicationDocumentsDirectory();
    print(DbFolder);
    final file = File(p.join(DbFolder.path, 'website.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Website])
class AppDB extends _$AppDB {
  AppDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<WebsiteData>> getAllWebsites() => select(website).get();
  Stream<List<WebsiteData>> watchAllWebsites() => select(website).watch();
  Future insertWebsite(WebsiteCompanion newWebsite) =>
      into(website).insert(newWebsite);
  Future updateWebsite(WebsiteData newWebsite) =>
      update(website).replace(newWebsite);
  Future deleteWebsite(WebsiteData newWebsite) =>
      delete(website).delete(newWebsite);
}
