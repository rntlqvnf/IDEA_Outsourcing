import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:python_app/ui/theme.dart';
import 'package:python_app/ui/util/lru_map.dart';
import 'package:python_app/ui/widget/loading_widget.dart';

class GridImage extends StatefulWidget {
  final AssetEntity entity;
  final ThumbFormat format;

  const GridImage({Key key, this.entity, this.format}) : super(key: key);
  @override
  _GridImageState createState() => _GridImageState();
}

class _GridImageState extends State<GridImage> {
  @override
  Widget build(BuildContext context) {
    return buildContent(widget.format);
  }

  Widget buildContent(ThumbFormat format) {
    if (widget.entity.type == AssetType.audio) {
      return Center(
        child: Icon(
          Icons.audiotrack,
          size: 30,
        ),
      );
    }
    final item = widget.entity;
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
    return FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: MemoryImage(kTransparentImage),
                          image: Image.memory(
      uint8list,
      width: size.toDouble(),
      height: size.toDouble(),
      fit: BoxFit.cover,
    ),
                        )

    return ;
  }

  @override
  void didUpdateWidget(GridImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.entity.id != oldWidget.entity.id) {
      setState(() {});
    }
  }
}
