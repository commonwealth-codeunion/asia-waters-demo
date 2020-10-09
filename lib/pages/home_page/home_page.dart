import 'package:asia_water/blocs/login/login_bloc.dart';
import 'package:asia_water/pages/home_page/widgets/audit_card_widget.dart';
import 'package:asia_water/pages/registry_page/registry_page.dart';
import 'package:asia_water/service/registry_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final RegistryService _registryService = RegistryService();

  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    _loginBloc = context.bloc<LoginBloc>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is Failure) {
              return showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('Ошибка'),
                    content: Text('${state.message}'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('Ок'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                },
              );
            }
            if (state is LogedOut) {
              Navigator.pushReplacementNamed(context, '/auth');
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              return CupertinoActivityIndicator();
            } else {
              return CupertinoButton(
                onPressed: () {
                  _loginBloc..add(LogOut());
                },
                padding: EdgeInsets.zero,
                child: Icon(
                  IconData(
                    0xf90c,
                    fontFamily: 'CupertinoIcons',
                    fontPackage: 'cupertino_icons',
                  ),
                  color: CupertinoColors.destructiveRed,
                  size: 20,
                ),
              );
            }
          },
        ),
        middle: Text('Реест аудитов'),
        trailing: CupertinoButton(
          onPressed: () {
            print('Регистрация нового аудита');
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => RegistryPage()),
            );
          },
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.add,
            size: 20,
          ),
        ),
      ),
      child: SafeArea(
        child: StreamBuilder(
            stream: RegistryService().getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => AuditCardWidget(
                    document: snapshot.data.documents[index].data(),
                  ),
                );
              } else {
                return Offstage();
              }
            }),
      ),
    );
  }
}
