import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter_app/components/product_row_item.dart';
import 'package:sample_flutter_app/models/app_state_model.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final products = model.getProducts();
        return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/sample/background_sample.png'),
              fit: BoxFit.cover,
            )),
            child: CustomScrollView(
              semanticChildCount: products.length,
              slivers: <Widget>[
                const CupertinoSliverNavigationBar(
                  largeTitle: Text('ホーム画面'),
                ),
                SliverSafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(top: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < products.length) {
                          return ProductRowItem(
                            product: products[index],
                            lastItem: index == products.length - 1,
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}
