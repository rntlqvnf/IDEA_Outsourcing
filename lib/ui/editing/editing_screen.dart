import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditingScreen extends StatelessWidget {
  const EditingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      )),
      body: Image.memory(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
