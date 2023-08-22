import 'package:easyfinance/src/transactions/transactions_list/transactions_list_provider.dart';
import 'package:easyfinance/src/transactions/transaction_revision/transaction_revision_view.dart';
import 'package:easyfinance/src/common/messagedialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionsListView extends StatelessWidget {
  const TransactionsListView({super.key});

  static const routeName = '/transactions_list';

  @override
  Widget build(BuildContext context) {
    final transactionsListProvider =
        Provider.of<TransactionsListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions Lists'),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, TransactionRevisionView.routeName);
                await transactionsListProvider.getTransactions();
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
                      child: Text('Transaction Date',
                          textAlign: TextAlign.center)),
                  Expanded(
                      flex: 3,
                      child: Text('Description')), //category description
                  Expanded(flex: 2, child: Text('Type')), //category type
                  Expanded(flex: 2, child: Text('Account')),
                  Expanded(flex: 2, child: Text('Account Type')),
                  Expanded(flex: 3, child: Text('Remark')),
                  Expanded(
                      flex: 1,
                      child: Text('Action', textAlign: TextAlign.center)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: transactionsListProvider.transactions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                                '${transactionsListProvider.transactions[index].id}',
                                textAlign: TextAlign.center)),
                        Expanded(
                            flex: 2,
                            child: Text(
                                DateFormat('dd MMM yyyy').format(
                                    transactionsListProvider
                                        .transactions[index].transactionDate),
                                textAlign: TextAlign.center)),
                        Expanded(
                            flex: 3,
                            child: Text(transactionsListProvider
                                .transactions[index].categoryDescription)),
                        Expanded(
                            flex: 2,
                            child: Text(transactionsListProvider
                                .transactions[index]
                                .categoryType)), //category type
                        Expanded(
                            flex: 2,
                            child: Text(
                                '${transactionsListProvider.transactions[index].accountId}')),
                        Expanded(
                            flex: 2,
                            child: Text(transactionsListProvider
                                .transactions[index].accountType)),
                        Expanded(
                            flex: 3,
                            child: Text(transactionsListProvider
                                .transactions[index].remark)),
                        const Expanded(
                            flex: 1,
                            child: Text('Action', textAlign: TextAlign.center)),
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
                                    await transactionsListProvider
                                        .deleteTransaction(
                                            transactionsListProvider
                                                .transactions[index].id);
                                    await transactionsListProvider
                                        .getTransactions();
                                  }
                                },
                                icon: const Icon(Icons.delete))),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.pushNamed(
                          context, TransactionRevisionView.routeName,
                          arguments:
                              transactionsListProvider.transactions[index].id);
                      await transactionsListProvider.getTransactions();
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Visibility(
          visible: transactionsListProvider.isAwaiterVisible,
          child: const Center(child: Text('Loading')),
        ),
      ]),
    );
  }
}
