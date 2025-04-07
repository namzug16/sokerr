import 'package:sokerr/sokerr.dart';

///
//ignore_for_file: avoid_print

Future<void> main() async {
  final res = await getSomethingFromDb().result();

  return switch(res) {
    Ok(:final ok) => print("Data: $ok"),
    Err(:final err, :final st) => print("ERROR: $err, $st"),
  };
}

Future<String> getSomethingFromDb() async {
  throw Exception("Db not found");
}
