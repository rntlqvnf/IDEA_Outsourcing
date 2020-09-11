import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:python_app/ui/theme.dart';

class EditingScreen extends StatelessWidget {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  EditingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
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
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        child: Text('전송',
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
              cropAspectRatio: CropAspectRatios.custom);
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
              onPressed: () {},
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
    );
  }
}
