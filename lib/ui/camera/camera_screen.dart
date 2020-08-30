// found in the LICENSE file.

// ignore_for_file: public_member_api_docs
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:python_app/store/camera/camera_store.dart';
import 'package:python_app/ui/widget/toast_generator.dart';
import 'package:video_player/video_player.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  String imagePath;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  bool enableAudio = true;
  CameraStore cameraStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cameraStore = Provider.of<CameraStore>(context);
    WidgetsBinding.instance.addObserver(this);
    cameraStore.onNewCameraSelected();
    cameraStore.disposers
      ..add(reaction((_) => cameraStore.successStore.success, (success) {
        if (success) {
          ToastGenerator.successToast(
              context, cameraStore.successStore.successMessage);
        }
      }))
      ..add(reaction((_) => cameraStore.errorStore.error, (error) {
        if (error) {
          ToastGenerator.errorToast(
              context, cameraStore.errorStore.errorMessage);
        }
      }));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                    child: Stack(
                  children: <Widget>[
                    _cameraPreviewWidget(),
                    Align(
                        alignment: FractionalOffset.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(50),
                              bottom: ScreenUtil().setHeight(50)),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: IconButton(
                              icon: Icon(
                                Icons.loop,
                                size: 33,
                                color: Colors.white,
                              ),
                              onPressed: () => cameraStore.toggleCamera(),
                            ),
                          ),
                        ))
                  ],
                )),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Center(
                  child: InkWell(
                      customBorder: new CircleBorder(),
                      onTap: () => cameraStore.takePicture(),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(300),
                            height: ScreenUtil().setWidth(300),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.5)),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(180),
                            height: ScreenUtil().setWidth(180),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                        ],
                      ))))
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    return Observer(builder: (_) {
      return cameraStore.loading
          ? Container()
          : AspectRatio(
              aspectRatio: cameraStore.controller.value.aspectRatio,
              child: CameraPreview(cameraStore.controller),
            );
    });
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            videoController == null && imagePath == null
                ? Container()
                : SizedBox(
                    child: (videoController == null)
                        ? Image.file(File(imagePath))
                        : Container(
                            child: Center(
                              child: AspectRatio(
                                  aspectRatio:
                                      videoController.value.size != null
                                          ? videoController.value.aspectRatio
                                          : 1.0,
                                  child: VideoPlayer(videoController)),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink)),
                          ),
                    width: 64.0,
                    height: 64.0,
                  ),
          ],
        ),
      ),
    );
  }
}
