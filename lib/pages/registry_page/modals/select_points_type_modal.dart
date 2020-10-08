import 'package:flutter/cupertino.dart';

class SelectPointsTypeModal extends StatelessWidget {
  const SelectPointsTypeModal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Positioned(
          top: -10,
          height: 3,
          width: 47,
          left: MediaQuery.of(context).size.width / 2.3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: CupertinoColors.inactiveGray,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(12),
            ),
          ),
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            children: [
              Text(
                'Типы',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  children: [
                    Text('Супермаркеты'),
                    Text('Магазин B'),
                    Text('Магазин C'),
                  ],
                  itemExtent: 50,
                  onSelectedItemChanged: (index) {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
