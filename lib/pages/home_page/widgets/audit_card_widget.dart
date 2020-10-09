import 'package:asia_water/utils/date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AuditCardWidget extends StatelessWidget {
  const AuditCardWidget({
    Key key,
    this.document,
  }) : super(key: key);

  final Map<String, dynamic> document;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Карточка реестра нажата.');
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${document['name']}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              toStringDate(DateTime.fromMillisecondsSinceEpoch(document['date'].seconds * 1000)),
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.inactiveGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
