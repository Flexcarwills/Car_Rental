import 'package:flutter/material.dart';

class Features extends StatefulWidget {
  const Features({super.key, required this.features});

  final features;
  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  //final feature;

  var done;

  final carFeatures = [
    CheckBoxModal('Air Conditioning', false),
    CheckBoxModal('Power Steering', false),
    CheckBoxModal('Bluetooth Connectivity', false),
    CheckBoxModal('Cruise Control', false),
    CheckBoxModal('Backup Camera', false),
    CheckBoxModal('GPS', false),
    // Add more features as needed
  ];
  // void setDone(BuildContext context, bool? isChecked) {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: carFeatures.length,
        itemBuilder: (ctx, index) {
          //return //Text(feature[index].title);
          return ListTile(
            leading: Checkbox(
                value: carFeatures[index].value,
                onChanged: (value) => onItemSelected(carFeatures[index])),
            title: Text(carFeatures[index].title),
          );
        });
  }

  onItemSelected(CheckBoxModal cbkitem) {
    setState(() {
      cbkitem.value = !cbkitem.value;
    });
    widget.features.add(cbkitem.title);
  }
}

class CheckBoxModal {
  final String title;
  bool value;

  CheckBoxModal(this.title, this.value);
}
