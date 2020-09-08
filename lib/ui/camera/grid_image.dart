import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../theme.dart';
import '../util/lru_map.dart';
import '../widget/loading_widget.dart';

class GridImage extends StatefulWidget {
  final AssetEntity image;
  final ThumbFormat format;

  const GridImage({Key key, @required this.image, @required this.format})
      : super(key: key);
  @override
  _GridImageState createState() => _GridImageState();
}

class _GridImageState extends State<GridImage> {
  @override
  Widget build(BuildContext context) {
    return buildContent(widget.format);
  }

  Widget buildContent(ThumbFormat format) {
    final item = widget.image;
    final size = 130;
    final u8List = ImageLruCache.getData(item, size, format);

    if (u8List != null) {
      return _buildImageWidget(item, u8List, size);
    } else {
      return FutureBuilder<Uint8List>(
        future: item.thumbDataWithSize(size, size, format: format),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              "로드 실패",
              style: BaseTheme.imageErrorTextStyle,
            ));
          }
          if (snapshot.hasData) {
            ImageLruCache.setData(item, size, format, snapshot.data);
            return _buildImageWidget(item, snapshot.data, size);
          } else {
            return LoadingWidget();
          }
        },
      );
    }
  }

  Widget _buildImageWidget(AssetEntity entity, Uint8List uint8list, num size) {
    return Image.memory(
      uint8list,
      width: size.toDouble(),
      height: size.toDouble(),
      fit: BoxFit.cover,
    );
  }

  @override
  void didUpdateWidget(GridImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image.id != oldWidget.image.id) {
      setState(() {});
    }
  }
}
