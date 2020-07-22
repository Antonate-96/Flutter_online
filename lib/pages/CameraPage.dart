import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutteronline/widgets/menu.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';


class CameraPage extends StatefulWidget{
  CameraPage({Key key }) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}
class _CameraPageState extends State<CameraPage> {
  CameraController _controller;
  List<CameraDescription> cameras;
  CameraDescription camera;
  Widget cameraPreview;

  Future<void> initCamera() async {
    cameras = await availableCameras();
    camera = cameras.first;
    _controller = CameraController(
      camera,
      ResolutionPreset.medium
    );
    await _controller.initialize();

    cameraPreview = Center(
      child: CameraPreview(_controller)
    );

    setState(() {
      cameraPreview = cameraPreview;
    });
  }
  
  @override
  void initState() { 
    super.initState();
    initCamera();
  }


  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('camera'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_enhance),
            onPressed: () async {
              Directory tempDir = await getTemporaryDirectory();
              String newFileName = tempDir.path + '/${DateTime.now()}.jpg';
              await _controller.takePicture(newFileName);
              Navigator.pushNamed(context, 'camerastack/picture', arguments: {
                'path' : newFileName
              });
            } ,
          )
        ],
      ),
      body: Container(
        child: cameraPreview
      )
    );
  }
}