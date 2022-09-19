import 'dart:math';
import 'package:intl/intl.dart';

var birdnames = [
  "Robík",
  "Týna",
  "Vicky",
  "Mája",
  "Samík",
  "Skoty",
  "Rózi",
  "Evžen",
  "Barča",
  "Seth",
  "Willy",
  "Kája",
  "Dany",
  "Sigi",
  "Ozzy",
  "Kryštof",
  "Harry",
  "Henry",
  "Ludva",
  "Čárlie",
  "Sofie",
  "Posi",
  "Alžběta",
];
Map<String, int> getEmptyWeightsMap() {
  return {for (var v in birdnames) v: 0};
}

Map<String, int> getExampleWeights() {
  Random r = Random();
  Map<String, int> data = {};
  birdnames.map((e) {
    data[e] = r.nextInt(500) + 100;
  }).toList();
  return data;
}

bool makeNamesCompleted(Map<String, int> weights) {
  for (var element in birdnames) {
    if (weights[element] == null) {
      weights[element] = 0;
    }
  }
  return true;
}

String getUidFromDateTime(DateTime date) {
  final DateFormat formatter = DateFormat('yyyyMMdd');
  return formatter.format(date);
}

DateTime getDateTimeFromUid(String uid) {
  var year = uid.substring(0, 4);
  var month = uid.substring(4, 6);
  var day = uid.substring(6, 8);
  return DateTime.parse('$year-$month-$day 00:00:00.000');
}

class WeightDay {
  final DateTime date;
  final Map<String, int> weights;

  WeightDay(this.date, this.weights);

  WeightDay.empty()
      : date = DateTime.fromMillisecondsSinceEpoch(0),
        weights = {for (var n in birdnames) n: 0};
}
