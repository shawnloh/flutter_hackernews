import 'dart:async';

import 'package:flutter/material.dart';

import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) {
//            return Text('Still loading comment');
            return LoadingContainer();
          }

          final item = snapshot.data;
          final children = <Widget>[
            ListTile(
              title: buildText(item),
              subtitle: Text(item.by == '' ? 'deleted' : item.by),
              contentPadding: EdgeInsets.only(
                  left: depth.roundToDouble() * 16.0, right: 16.0),
            ),
            Divider(),
          ];

          snapshot.data.kids.forEach((kidId) {
            children.add(Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ));
          });

          return Column(
            children: children,
          );
        });
  }

  buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', '\'')
        .replaceAll('<p>', '\n')
        .replaceAll('</p>', '')
        .replaceAll('&quot;', '"')
        .replaceAll('&#x2F;', '/');
    return Text(text);
  }
}
