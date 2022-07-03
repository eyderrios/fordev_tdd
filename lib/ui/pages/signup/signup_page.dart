import 'package:flutter/material.dart';
import 'package:fordev_tdd/ui/pages/signup/sigup_presenter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../ui/helpers/i18n/i18n.dart';
import '../../components/components.dart';
import '../../helpers/errors/ui_error.dart';
import 'components/components.dart';

class SignUpPage extends StatelessWidget {
  final SignUpPresenter presenter;

  const SignUpPage(this.presenter, {Key? key}) : super(key: key);

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
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoadingSpinner(context);
          } else {
            hideLoadingSpinner(context);
          }
        });

        presenter.mainErrorStream.listen((error) {
          if (error != null) {
            showErrorMessage(context, error.description);
          }
        });

        presenter.navigateToStream.listen((page) {
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
                // const LoginHeader(),
                // Headline1(R.strings.addAccount.toUpperCase()),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Provider<SignUpPresenter>.value(
                    value: presenter,
                    child: Form(
                      child: Column(
                        children: [
                          const NameInput(),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: EmailInput(),
                          ),
                          const PasswordInput(),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 32.0),
                            child: PasswordConfirmationInput(),
                          ),
                          const SignUpButton(),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.exit_to_app),
                            label: Text(R.strings.signUp),
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
