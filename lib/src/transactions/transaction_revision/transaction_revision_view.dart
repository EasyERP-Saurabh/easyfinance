import 'package:easyfinance/src/category/category_class.dart';
import 'package:easyfinance/src/transactions/transaction_revision/transaction_revision_provider.dart';
import 'package:easyfinance/src/common/form_enum.dart';
import 'package:easyfinance/src/common/messagedialog.dart';
import 'package:easyfinance/src/common/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionRevisionView extends StatelessWidget {
  const TransactionRevisionView({super.key});

  static const routeName = '/transaction_revision';

  @override
  Widget build(BuildContext context) {
    final transactionRevisionProvider =
        Provider.of<TransactionRevisionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Revision'),
        actions: [
          if (transactionRevisionProvider.formMode == FormMode.update)
            IconButton(
                onPressed: () async {
                  bool confirmDelete = await showDialog(
                    context: context,
                    builder: (context) =>
                        MessageDialog.getAlertDialog(context, 'Are you sure?'),
                  );
                  if (confirmDelete) {
                    //await transactionRevisionProvider.deleteCategory();
                    if (context.mounted) Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      body: Stack(children: [
        Form(
          key: transactionRevisionProvider.transactionRevisionFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) =>
                      transactionRevisionProvider.formMode == FormMode.update
                          ? Validators.isEmptyValidator(value)
                          : null,
                  decoration: const InputDecoration(hintText: 'ID'),
                  readOnly: true,
                  controller: transactionRevisionProvider.idController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isEmptyValidator(value),
                  decoration: const InputDecoration(hintText: 'Description'),
                  controller: transactionRevisionProvider.descriptionController,
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    label: const Text('Income'),
                    icon: Icon(transactionRevisionProvider.categoryType ==
                            CategoryType.income
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off),
                    onPressed: () => transactionRevisionProvider
                        .setCategoryType(CategoryType.income),
                  ),
                  TextButton.icon(
                    label: const Text('Expenditure'),
                    icon: Icon(transactionRevisionProvider.categoryType ==
                            CategoryType.expenditure
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off),
                    onPressed: () => transactionRevisionProvider
                        .setCategoryType(CategoryType.expenditure),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () async {
                    switch (transactionRevisionProvider.formMode) {
                      case FormMode.insert:
                        await transactionRevisionProvider
                            .insertTransaction(context);
                      case FormMode.update:
                        await transactionRevisionProvider
                            .updateTransaction(context);
                    }
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
        Visibility(
          visible: transactionRevisionProvider.isAwaiterVisible,
          child: const Center(child: Text('Loading')),
        ),
      ]),
    );
  }
}
