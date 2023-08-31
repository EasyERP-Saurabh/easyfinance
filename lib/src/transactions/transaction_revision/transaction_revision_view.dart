import 'package:easyfinance/src/account/account_class.dart';
import 'package:easyfinance/src/category/category_class.dart';
import 'package:easyfinance/src/common/listdialog.dart';
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
        title: const Text('Transaction Revision'),
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
                  decoration: const InputDecoration(hintText: 'Date'),
                  onTap: () async {
                    //             DateTime? selectedDate = await showDatePicker(
                    //     context: context,
                    //     initialDate: transactionRevisionProvider.date,
                    //     firstDate: DateTime(1900),
                    //     lastDate: DateTime(9999));
                    // if (selectedDate != null) {
                    //   field.controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    //   field.isSelected = true;
                    // } else {
                    //   field.controller.clear();
                    //   field.isSelected = false;
                    // }
                    // field.value = selectedDate; //dd-MMM-yyyy
                  },
                  controller: transactionRevisionProvider.remarkController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isEmptyValidator(value),
                  decoration: const InputDecoration(hintText: 'Description'),
                  controller: transactionRevisionProvider.remarkController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isEmptyValidator(value),
                  decoration: const InputDecoration(hintText: 'Amount'),
                  controller: transactionRevisionProvider.amountController,
                ),
              ),
              ListTile(
                title: Text(transactionRevisionProvider.category?.description ??
                    'Select Category'),
                onTap: () async => transactionRevisionProvider
                    .setCategory(await showDialog<CategoryClass>(
                  context: context,
                  builder: (context) => ListDialog.getCategoryListDialog(
                      context, transactionRevisionProvider.categories),
                )),
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
