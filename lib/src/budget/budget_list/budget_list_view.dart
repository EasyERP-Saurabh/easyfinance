import 'package:easyfinance/src/budget/budget_list/budget_list_provider.dart';
import 'package:easyfinance/src/budget/budget_revision/budget_revision_view.dart';
import 'package:easyfinance/src/category/category_class.dart';
import 'package:easyfinance/src/common/messagedialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetListView extends StatelessWidget {
  const BudgetListView({super.key});

  static const routeName = '/budget_list';

  @override
  Widget build(BuildContext context) {
    final budgetListProvider = Provider.of<BudgetListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets Lists'),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, BudgetRevisionView.routeName);
                await budgetListProvider.getBudgets();
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
                      flex: 1,
                      child: Text('Month', textAlign: TextAlign.center)),
                  Expanded(
                      flex: 1,
                      child: Text('Year', textAlign: TextAlign.center)),
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Category Description',
                        textAlign: TextAlign.center,
                      )),
                  Expanded(flex: 2, child: Text('Category Type')),
                  Expanded(
                      flex: 2,
                      child: Text('Amount', textAlign: TextAlign.center)),
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
                itemCount: budgetListProvider.budgets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                                '${budgetListProvider.budgets[index].id}',
                                textAlign: TextAlign.center)),
                        Expanded(
                            flex: 1,
                            child: Text(
                                '${budgetListProvider.budgets[index].budgetMonth}',
                                textAlign: TextAlign.center)),
                        Expanded(
                            flex: 1,
                            child: Text(
                                '${budgetListProvider.budgets[index].budgetYear}',
                                textAlign: TextAlign.center)),
                        Expanded(
                            flex: 3,
                            child: Text(
                              budgetListProvider
                                  .budgets[index].categoryDescription,
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(getCategoryType(budgetListProvider
                                        .budgets[index].categoryType)
                                    ?.label ??
                                '')),
                        Expanded(
                            flex: 2,
                            child: Text(
                              budgetListProvider.budgets[index].amount
                                  .toStringAsFixed(2),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 3,
                            child:
                                Text(budgetListProvider.budgets[index].remark)),
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
                                    await budgetListProvider.deleteBudget(
                                        budgetListProvider.budgets[index].id);
                                    await budgetListProvider.getBudgets();
                                  }
                                },
                                icon: const Icon(Icons.delete))),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.pushNamed(
                          context, BudgetRevisionView.routeName,
                          arguments: budgetListProvider.budgets[index].id);
                      await budgetListProvider.getBudgets();
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Visibility(
          visible: budgetListProvider.isAwaiterVisible,
          child: const Center(child: Text('Loading')),
        ),
      ]),
    );
  }
}
