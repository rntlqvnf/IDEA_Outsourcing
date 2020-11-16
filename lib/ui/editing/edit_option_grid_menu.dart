import 'package:emusic/ui/editing/edit_option.dart';
import 'package:flutter/cupertino.dart';

class EditOptionGridMenu extends StatelessWidget {
  final List<EditOption> editOptions;

  const EditOptionGridMenu({
    Key key,
    this.editOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1.5,
        crossAxisSpacing: 1.5,
        childAspectRatio: 1,
      ),
      itemCount: editOptions.length,
      itemBuilder: (context, index) => editOptions[index],
    );
  }
}
