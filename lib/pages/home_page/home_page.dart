import 'package:asia_water/pages/home_page/widgets/audit_card_widget.dart';
import 'package:asia_water/pages/registry_page/registry_page.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

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
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 15),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          itemCount: 4,
          itemBuilder: (context, index) => AuditCardWidget(),
        ),
      ),
    );
  }
}
