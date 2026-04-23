import 'package:grabby_app/src/featurs/cart-checkout/data/models/cart_model.dart';

import '../../../../core/services/api_response.dart';

abstract class CartRepository {
  Future<ApiResponse<CartModel>> addToCart(AddToCartRequest request);
  Future<ApiResponse<List<CartModel>>> getCartSummary(String branchId);
  Future<ApiResponse<CartModel>> updateCartItem(String cartItemId, int quantity);
  Future<ApiResponse<void>> deleteCartItem(String cartItemId);
}
