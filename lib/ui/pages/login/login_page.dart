import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../ui/helpers/i18n/i18n.dart';
import '../../components/components.dart';
import '../../helpers/errors/ui_error.dart';
import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter? presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  void _hideKeyboard(BuildContext context) {
    final focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        presenter!.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoadingSpinner(context);
          } else {
            hideLoadingSpinner(context);
          }
        });

        presenter!.mainErrorStream.listen((error) {
          if (error != null) {
            showErrorMessage(context, error.description);
          }
        });

        presenter!.navigateToStream.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page!);
          }
        });

        return GestureDetector(
          onTap: () => _hideKeyboard(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginHeader(),
                Headline1(R.strings.login.toUpperCase()),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Provider(
                    create: (_) => presenter!,
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
                            onPressed: presenter!.goToSignUp,
                            icon: const Icon(Icons.person),
                            label: Text(R.strings.login),
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
