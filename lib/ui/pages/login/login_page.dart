import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/i18n/i18n.dart';
import '../../components/error_snackbar.dart';
import '../../components/headline1.dart';
import '../../components/login_header.dart';
import '../../components/spinner_dialog.dart';
import './components/components.dart';
import './login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter? presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          showErrorMessage(context, error);
        });

        return SingleChildScrollView(
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
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 32.0,
                          ),
                          child: PasswordInput(),
                        ),
                        StreamBuilder<bool>(
                            stream: widget.presenter!.isFormValidStream,
                            builder: (context, snapshot) {
                              return ElevatedButton(
                                onPressed: (snapshot.data == true)
                                    ? widget.presenter!.auth
                                    : null,
                                child: Text(R.strings.enter.toUpperCase()),
                              );
                            }),
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
        );
      }),
    );
  }
}
