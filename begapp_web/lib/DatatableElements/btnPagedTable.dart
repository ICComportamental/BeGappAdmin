import 'package:flutter/material.dart';

class PagedTableButtons extends StatelessWidget {
  final Function previous;
  final Function next;

  const PagedTableButtons({
    Key? key,
    required this.previous,
    required this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 20,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => previous(),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 20,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_forward),
          color: Colors.white,
          onPressed: () => next(),
        ),
      ),
    ]);
  }
}
