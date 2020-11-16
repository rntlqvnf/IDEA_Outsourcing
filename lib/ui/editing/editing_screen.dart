import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:emusic/contants/globals.dart';
import 'package:emusic/service/socket_service.dart';
import 'package:emusic/store/gallery/gallery_store.dart';
import 'package:emusic/ui/editing/edit_option.dart';
import 'package:emusic/ui/editing/edit_option_grid_menu.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emusic/routes.dart';
import 'package:emusic/ui/editing/widget/aspect_items.dart';
import 'package:emusic/ui/theme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class EditingScreen extends StatefulWidget {
  EditingScreen({Key key}) : super(key: key);

  @override
  _EditingScreenState createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  final List<AspectRatioItem> _aspectRatios = <AspectRatioItem>[
    AspectRatioItem(text: '자유롭게', value: CropAspectRatios.custom),
    AspectRatioItem(text: '1:1', value: CropAspectRatios.ratio1_1),
    AspectRatioItem(text: '4:3', value: CropAspectRatios.ratio4_3),
    AspectRatioItem(text: '3:4', value: CropAspectRatios.ratio3_4),
    AspectRatioItem(text: '화면 맞춤', value: CropAspectRatios.original),
  ];

  List<EditOption> options;
  AspectRatioItem _aspectRatio;

  @override
  void initState() {
    super.initState();
    _aspectRatio = _aspectRatios.first;

    options = [
      EditOption(
        icon: const Icon(Icons.crop, size: 50),
        onTap: () => showCropOptions(),
      ),
      EditOption(
        icon: const Icon(
          Icons.flip,
          size: 50,
        ),
        onTap: () {
          editorKey.currentState.flip();
        },
      ),
      EditOption(
        icon: const Icon(
          Icons.loop,
          size: 50,
        ),
        onTap: () {
          editorKey.currentState.rotate(right: true);
        },
      ),
      EditOption(
        icon: const Icon(Icons.restore, size: 50),
        onTap: () {
          editorKey.currentState.reset();
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: _editingImagePreviewScreen()),
          Expanded(child: _editOptionGridMenu())
        ],
      ),
    );
  }

  Widget _editingImagePreviewScreen() {
    var galleryStore = Provider.of<GalleryStore>(context, listen: false);

    return Observer(builder: (_) {
      return StreamBuilder(
        initialData: kTransparentImage,
        stream: Stream.fromFuture(
            galleryStore.currentGalleryData.titleImage.originBytes),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error);
          } else {
            return ExtendedImage.memory(snapshot.data,
                fit: BoxFit.contain,
                mode: ExtendedImageMode.editor,
                enableLoadState: true,
                extendedImageEditorKey: editorKey,
                initEditorConfigHandler: (ExtendedImageState state) {
              return EditorConfig(
                  cornerColor: BaseTheme.black,
                  maxScale: 8.0,
                  cropRectPadding: const EdgeInsets.all(20.0),
                  initCropRectType: InitCropRectType.imageRect,
                  cropAspectRatio: _aspectRatio.value);
            });
          }
        },
      );
    });
  }

  Widget _editOptionGridMenu() {
    return EditOptionGridMenu(
      editOptions: options,
    );
  }

  void showCropOptions() {
    showGeneralDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return Column(
            children: <Widget>[
              Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(350),
                child: StatefulBuilder(
                  builder: (context, setState2) {
                    List<Widget> options = [];
                    _aspectRatios.forEach((item) {
                      options.add(Expanded(
                          child: GestureDetector(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AspectRatioWidget(
                              aspectRatio: item.value,
                              drawVertexCircle:
                                  item.value == CropAspectRatios.custom,
                              isSelected: item.value == _aspectRatio.value,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(30),
                            ),
                            Expanded(
                              child: Text(
                                item.text,
                                style: BaseTheme.cropOptionTextStyle.copyWith(
                                    color: item.value == _aspectRatio.value
                                        ? BaseTheme.lightBlue
                                        : BaseTheme.nearlyWhite),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _aspectRatio = item;
                          });
                          setState2(() {});
                        },
                      )));
                    });
                    return Material(
                      type: MaterialType.transparency,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: options,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(100))
            ],
          );
        });
  }
}
