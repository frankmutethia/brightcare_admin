import 'package:brightcare_admin/services/sendpost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:msafiri_admin/services/sendpost.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/post.dart';

class AddPackage extends StatefulWidget {
  static final String id = "add";
  @override
  _AddPackageState createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
  TextEditingController sampledata1 = new TextEditingController();
  TextEditingController sampledata2 = new TextEditingController();
  TextEditingController sampledata3 = new TextEditingController();
  TextEditingController sampledata4 = new TextEditingController();

  String _site, _location, _price, _imageurl;
  Future<Post> _futurePost;
  final _formKey = GlobalKey<FormState>();

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _futurePost = sendPost(_site, _location, _price, _imageurl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Package Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Add Package'),
          leading: Icon(
            Icons.arrow_back,
            size: 26.0,
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futurePost == null)
              ? Form(
                  key: _formKey,
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0,
                        ),
                        child: TextFormField(
                          controller: sampledata1,
                          decoration: InputDecoration(
                            //hintText: 'Warehouse Name',
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(
                              Icons.add,
                              size: 40.0,
                            ),
                            hintText: 'Package name',
                            labelText: 'Package name',
                          ),
                          validator: (title) =>
                              title.trim().isEmpty ? 'Enter valid name' : null,
                          onSaved: (site) => _site = site,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0,
                        ),
                        child: TextFormField(
                          controller: sampledata2,
                          decoration: InputDecoration(
                            //  hintText: 'Warehouse Location',
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(
                              Icons.map_outlined,
                              size: 40.0,
                            ),
                            hintText: 'Package location',
                            labelText: 'Package location',
                          ),
                          validator: (subtitle) => subtitle.trim().isEmpty
                              ? 'Enter valid location'
                              : null,
                          onSaved: (location) => _location = location,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0,
                        ),
                        child: TextFormField(
                          controller: sampledata3,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(
                              Icons.attach_money,
                              size: 40.0,
                            ),
                            hintText: 'Package price',
                            labelText: 'Package price',
                          ),
                          validator: (price) =>
                              price.trim().isEmpty ? 'Enter valid price' : null,
                          onSaved: (price) => _price = price.toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0,
                        ),
                        child: TextFormField(
                          controller: sampledata4,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(
                              Icons.image_sharp,
                              size: 40.0,
                            ),
                            hintText: 'Warehouse imgUrl',
                            labelText: 'Warehouse imgUrl',
                          ),
                          validator: (image) =>
                              image.trim().isEmpty ? 'Enter valid Url' : null,
                          onSaved: (imageurl) => _imageurl = imageurl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 125.0, left: 240),
                        child: FloatingActionButton(
                          child: Icon(Icons.check),
                          onPressed: () async {
                            // calling the submit button
                            Map<String, dynamic> data = {
                              "field1": sampledata1.text,
                              "field2": sampledata2.text,
                              "field3": sampledata3.text,
                              "field4": sampledata4.text,
                            };
                            Firestore.instance.collection("packages").add(data);
                            //_submit();
                          },
                          // onPressed: () {
                          //   _submit();
                          // },
                        ),
                      ),
                    ],
                  ),
                )
              : FutureBuilder<Post>(
                  future: _futurePost,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(snapshot.data.site),
                          Text(snapshot.data.location),
                          Text(snapshot.data.imageurl),
                          Text(snapshot.data.price.toString()),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
        ),
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:msafiri_admin/services/sendpost.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'models/post.dart';

// class AddPackage extends StatefulWidget {
//   static final String id = "add";
//   @override
//   _AddPackageState createState() => _AddPackageState();
// }

// class _AddPackageState extends State<AddPackage> {
//   String _title, _subtitle, _price, _image;
//   Future<Post> _futurePost;
//   final _formKey = GlobalKey<FormState>();

//   _submit() {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();
//       setState(() {
//         _futurePost = sendPost(_title, _subtitle, _price, _image);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Add Warehouse',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         // resizeToAvoidBottomPadding: false,
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text('Add Warehouse'),
//           leading: Icon(
//             Icons.arrow_back,
//             size: 26.0,
//           ),
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: (_futurePost == null)
//               ? Form(
//                   key: _formKey,
//                   child: Column(
//                     //  mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12.0,
//                           horizontal: 10.0,
//                         ),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             //hintText: 'Warehouse Name',
//                             border: const UnderlineInputBorder(),
//                             filled: true,
//                             icon: const Icon(
//                               Icons.add,
//                               size: 40.0,
//                             ),
//                             hintText: 'Warehouse name',
//                             labelText: 'Warehouse name',
//                           ),
//                           validator: (title) =>
//                               title.trim().isEmpty ? 'Enter valid name' : null,
//                           onSaved: (title) => _title = title,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12.0,
//                           horizontal: 10.0,
//                         ),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             //  hintText: 'Warehouse Location',
//                             border: const UnderlineInputBorder(),
//                             filled: true,
//                             icon: const Icon(
//                               Icons.map_outlined,
//                               size: 40.0,
//                             ),
//                             hintText: 'Warehouse location',
//                             labelText: 'Warehouse location',
//                           ),
//                           validator: (subtitle) => subtitle.trim().isEmpty
//                               ? 'Enter valid location'
//                               : null,
//                           onSaved: (subtitle) => _subtitle = subtitle,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12.0,
//                           horizontal: 10.0,
//                         ),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             border: const UnderlineInputBorder(),
//                             filled: true,
//                             icon: const Icon(
//                               Icons.attach_money,
//                               size: 40.0,
//                             ),
//                             hintText: 'Warehouse price',
//                             labelText: 'Warehouse price',
//                           ),
//                           validator: (price) =>
//                               price.trim().isEmpty ? 'Enter valid price' : null,
//                           onSaved: (price) => _price = price.toString(),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12.0,
//                           horizontal: 10.0,
//                         ),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             border: const UnderlineInputBorder(),
//                             filled: true,
//                             icon: const Icon(
//                               Icons.image_sharp,
//                               size: 40.0,
//                             ),
//                             hintText: 'Warehouse imgUrl',
//                             labelText: 'Warehouse imgUrl',
//                           ),
//                           validator: (image) =>
//                               image.trim().isEmpty ? 'Enter valid Url' : null,
//                           onSaved: (image) => _image = image,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 125.0, left: 240),
//                         child: FloatingActionButton(
//                           child: Icon(Icons.check),
//                           onPressed: () {
//                             _submit();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : FutureBuilder<Post>(
//                   future: _futurePost,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return Column(
//                         children: [
//                           Text(snapshot.data.title),
//                           Text(snapshot.data.subtitle),
//                           Text(snapshot.data.image),
//                           Text(snapshot.data.price.toString()),
//                         ],
//                       );
//                     } else if (snapshot.hasError) {
//                       return Text("${snapshot.error}");
//                     }

//                     return CircularProgressIndicator();
//                   },
//                 ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';

// class AddPackage extends StatefulWidget {
//   static final String id = "add";
//   @override
//   _AddPackageState createState() => _AddPackageState();
// }

// class _AddPackageState extends State<AddPackage> {
//   File sampleImage;
//   File _image;
//   String _myValue;
//   final formKey = new GlobalKey<FormState>();
//   final picker = ImagePicker();
//   FileType picktype;

//   Future getImageFromGallery() async {
//     // final pickedFile= await ImagePicker.pickImage(source: ImageSource.gallery);
//     final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print("No image selected");
//       }
//     });
//   }

//   Future getImageFromCam() async {
//     final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print("No image selected");
//       }
//     });
//   }

//   void showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   ListTile(
//                     leading: Icon(Icons.photo_library),
//                     title: Text("Choose from library"),
//                     onTap: () {
//                       getImageFromGallery();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.photo_camera),
//                     title: Text("Choose from camera"),
//                     onTap: () {
//                       getImageFromCam();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//   // Future getImage() async {
//   //   var imagePicker;
//   //   var tempImage = await imagePicker.getImage(source: ImageSource.gallery);

//   //   setState(() {
//   //     sampleImage = tempImage;
//   //   });
//   // }

//   bool validateAndSave() {
//     final form = formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       return true;
//     } else {
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Uploading of Packages",
//           textAlign: TextAlign.center,
//         ),
//       ),
//       body: Center(
//         child: sampleImage == null ? Text("Upload Image") : enableUpload(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showPicker(context);
//           setState(() {
//             _image = _image;
//           });
//         },
//         tooltip: 'Add Image',
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }

//   Widget enableUpload() {
//     return Container(
//       child: Form(
//         key: formKey,
//         child: Column(
//           children: [
//             Image.file(
//               sampleImage,
//               height: 300.0,
//               width: 600.0,
//             ),
//             SizedBox(
//               height: 15.0,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Description'),
//               validator: (value) {
//                 return value.isEmpty ? 'Blod Description is required' : null;
//               },
//               onSaved: (value) {
//                 return _myValue = value;
//               },
//             ),
//             SizedBox(
//               height: 15.0,
//             ),

//             ElevatedButton(
//               child: Text("Post Here"),
//               onPressed: validateAndSave,
//             ),
//             // RaisedButton(
//             //   elevation: 10.0,
//             //   child: Text("Post Here"),
//             //   textColor: Colors.white,
//             //   color: Colors.blueAccent,
//             //   onPressed: validateAndSave,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//   //  void _popupDialog(BuildContext context) {
//   //   showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return Center(
//   //           child: Card(
//   //             child: Container(
//   //               height: MediaQuery.of(context).size.height * 0.5,
//   //               width: MediaQuery.of(context).size.width * 0.6,
//   //               child: Column(
//   //                 children: <Widget>[
//   //                   Container(
//   //                     height: 100,
//   //                     width: 80,
//   //                     child: _image == null
//   //                         ? Text("No image is selected")
//   //                         : Image.file(_image),
//   //                   ),
//   //                   Container(
//   //                     width: 50,
//   //                     height: 50,
//   //                     child: Center(
//   //                       child: FloatingActionButton(
//   //                         onPressed: () {
//   //                           showPicker(context);
//   //                           setState(() {
//   //                             _image = _image;
//   //                           });
//   //                         },
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         );
//   //       });
//   // }
// }
