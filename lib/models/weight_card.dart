import 'package:flutter/material.dart';
import 'package:birds_weights/models/weight_day.dart';

class WeightCard extends StatelessWidget {
  const WeightCard(this.data, {Key? key}) : super(key: key);

  final WeightDay data;

  @override
  Widget build(BuildContext context) {
    //date string
    final String datestr =
        "${data.date.day}. ${data.date.month}. ${data.date.year}";

    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "$datestr",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 18.0),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 8.0,
            children: birdnames.map((e) {
              return Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          "${e.toString()}: "),
                    ),
                  ),
                  Text(data.weights[e].toString()),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    ));
  }
}
