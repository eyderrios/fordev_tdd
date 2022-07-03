import 'package:flutter/material.dart';
import 'package:fordev_tdd/ui/pages/signup/sigup_presenter.dart';
import 'package:provider/provider.dart';

import '../../../../ui/helpers/i18n/i18n.dart';
import '../../../helpers/errors/ui_error.dart';

class NameInput extends StatelessWidget {
  const NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<UIError?>(
        stream: presenter.nameErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: R.strings.name,
              icon: Icon(
                Icons.person,
                color: Theme.of(context).primaryColorLight,
              ),
              errorText:
                  (snapshot.data != null) ? snapshot.data!.description : null,
            ),
            keyboardType: TextInputType.name,
            onChanged: presenter.validateName,
          );
        });
  }
}
