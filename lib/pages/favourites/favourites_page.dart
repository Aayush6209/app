import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/providers/products_provider.dart';
import 'package:trendmate/services/firebase_methods.dart';

class FavouritesPage extends StatefulWidget {
  static const routeName = '/favourites-page';
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: Text(
          "Favourites",
          style: TextStyle(color: Colors.black, fontSize: 21),
        ),
      ),
      body: productsProvider.favorites.isEmpty
          ? Center(
              child: Text("Favorites List is Empty!"),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.5),
              itemCount: productsProvider.favorites.length,
              itemBuilder: (ctx, idx) {
                return FutureBuilder<Product>(
                    future: FirebaseMethods.instance
                        .getProduct(productsProvider.favorites[idx]),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      final product = snapshot.data!;

                      return Card(
                        child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    //alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Image.network(
                                      // TODO
                                      product.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8),
                                  // TODO
                                  child: Text(product.title),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 10),
                                      child: Text(
                                        // TODO
                                        "Rs. ${product.price.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[600]),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: IconButton(
                                              color: Colors.red,
                                              icon: Icon(productsProvider
                                                      .favoritesSet
                                                      .contains(productsProvider
                                                          .favorites[idx])
                                                  ? Icons.favorite
                                                  : Icons.favorite_border),
                                              onPressed: () {
                                                if (productsProvider
                                                    .favoritesSet
                                                    .contains(productsProvider
                                                        .favorites[idx])) {
                                                  productsProvider
                                                      .removeFavorites(
                                                          productsProvider
                                                              .favorites[idx]);
                                                } else {
                                                  productsProvider.addFavorites(
                                                      productsProvider
                                                          .favorites[idx]);
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ]),
                        ),
                      );
                    });
              }),
    );
  }
}
