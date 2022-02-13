import 'package:assign/screen/detail/components/body.dart';
import 'Product.dart';

class Cart {
  final Product product;
  //final int numOfItem;
  final CartCounter numofItem;

  Cart(
    this.product,
    this.numofItem,
  );
}

// Demo data for our cart

List<Cart> demoCarts = [];
