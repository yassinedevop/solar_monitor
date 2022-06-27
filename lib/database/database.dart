import 'package:firebase_database/firebase_database.dart';

class Database {
  static Future<Object?> getTemperature() async {
    return (await FirebaseDatabase.instance
            .ref()
            .child(
                "UsersData/" + "0J1lCsRBjKVDLoddQIVV8WhEix42" + "/temperature")
            .once())
        .snapshot
        .value;
  }
}
