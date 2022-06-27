import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/i18n/i18n.dart';
import '../../components/components.dart';
import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter? presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _hideKeyboard() {
    final focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.presenter?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        widget.presenter!.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoadingSpinner(context);
          } else {
            hideLoadingSpinner(context);
          }
        });

        widget.presenter!.mainErrorStream.listen((error) {
          if (error != null) {
            showErrorMessage(context, error);
          }
        });

        return GestureDetector(
          onTap: _hideKeyboard,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginHeader(),
                Headline1(R.strings.login.toUpperCase()),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Provider<LoginPresenter>(
                    create: (_) => widget.presenter!,
                    child: Form(
                      child: Column(
                        children: [
                          const EmailInput(),
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 8.0,
                              bottom: 32.0,
                            ),
                            child: PasswordInput(),
                          ),
                          const LoginButton(),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.person),
                            label: Text(R.strings.addAccount),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
