import 'package:drift/drift.dart';

class Website extends Table {
  IntColumn? get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get url => text()();
  TextColumn get img => text().nullable()();
  RealColumn get systemGrade => real()();
  RealColumn get googleGrade => real()();
}
