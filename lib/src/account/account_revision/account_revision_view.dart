import 'package:easyfinance/src/account/account_class.dart';
import 'package:easyfinance/src/account/account_revision/account_revision_provider.dart';
import 'package:easyfinance/src/common/form_enum.dart';
import 'package:easyfinance/src/common/messagedialog.dart';
import 'package:easyfinance/src/common/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountRevisionView extends StatelessWidget {
  const AccountRevisionView({super.key});

  static const routeName = '/account_revision';

  @override
  Widget build(BuildContext context) {
    final accountRevisionProvider =
        Provider.of<AccountRevisionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Revision'),
        actions: [
          if (accountRevisionProvider.formMode == FormMode.update)
            IconButton(
                onPressed: () async {
                  bool confirmDelete = await showDialog(
                    context: context,
                    builder: (context) =>
                        MessageDialog.getAlertDialog(context, 'Are you sure?'),
                  );
                  if (confirmDelete) {
                    await accountRevisionProvider.deleteAccount();
                    if (context.mounted) Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      body: Stack(children: [
        Form(
          key: accountRevisionProvider.accountRevisionFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) =>
                      accountRevisionProvider.formMode == FormMode.update
                          ? Validators.isEmptyValidator(value)
                          : null,
                  decoration: const InputDecoration(hintText: 'ID'),
                  readOnly: true,
                  controller: accountRevisionProvider.idController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isEmptyValidator(value),
                  decoration: const InputDecoration(hintText: 'Description'),
                  controller: accountRevisionProvider.descriptionController,
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    label: Text(AccountType.bank.label),
                    icon: Icon(
                        accountRevisionProvider.accountType == AccountType.bank
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off),
                    onPressed: () => accountRevisionProvider
                        .setAccountType(AccountType.bank),
                  ),
                  TextButton.icon(
                    label: Text(AccountType.cash.label),
                    icon: Icon(
                        accountRevisionProvider.accountType == AccountType.cash
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off),
                    onPressed: () => accountRevisionProvider
                        .setAccountType(AccountType.cash),
                  ),
                  TextButton.icon(
                    label: Text(AccountType.credit.label),
                    icon: Icon(accountRevisionProvider.accountType ==
                            AccountType.credit
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off),
                    onPressed: () => accountRevisionProvider
                        .setAccountType(AccountType.credit),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () async {
                    switch (accountRevisionProvider.formMode) {
                      case FormMode.insert:
                        await accountRevisionProvider.insertAccount(context);
                      case FormMode.update:
                        await accountRevisionProvider.updateAccount(context);
                    }
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
        Visibility(
          visible: accountRevisionProvider.isAwaiterVisible,
          child: const Center(child: Text('Loading')),
        ),
      ]),
    );
  }
}
