import 'package:easyfinance/src/account/account_class.dart';
import 'package:easyfinance/src/account/accounts_list/accounts_list_provider.dart';
import 'package:easyfinance/src/account/account_revision/account_revision_view.dart';
import 'package:easyfinance/src/common/messagedialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsListView extends StatelessWidget {
  const AccountsListView({super.key});

  static const routeName = '/accounts_list';

  @override
  Widget build(BuildContext context) {
    final accountsListProvider = Provider.of<AccountsListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts Lists'),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, AccountRevisionView.routeName);
                await accountsListProvider.getAccounts();
              },
              icon: const Icon(Icons.add_box))
        ],
      ),
      body: Stack(children: [
        Column(
          children: [
            const ListTile(
              title: Row(
                children: [
                  Expanded(
                      flex: 1, child: Text('ID', textAlign: TextAlign.center)),
                  Expanded(
                      flex: 2,
                      child: Text('Account Type', textAlign: TextAlign.center)),
                  Expanded(flex: 3, child: Text('Account Description')),
                  Expanded(
                      flex: 1,
                      child: Text('Action', textAlign: TextAlign.center)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: accountsListProvider.accounts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                                '${accountsListProvider.accounts[index].id}',
                                textAlign: TextAlign.center)),
                        Expanded(
                            flex: 2,
                            child: Text(
                                getAccountType(accountsListProvider
                                            .accounts[index].accountType)
                                        ?.label ??
                                    '',
                                textAlign: TextAlign.center)),
                        Expanded(
                            flex: 3,
                            child: Text(accountsListProvider
                                .accounts[index].description)),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () async {
                                  bool confirmDelete = await showDialog(
                                    context: context,
                                    builder: (context) =>
                                        MessageDialog.getAlertDialog(
                                            context, 'Are you sure?'),
                                  );
                                  if (confirmDelete) {
                                    await accountsListProvider.deleteAccount(
                                        accountsListProvider
                                            .accounts[index].id);
                                    await accountsListProvider.getAccounts();
                                  }
                                },
                                icon: const Icon(Icons.delete))),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.pushNamed(
                          context, AccountRevisionView.routeName,
                          arguments: accountsListProvider.accounts[index].id);
                      await accountsListProvider.getAccounts();
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Visibility(
          visible: accountsListProvider.isAwaiterVisible,
          child: const Center(child: Text('Loading')),
        ),
      ]),
    );
  }
}
