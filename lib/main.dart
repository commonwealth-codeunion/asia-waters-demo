import 'package:asia_water/blocs/login/login_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc()..add(StartVerification()),
        ),
      ],
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
