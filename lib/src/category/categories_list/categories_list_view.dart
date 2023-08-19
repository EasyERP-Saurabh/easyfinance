import 'package:easyfinance/src/category/categories_list/categories_list_provider.dart';
import 'package:easyfinance/src/category/category_revision/category_revision_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  static const routeName = '/categories_list';

  @override
  Widget build(BuildContext context) {
    final categoriesListProvider = Provider.of<CategoriesListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catagories Lists'),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, CategoryRevisionView.routeName);
                await categoriesListProvider.getCategories();
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
                      child:
                          Text('Category Type', textAlign: TextAlign.center)),
                  Expanded(flex: 3, child: Text('Category Description')),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categoriesListProvider.catagories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                                '${categoriesListProvider.catagories[index].id}',
                                textAlign: TextAlign.center)),
                        Expanded(
                            flex: 2,
                            child: Text(
                                categoriesListProvider
                                    .catagories[index].categoryType,
                                textAlign: TextAlign.center)),
                        Expanded(
                            flex: 3,
                            child: Text(categoriesListProvider
                                .catagories[index].description)),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.pushNamed(
                          context, CategoryRevisionView.routeName,
                          arguments:
                              categoriesListProvider.catagories[index].id);
                      await categoriesListProvider.getCategories();
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Visibility(
          visible: categoriesListProvider.isAwaiterVisible,
          child: const Center(child: Text('Loading')),
        ),
      ]),
    );
  }
}
