import 'package:birds_weights/models/user.dart';
import 'package:birds_weights/models/weight_day.dart';
import 'package:birds_weights/pages/authenticate.dart';
import 'package:birds_weights/pages/home.dart';
import 'package:birds_weights/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    print(user?.uid);
    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider<List<WeightDay>>.value(
          value: DatabaseService().weights,
          initialData: const [],
          child: const Home());
    }
  }
}
