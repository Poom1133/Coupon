import '../datamodel/item_model.dart';
import '../datamodel/discount_model.dart';

double calculatefinalPrice(
    List<ItemModel> items, List<DiscountModel> discounts, double points) {
  double subtotal = items.fold(0, (total, item) => total + item.price);
  double discountAmount = 0.0;

  // Calculate subtotal by category
  Map<ItemCategory, double> subtotalByCategory = {};
  for (var item in items) {
    if (!subtotalByCategory.containsKey(item.category)) {
      subtotalByCategory[item.category] = 0.0;
    }
    subtotalByCategory[item.category] =
        subtotalByCategory[item.category]! + item.price;
  }

  // Apply discounts
  List<DiscountModel> couponDiscounts =
      discounts.where((d) => d.type == DiscountType.Coupon).toList();
  List<DiscountModel> onTopDiscounts =
      discounts.where((d) => d.type == DiscountType.OnTop).toList();
  List<DiscountModel> seasonalDiscounts =
      discounts.where((d) => d.type == DiscountType.Seasonal).toList();

  Map<Category, DiscountModel> appliedDiscounts = {};

  void applyDiscounts(List<DiscountModel> discountList) {
    for (var discount in discountList) {
      double categorySubtotal = discount.category == Category.All
          ? subtotal
          : subtotalByCategory[discount.category.toItemCategory()] ?? 0;

      if (!appliedDiscounts.containsKey(discount.category) ||
          discount.category == Category.All) {
        if (discount.parameters == 'percentage') {
          discountAmount += categorySubtotal * (discount.amount / 100);
        } else if (discount.parameters == 'amount' && discount.everyAmount != null) {
          discountAmount +=
              (categorySubtotal ~/ discount.everyAmount!) * discount.amount;
        } else {
          discountAmount += discount.amount;
        }

        if (discount.category != Category.All) {
          appliedDiscounts[discount.category] = discount;
        }
      }
    }
  }

  applyDiscounts(couponDiscounts);
  applyDiscounts(onTopDiscounts);

  // Apply seasonal discounts or points
  if (points > 0) {
    // Calculate points use
    double pointstoUse = 0;
    double maxpointsToUse = subtotal * 0.2;
    if (points > maxpointsToUse) {
      pointstoUse = maxpointsToUse;
    } else {
      pointstoUse = points;
    }
    discountAmount += pointstoUse;
  } else {
    applyDiscounts(seasonalDiscounts);
  }

  return subtotal - discountAmount;
}

extension CategoryExtension on Category {
  ItemCategory? toItemCategory() {
    switch (this) {
      case Category.Clothing:
        return ItemCategory.Clothing;
      case Category.Accessories:
        return ItemCategory.Accessories;
      case Category.Electronics:
        return ItemCategory.Electronics;
      case Category.All:
      default:
        return null;
    }
  }
}
