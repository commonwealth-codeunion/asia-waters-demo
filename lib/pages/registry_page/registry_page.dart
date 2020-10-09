import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'modals/select_points_type_modal.dart';

class RegistryPage extends StatefulWidget {
  RegistryPage({Key key}) : super(key: key);

  @override
  _RegistryPageState createState() => _RegistryPageState();
}

class _RegistryPageState extends State<RegistryPage> {
  File _image;

  final ImagePicker picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  Position _position = Position();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Регистрация аудита'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          children: [
            CupertinoTextField(
              controller: _nameController,
              placeholder: 'Название точки',
            ),
            CupertinoButton(
              child: Text('Выбрать тип '),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  clipBehavior: Clip.none,
                  builder: (context) => SelectPointsTypeModal(),
                );
              },
            ),
            CupertinoButton(
              child: Text(_image == null ? 'Загрузить фото' : 'Фото выбрано'),
              onPressed: () {
                if (_image == null) {
                  return getImage();
                } else {
                  return showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('Вы хотите загрузить новое фото?'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('Ок'),
                            onPressed: () {
                              Navigator.pop(context);
                              return getImage();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('Нет'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            CupertinoButton.filled(
              child: Text('Отправить'),
              onPressed: () async {
                _position = await getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.best,
                );
                print(_position);
                return showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text('Точка зарегистрирована!'),
                    content: Column(
                      children: [
                        Text(
                          'Координаты: ${_position.latitude}\n${_position.longitude}',
                        ),
                      ],
                    ),
                    actions: [
                      CupertinoButton(
                        child: Text(
                          'Отменить',
                          style: TextStyle(
                            color: CupertinoColors.destructiveRed,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoButton(
                        child: Text('Отправить'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
