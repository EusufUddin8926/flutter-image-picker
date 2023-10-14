import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _imagefile;

  Future PickImage() async {
    var imagefile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _imagefile = File(imagefile!.path);
    });
  }

  Future PickImageFromGallery() async {
    var imagefile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imagefile = File(imagefile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker Demo"),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.cyan),
            width: double.infinity,
            height: 500,
            child: _imagefile == null
                ? const Center(
                    child: Text(
                      "No Image Selected",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.pink,
                          image: DecorationImage(fit: BoxFit.fill,
                              image: Image.file(_imagefile!).image),
                        ),
                      )
                    ],
                  ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  PickImage();
                },
                child: Icon(Icons.camera),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  PickImageFromGallery();
                },
                child: Icon(Icons.photo_library),
              )
            ],
          )
        ],
      ),
    );
  }
}
