import 'package:birds_weights/main.dart';
import 'package:birds_weights/services/auth.dart';
import 'package:birds_weights/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:birds_weights/models/weight_day.dart';
import 'package:birds_weights/services/database.dart';
import 'package:provider/provider.dart';
import 'package:birds_weights/pages/weight_list.dart';
import 'package:birds_weights/shared/extensions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //auth object
  final AuthService _auth = AuthService();

  // data for list
  List<WeightDay> data = [];
  final DateTime today = DateTime.now();

  List<WeightDay> _getData() {
    return [
      WeightDay(DateTime.now(), getExampleWeights()),
      WeightDay(DateTime.now(), getExampleWeights()),
    ];
  }

  @override
  void initState() {
    data = _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Vážení ptáků ${today.day}. ${today.month}. ${today.year}",
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: backgroundColor,
            ),
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      backgroundColor: backgroundColor,
      body: const WeightList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () {
          var weights = Provider.of<List<WeightDay>>(context, listen: false);
          //pokud je tam dnesni datum, tak predat data
          WeightDay wd = weights.firstWhere(
              (element) => element.date.isSameDate(DateTime.now()),
              orElse: () => WeightDay(DateTime.now(), getEmptyWeightsMap()));
          Navigator.of(context).pushNamed('/add', arguments: wd);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
