import 'package:flutter/material.dart';

import '../../../utils/i18n/i18n.dart';
import '../../components/headline1.dart';
import '../../components/login_header.dart';
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
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => SimpleDialog(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10.0),
                      Text(
                        R.strings.wait,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          }
        });

        widget.presenter!.mainErrorStream.listen((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red.shade900,
            content: Text(
              error,
              textAlign: TextAlign.center,
            ),
          ));
        });

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LoginHeader(),
              Headline1(R.strings.login.toUpperCase()),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  child: Column(
                    children: [
                      StreamBuilder<String?>(
                          stream: widget.presenter!.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: R.strings.email,
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                errorText: (snapshot.data?.isNotEmpty == true)
                                    ? snapshot.data
                                    : null,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: widget.presenter!.validateEmail,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 32.0,
                        ),
                        child: StreamBuilder<String?>(
                            stream: widget.presenter!.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: R.strings.password,
                                  icon: Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                  errorText: (snapshot.data?.isNotEmpty) == true
                                      ? snapshot.data
                                      : null,
                                ),
                                obscureText: true,
                                onChanged: widget.presenter!.validatePassword,
                              );
                            }),
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
            ],
          ),
        );
      }),
    );
  }
}
