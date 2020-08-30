// found in the LICENSE file.

// ignore_for_file: public_member_api_docs
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:python_app/store/camera/camera_store.dart';
import 'package:python_app/ui/widget/toast_generator.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:video_player/video_player.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver, AnimationMixin {
  CameraStore cameraStore;
  Animation<double> toggleAnimation;

  @override
  void initState() {
    super.initState();
    toggleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

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
          _appBar(),
          Expanded(
            flex: 6,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Observer(builder: (_) {
                        return cameraStore.loading
                            ? Container()
                            : CameraPreview(cameraStore.controller);
                      }),
                      Align(
                          alignment: FractionalOffset.bottomLeft,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(50),
                                  bottom: ScreenUtil().setHeight(50)),
                              child: Transform.rotate(
                                angle: pi * toggleAnimation.value,
                                child: RotatedBox(
                                  quarterTurns: 2,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.loop,
                                      size: 33,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      controller.isDismissed
                                          ? controller.play()
                                          : controller.playReverse();
                                      cameraStore.toggleCamera();
                                    },
                                  ),
                                ),
                              )))
                    ],
                  ),
                )),
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

  /*
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
  }*/

  Widget _appBar() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: AppBar().preferredSize.height + 40,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '사진',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(70),
                      fontFamily: 'NanumGothic',
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                width: AppBar().preferredSize.height + 40,
                height: AppBar().preferredSize.height,
              ),
            ],
          ),
        ));
  }
}
