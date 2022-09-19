import 'package:birds_weights/models/weight_day.dart';
import 'package:birds_weights/services/database.dart';
import 'package:birds_weights/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddWeights extends StatefulWidget {
  //data with page is created
  final WeightDay? initValues;

  const AddWeights({this.initValues, Key? key}) : super(key: key);

  @override
  State<AddWeights> createState() => _AddWeightsState();
}

class _AddWeightsState extends State<AddWeights> {
  //values from controllers for saving to dabase
  Map<String, int> _values = {};
  DateTime date = DateTime.now();

  //controllers for text fields
  final _controllers =
      List.generate(birdnames.length, (i) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _values = widget.initValues?.weights ?? getEmptyWeightsMap();
    date = (widget.initValues != null) ? widget.initValues!.date : date;
  }

  @override
  void dispose() {
    for (var element in _controllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: TextButton.icon(
              onPressed: () {
                saveValuesToDatabase();
                Navigator.of(context).pop(false);
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              icon: const Icon(
                Icons.download,
                size: 24.0,
              ),
              label: const Text('Uložit'),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: birdnames.length,
                itemBuilder: (context, index) {
                  return _row(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //generate row with text and inputs
  Widget _row(int index) {
    if (_values[birdnames[index]] != 0) {
      _controllers[index].value =
          TextEditingValue(text: _values[birdnames[index]].toString());
    }
    return Row(
      children: [
        Text(
          birdnames[index],
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(width: 40),
        Expanded(
          child: TextFormField(
            controller: _controllers[index],
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ],
    );
  }

  //saves values from controllers to the firestore
  void saveValuesToDatabase() {
    //WeightDay wd = WeightDay(widget.date, getEmptyWeightsMap());

    for (var i = 0; i < _controllers.length; i++) {
      _values[birdnames[i]] = int.tryParse(_controllers[i].value.text) ?? 0;
    }
    DatabaseService().updateWeightsData(WeightDay(date, _values));
  }
}
