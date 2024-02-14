import 'dart:io';

import 'package:car_rental_admin/Image_Screen/image_input.dart';
import 'package:car_rental_admin/Upload_model/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UploadCarScreen extends StatefulWidget {
  const UploadCarScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UploadCarScreenState();
  }
}

final _firebase = FirebaseAuth.instance;

class _UploadCarScreenState extends State<UploadCarScreen> {
  final _formkey = GlobalKey<FormState>();
  var _isuploading = false;
  List<String> selectedImage = [];
  //

  var _orgname = '';
  var _carname = '';
  var _carcolor = '';
  var _year = '';
  var _transmissiontype = '';
  var _fueltype = '';
  var _seatcapacity = '';
  var _features = [];
  var _price = '';
  var _ownername = '';
  var _phonenum = '';

  void _saveData() async {
    final validate = _formkey.currentState!.validate();

    if (!validate) {
      return;
    }

    _formkey.currentState!.save();

    try {
      setState(() {
        _isuploading = true;
      });

      final activeUser = FirebaseAuth.instance.currentUser!;

      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(activeUser.uid)
          .get();

      // final storageref = FirebaseStorage.instance
      //     .ref()
      //     .child('car_images/')
      //     .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
      // await storageref.putFile(selectedImage[0]);
      // final imageUrl = await storageref.getDownloadURL();

      await FirebaseFirestore.instance.collection('CarDeatils').add({
        'Active_user': activeUser.uid,
        'Organization_Name': _orgname,
        'Car_Name': _carname,
        'Car_Color': _carcolor,
        'Year': _year,
        'Transmission_Type': _transmissiontype,
        'Fuel_type': _fueltype,
        'Seat_capacity': _seatcapacity,
        'Features': _features,
        'Price': _price,
        'Owner_Name': _ownername,
        'Phone_number': _phonenum,
        'Image_Url': selectedImage,
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data Uploaded Successfullu')));
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Uploading Failed'),
        ),
      );
    }
    setState(() {
      _isuploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedYear = 'Select Year';
    var transtype = '';
    var fueltype = '';
    int currentYear = DateTime.now().year;
    int startingYear = 2000;

    final yearList = List.generate(
      (currentYear - startingYear) + 1,
      (index) => (startingYear + index).toString(),
    );

    final transmission = ['Manual', 'Automatic'];

    final fuelType = ['CNG', 'Petrol', 'Diesel', 'Electric'];

    final _isDarkmode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         FirebaseAuth.instance.signOut();
        //       },
        //       icon: Icon(Icons.logout)),
        // ],
        centerTitle: true,
        title: Text(
          'Add A Car',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: _isDarkmode
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Form field for taking the Company name input to display it in a customer app.
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.building, size: 20),
                          ),
                          // suffixIconConstraints:
                          //     BoxConstraints(minHeight: 10, minWidth: 10),
                          labelText: 'Organization Name',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Organization Name';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _orgname = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Form Field for creating the Car name input.
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.car),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Car Name',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Car Name';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _carname = newValue!;
                        },
                      ),
                      // Form Field for creating the Car name input.
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.droplet),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Color',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Color';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _carcolor = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.calendar),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Year',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        items: yearList
                            .map(
                              (itemcat) => DropdownMenuItem(
                                value: itemcat,
                                child: Text(
                                  itemcat,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (item) {
                          if (item == null) {
                            return;
                          }
                          setState(() {
                            selectedYear = item;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Select a year';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _year = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Form Field for Transmission type
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.calendar),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Transmission Type',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        items: transmission
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            transtype = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Select a Trasmission type';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _transmissiontype = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Form Field for the Fuel type
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.calendar),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Fuel Type',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        items: fuelType
                            .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(
                                  type,
                                  style: const TextStyle(color: Colors.black),
                                )))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            fueltype = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Select a Fuel type';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _fueltype = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Form Field for INputing the Seat Capacity
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.chair),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Seat Capacity',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Seating capacity';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _seatcapacity = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Form Field For Inputing The Features of car
                      const Divider(),
                      const Text('Features'),
                      const Divider(),

                      Features(features: _features),

                      // Form for inputing the Price Field
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.dollarSign),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Price',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter price';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _price = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.person),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Owner Name',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter owner name';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _ownername = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 8.0),
                            child: FaIcon(FontAwesomeIcons.phone),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Phone Number',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 10) {
                            return 'Enter phone valid number';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _phonenum = newValue!;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(),
            const Text(
              'Pick Images',
            ),
            const Divider(),
            ImageInput(onSelectedImage: (List<String> urls) {
              for (var i = 0; i < urls.length; i++) {
                selectedImage.add(urls[i].toString());
              }
              ;
            }),
            const SizedBox(
              height: 30,
            ),
            if (_isuploading) const CircularProgressIndicator(),
            if (!_isuploading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).colorScheme.primary),
                  child: TextButton(
                    onPressed: _saveData,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
