import 'package:birds_weights/models/weight_card.dart';
import 'package:birds_weights/models/weight_day.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeightList extends StatefulWidget {
  const WeightList({Key? key}) : super(key: key);

  @override
  State<WeightList> createState() => _WeightListState();
}

class _WeightListState extends State<WeightList> {
  @override
  Widget build(BuildContext context) {
    var weights_orig = Provider.of<List<WeightDay>>(context);
    List<WeightDay> weights = List.from(weights_orig);
    weights.sort((a, b) => b.date.compareTo(a.date));

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView.builder(
          itemCount: weights.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: WeightCard(weights[index]),
            );
          },
        ),
      ),
    );
  }
}
