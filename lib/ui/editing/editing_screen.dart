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
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageScreen extends StatefulWidget {
  ImageScreen({Key key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Uint8List image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    image = ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Material(
                color: Colors.transparent,
                child: Center(
                    child: InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(Routes.editing, arguments: image)
                            .then(
                                (newImage) => setState(() => image = newImage)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 15),
                          child: Text('편집',
                              style: BaseTheme.appBarTextStyle
                                  .copyWith(color: BaseTheme.darkBlue)),
                        )))),
            Material(
                color: Colors.transparent,
                child: Center(
                    child: InkWell(
                        onTap: () {
                          SocketService service = locator<SocketService>();
                          locator<SocketService>()
                              .setConnection('192.168.58.1', 9000)
                              .then((_) => service.sendImage(image, (data) {
                                    Navigator.of(context).pushNamed(Routes.home,
                                        arguments: data);
                                  }));
                          BotToast.showCustomLoading(
                              toastBuilder: (cancelFunc) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 25,
                                          child: LoadingIndicator(
                                            color: Colors.grey,
                                            indicatorType:
                                                Indicator.lineSpinFadeLoader,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('분석중...',
                                            style: BaseTheme.widgetTextStyle)
                                      ],
                                    ),
                                  ),
                                );
                              },
                              clickClose: false,
                              allowClick: false,
                              duration: Duration(seconds: 1));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 20),
                          child: Text('전송',
                              style: BaseTheme.appBarTextStyle
                                  .copyWith(color: BaseTheme.darkBlue)),
                        ))))
          ],
        ),
        body: Row(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: SizedBox.expand(
                    child: Image.memory(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ))),
            )
          ],
        ));
  }
}

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
  AspectRatioItem _aspectRatio;

  @override
  void initState() {
    super.initState();
    _aspectRatio = _aspectRatios.first;
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

    /*
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(image),
        ),
        title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              '수정',
              style: BaseTheme.appBarTextStyle,
            )),
        actions: <Widget>[
          Material(
              color: Colors.transparent,
              child: Center(
                  child: InkWell(
                      onTap: () async {
                        Uint8List editedImage = Uint8List.fromList(
                            await editImageDataWithNativeLibrary(
                                state: editorKey.currentState));
                        Navigator.of(context).pop(editedImage);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        child: Text('확인',
                            style: BaseTheme.appBarTextStyle
                                .copyWith(color: BaseTheme.darkBlue)),
                      ))))
        ],
      ),
      body: ExtendedImage.memory(
        image,
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
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.crop),
              onPressed: () => showGeneralDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel,
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
                          height: ScreenUtil().setHeight(300),
                          child: StatefulBuilder(
                            builder: (context, setState2) {
                              List<Widget> options = [];
                              _aspectRatios.forEach((item) {
                                options.add(Expanded(
                                    child: GestureDetector(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: AspectRatioWidget(
                                          aspectRatio: item.value,
                                          drawVertexCircle: item.value ==
                                              CropAspectRatios.custom,
                                          isSelected:
                                              item.value == _aspectRatio.value,
                                        ),
                                      ),
                                      Text(
                                        item.text,
                                        style: BaseTheme.cropOptionTextStyle
                                            .copyWith(
                                                color: item.value ==
                                                        _aspectRatio.value
                                                    ? BaseTheme.lightBlue
                                                    : BaseTheme.nearlyWhite),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: options,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 55)
                      ],
                    );
                  }),
            ),
            IconButton(
              icon: const Icon(Icons.flip),
              onPressed: () {
                editorKey.currentState.flip();
              },
            ),
            IconButton(
              icon: const Icon(Icons.loop),
              onPressed: () {
                editorKey.currentState.rotate(right: true);
              },
            ),
            IconButton(
              icon: const Icon(Icons.restore),
              onPressed: () {
                editorKey.currentState.reset();
              },
            ),
          ],
        ),
      ),
    ); */
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
    List<EditOption> options = [
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

    return EditOptionGridMenu(
      editOptions: options,
    );
  }
}
