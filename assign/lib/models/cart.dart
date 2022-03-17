import 'package:assign/screen/detail/components/body.dart';
import 'Product.dart';

class Cart {
  Product product;
  int numOfItem;

  //final CartCounter numofItem;

  Cart(
    this.product,
    this.numOfItem,
  );
}

// Demo data for our cart

List<Cart> demoCarts = [];
