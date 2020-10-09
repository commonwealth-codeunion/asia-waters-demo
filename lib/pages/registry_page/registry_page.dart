import 'dart:io';

import 'package:asia_water/blocs/registry/registry_bloc.dart';
import 'package:asia_water/models/registry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistryPage extends StatefulWidget {
  RegistryPage({Key key}) : super(key: key);

  @override
  _RegistryPageState createState() => _RegistryPageState();
}

class _RegistryPageState extends State<RegistryPage> {
  File _image;
  RegistryBloc _registryBloc;

  final ImagePicker picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final List<String> _types = ["Супермаркет", "Магазин А", "Магазин В"];
  Position _position = Position();
  int _pickedItem;

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
    _registryBloc = context.bloc<RegistryBloc>();

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
              child: Text(
                _pickedItem == null ? "Выбрать тип" : _types[_pickedItem],
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  clipBehavior: Clip.none,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: CupertinoPicker.builder(
                      childCount: _types.length,
                      itemExtent: 50,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _pickedItem = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Text(
                          _types[index],
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
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
                return showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text('Вы уверены что хотите отпривть аудит?!'),
                    content: Column(
                      children: [
                        BlocConsumer<RegistryBloc, RegistryState>(
                          listener: (context, state) {
                            if (state is Failure) {
                              return showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Text(state.message),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text("OK"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is Success) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            if (state is Loading) {
                              return CupertinoActivityIndicator();
                            }
                            return Text(
                              'Вместе с данными о торговой точке отправятся ваши геоданные',
                            );
                          },
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
                          _registryBloc
                            ..add(SendData(
                              Registry(
                                name: _nameController.text,
                                type: _types[_pickedItem],
                                position: _position,
                              ),
                            ));
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
