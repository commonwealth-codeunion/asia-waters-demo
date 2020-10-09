import 'package:asia_water/pages/home_page/widgets/audit_card_widget.dart';
import 'package:asia_water/pages/registry_page/registry_page.dart';
import 'package:asia_water/service/registry_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final RegistryService _registryService = RegistryService();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
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
            stream: FirebaseFirestore.instance
                .collection('registry_audits')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  itemCount: 1,
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
