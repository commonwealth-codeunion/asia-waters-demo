import 'package:asia_water/utils/date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuditCardWidget extends StatelessWidget {
  const AuditCardWidget({
    Key key,
    this.document,
  }) : super(key: key);

  final Map<String, dynamic> document;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        print('Карточка реестра нажата.');
      },
      color: CupertinoColors.activeBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${document['name']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            toStringDate(DateTime.fromMillisecondsSinceEpoch(
                document['date'].seconds * 1000)),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
