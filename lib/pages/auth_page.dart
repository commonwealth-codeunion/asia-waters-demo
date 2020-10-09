import 'package:asia_water/blocs/login/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final EdgeInsets textFieldPadding = EdgeInsets.symmetric(
    vertical: 14,
    horizontal: 16,
  );

  LoginBloc _loginBloc;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    _loginBloc = context.bloc<LoginBloc>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Авторизация'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Form(
            child: Column(
              children: [
                CupertinoTextField(
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  placeholder: 'Логин',
                  padding: textFieldPadding,
                ),
                SizedBox(height: 15),
                CupertinoTextField(
                  controller: _passwordController,
                  placeholder: 'Пароль',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  padding: textFieldPadding,
                ),
                SizedBox(height: 32),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoggedIn) {
                      _isLoading = state.isLoading;
                      return Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed('/home');
                    }
                    if (state is Failure) {
                      _isLoading = state.isLoading;
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
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      _isLoading = state.isLoading;
                      return CupertinoActivityIndicator();
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CupertinoButton.filled(
                            child: Text(
                              'Войти',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 18,
                            ),
                            disabledColor: CupertinoColors.inactiveGray,
                            onPressed: _isLoading
                                ? null
                                : () => _loginBloc.add(LogIn(
                                      email: _usernameController.text,
                                      password: _passwordController.text,
                                    )),
                          ),
                          SizedBox(height: 25),
                          CupertinoButton.filled(
                            child: Text(
                              'Зарегистрироваться',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 18,
                            ),
                            disabledColor: CupertinoColors.inactiveGray,
                            onPressed: _isLoading
                                ? null
                                : () => _loginBloc.add(Register(
                                      email: _usernameController.text,
                                      password: _passwordController.text,
                                    )),
                          ),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
