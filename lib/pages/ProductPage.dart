import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutteronline/redux/appReducer.dart';
import 'package:flutteronline/redux/product/productAction.dart';
import 'package:flutteronline/redux/product/productReducer.dart';
import 'package:flutteronline/widgets/menu.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  _getData() async {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(getProductAction(store));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(centerTitle: true, title: Text('สินค้า')),
        body: StoreConnector<AppState, ProductState>(
          distinct: true,
          converter: (store) => store.state.productState,
          builder: (context, productState) {
            return productState.isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        productState.course[index]['picture']),
                                    fit: BoxFit.cover))),
                        title: Text(productState.course[index]['title']),
                        subtitle: Text(productState.course[index]['detail']),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          Navigator.pushNamed(context, 'productstack/detail',
                              arguments: {
                                'id': productState.course[index]['id'],
                                'title': productState.course[index]['title']
                              });
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: productState.course.length);
          },
        ));
  }
}
