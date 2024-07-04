import '../datamodel/item_model.dart';
import '../datamodel/discount_model.dart';

double calculatefinalPrice(List<ItemModel> items, List<DiscountModel> discounts, double points) {
  double subtotal = items.fold(0, (total, item) => total + item.price);
  double discountAmount = 0.0;

  List<DiscountModel> couponDiscounts =
      discounts.where((d) => d.type == DiscountType.Coupon).toList();
  List<DiscountModel> onTopDiscounts =
      discounts.where((d) => d.type == DiscountType.OnTop).toList();
  List<DiscountModel> seasonalDiscounts =
      discounts.where((d) => d.type == DiscountType.Seasonal).toList();

  Map<Category, DiscountModel> appliedDiscounts = {};

  void applyDiscounts(List<DiscountModel> discountList) {
    for (var discount in discountList) {
      if (!appliedDiscounts.containsKey(discount.category)) {
        if (discount.parameters == 'percentage') {
          discountAmount += subtotal * (discount.amount / 100);
        } else if (discount.parameters == 'amount' && discount.everyAmount != null) {
          discountAmount += (subtotal ~/ discount.everyAmount!) * discount.amount;
        } else {
          discountAmount += discount.amount;
        }
        appliedDiscounts[discount.category] = discount;
      }
    }
  }

  applyDiscounts(couponDiscounts);
  applyDiscounts(onTopDiscounts);
  applyDiscounts(seasonalDiscounts);

  return subtotal - discountAmount - points;
}