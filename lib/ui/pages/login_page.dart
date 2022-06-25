import 'package:flutter/material.dart';

import '../../utils/i18n/i18n.dart';
import '../assets/assets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppAssets.logo),
            Text(R.strings.login.toUpperCase()),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: R.strings.email,
                      icon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: R.strings.password,
                      icon: const Icon(Icons.lock),
                    ),
                    obscureText: true,
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
          ],
        ),
      ),
    );
  }
}
