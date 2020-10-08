import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/login/login_bloc.dart';
import 'pages/auth_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: CupertinoApp(
        theme: CupertinoThemeData(brightness: Brightness.light),
        home: AuthPage(),
        routes: {
          // '/home': (context)=> HomePage(),
          '/auth': (context) => AuthPage(),
        },
      ),
    );
  }
}
