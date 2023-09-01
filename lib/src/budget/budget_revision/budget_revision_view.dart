import 'package:easyfinance/src/budget/budget_revision/budget_revision_provider.dart';
import 'package:easyfinance/src/category/category_class.dart';
import 'package:easyfinance/src/common/listdialog.dart';
import 'package:easyfinance/src/common/form_enum.dart';
import 'package:easyfinance/src/common/messagedialog.dart';
import 'package:easyfinance/src/common/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetRevisionView extends StatelessWidget {
  const BudgetRevisionView({super.key});

  static const routeName = '/budget_revision';

  @override
  Widget build(BuildContext context) {
    final budgetRevisionProvider = Provider.of<BudgetRevisionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Revision'),
        actions: [
          if (budgetRevisionProvider.formMode == FormMode.update)
            IconButton(
                onPressed: () async {
                  bool confirmDelete = await showDialog(
                    context: context,
                    builder: (context) =>
                        MessageDialog.getAlertDialog(context, 'Are you sure?'),
                  );
                  if (confirmDelete) {
                    await budgetRevisionProvider.deleteBudget();
                    if (context.mounted) Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      body: Stack(children: [
        Form(
          key: budgetRevisionProvider.budgetRevisionFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) =>
                      budgetRevisionProvider.formMode == FormMode.update
                          ? Validators.isEmptyValidator(value)
                          : null,
                  decoration: const InputDecoration(hintText: 'ID'),
                  readOnly: true,
                  controller: budgetRevisionProvider.idController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isValidMonth(value),
                  decoration: const InputDecoration(hintText: 'Month'),
                  controller: budgetRevisionProvider.monthController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isValidYear(value),
                  decoration: const InputDecoration(hintText: 'Year'),
                  controller: budgetRevisionProvider.yearController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isEmptyValidator(value),
                  decoration: const InputDecoration(hintText: 'Description'),
                  controller: budgetRevisionProvider.remarkController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isEmptyValidator(value),
                  decoration: const InputDecoration(hintText: 'Amount'),
                  controller: budgetRevisionProvider.amountController,
                ),
              ),
              ListTile(
                title: Text(budgetRevisionProvider.category?.description ??
                    'Select Category'),
                onTap: () async => budgetRevisionProvider
                    .setCategory(await showDialog<CategoryClass>(
                  context: context,
                  builder: (context) => ListDialog.getCategoryListDialog(
                      context, budgetRevisionProvider.categories),
                )),
              ),
              TextButton(
                  onPressed: () async {
                    switch (budgetRevisionProvider.formMode) {
                      case FormMode.insert:
                        await budgetRevisionProvider.insertBudget(context);
                      case FormMode.update:
                        await budgetRevisionProvider.updateBudget(context);
                    }
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
        Visibility(
          visible: budgetRevisionProvider.isAwaiterVisible,
          child: const Center(child: Text('Loading')),
        ),
      ]),
    );
  }
}
