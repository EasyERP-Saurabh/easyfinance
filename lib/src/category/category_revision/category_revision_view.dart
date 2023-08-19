import 'package:easyfinance/src/category/category_class.dart';
import 'package:easyfinance/src/category/category_revision/category_revision_provider.dart';
import 'package:easyfinance/src/common/form_enum.dart';
import 'package:easyfinance/src/common/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryRevisionView extends StatelessWidget {
  const CategoryRevisionView({super.key});

  static const routeName = '/category_revision';

  @override
  Widget build(BuildContext context) {
    final categoryRevisionProvider =
        Provider.of<CategoryRevisionProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Category Revision')),
      body: Stack(children: [
        Form(
          key: categoryRevisionProvider.categoryRevisionFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) =>
                      categoryRevisionProvider.formMode == FormMode.update
                          ? Validators.isEmptyValidator(value)
                          : null,
                  decoration: const InputDecoration(hintText: 'ID'),
                  readOnly: true,
                  controller: categoryRevisionProvider.idController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isEmptyValidator(value),
                  decoration: const InputDecoration(hintText: 'Description'),
                  controller: categoryRevisionProvider.descriptionController,
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    label: const Text('Income'),
                    icon: Icon(categoryRevisionProvider.categoryType ==
                            CategoryType.income
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off),
                    onPressed: () => categoryRevisionProvider
                        .setCategoryType(CategoryType.income),
                  ),
                  TextButton.icon(
                    label: const Text('Expenditure'),
                    icon: Icon(categoryRevisionProvider.categoryType ==
                            CategoryType.expenditure
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off),
                    onPressed: () => categoryRevisionProvider
                        .setCategoryType(CategoryType.expenditure),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () async {
                    switch (categoryRevisionProvider.formMode) {
                      case FormMode.insert:
                        await categoryRevisionProvider.insert(context);
                      case FormMode.update:
                        await categoryRevisionProvider.update(context);
                    }
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
        Visibility(
          visible: categoryRevisionProvider.isAwaiterVisible,
          child: const Center(child: Text('Loading')),
        ),
      ]),
    );
  }
}
