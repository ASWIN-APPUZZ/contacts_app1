import 'dart:convert';

import 'package:contacts_app/src/models/records.dart';
import 'package:flutter/services.dart' show rootBundle;

class RecordsController {
  Future<List<RecordModel>> getData() async {
    //Reading the JSON Array file
    String rawData =
        await rootBundle.loadString("assets/data/records.json", cache: false);
    //Decoding JSON Array String to List<Map>
    List<dynamic> decodeData = jsonDecode(rawData);
    //Iterating thr list using Map Method to instance of object
    List<RecordModel> records =
        decodeData.map((item) => RecordModel.fromJSON(item)).toList();

    return records;
  }
}
