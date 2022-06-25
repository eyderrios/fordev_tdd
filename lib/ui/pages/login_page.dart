import 'package:flutter/material.dart';

import '../../utils/i18n/i18n.dart';
import '../components/headline1.dart';
import '../components/login_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: R.strings.email,
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 32.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: R.strings.password,
                          icon: Icon(Icons.lock,
                              color: Theme.of(context).primaryColorLight),
                        ),
                        obscureText: true,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(R.strings.enter.toUpperCase()),
                    ),
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
      ),
    );
  }
}
