import 'package:assign/models/Product.dart';
import 'package:assign/screen/detail/detail_screen.dart';
import 'package:assign/screen/home/components/categories.dart';
import 'package:assign/screen/home/components/items_card.dart';
import 'package:assign/screen/home/components/items_card_fs.dart';
import 'package:flutter/material.dart';

class BodyH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Garage Tuning",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: GridView.builder(
              itemCount: productex.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20),
              itemBuilder: (context, index) => ItemCard(
                product: productex[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                              product: productex[index],
                            ))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
