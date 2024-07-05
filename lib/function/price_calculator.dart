import '../datamodel/item_model.dart';
import '../datamodel/discount_model.dart';

double calculatefinalPrice(
    List<ItemModel> items, List<DiscountModel> discounts, double points) {
  double subtotal = items.fold(0, (total, item) => total + item.price);
  double discountAmount =
      0.0; // Initialize discount amount use to calculat all total price
  double finalPrice = 0;

  // Calculate subtotal by category
  Map<ItemCategory, double> subtotalByCategory = {};
  for (var item in items) {
    if (!subtotalByCategory.containsKey(item.category)) {
      subtotalByCategory[item.category] = 0.0;
    }
    subtotalByCategory[item.category] =
        subtotalByCategory[item.category]! + item.price;
  }
  print(subtotalByCategory);
  // Apply coupons first
  for (var discount in discounts.where((d) => d.type == DiscountType.Coupon)) {
    if (discount.category == Category.All) {
      // Apply coupon to all categories
      for (var category in subtotalByCategory.keys) {
        if (discount.parameters == 'percentage') {
          double categoryDiscount =
              subtotalByCategory[category]! * (discount.amount / 100);
          discountAmount += categoryDiscount;
          subtotalByCategory[category] =
              subtotalByCategory[category]! - categoryDiscount;
        } else if (discount.parameters == 'amount' &&
            discount.everyAmount != null) {
          double categoryDiscount =
              (subtotalByCategory[category]! ~/ discount.everyAmount!) *
                  discount.amount;
          discountAmount += categoryDiscount;
          subtotalByCategory[category] =
              subtotalByCategory[category]! - categoryDiscount;
        } else {
          double categoryDiscount = (discount.amount / items.length) *
              items.where((item) => item.category == category).length;
          discountAmount += categoryDiscount;
          subtotalByCategory[category] =
              subtotalByCategory[category]! - categoryDiscount;
        }
      }
    } else {
      // Apply coupon to specific category
      ItemCategory? itemCategory = discount.category.toItemCategory();
      if (itemCategory != null &&
          subtotalByCategory.containsKey(itemCategory)) {
        double categorySubtotal = subtotalByCategory[itemCategory]!;

        //check by discount type percentage, special or amount
        if (discount.parameters == 'percentage') {
          double categoryDiscount = categorySubtotal * (discount.amount / 100);
          discountAmount += categoryDiscount;
          subtotalByCategory[itemCategory] =
              categorySubtotal - categoryDiscount;
        } else if (discount.parameters == 'amount' &&
            discount.everyAmount != null) {
          double categoryDiscount =
              (categorySubtotal ~/ discount.everyAmount!) * discount.amount;
          discountAmount += categoryDiscount;
          subtotalByCategory[itemCategory] =
              categorySubtotal - categoryDiscount;
        } else {
          //fix amount case
          double categoryDiscount = discount.amount;
          discountAmount += categoryDiscount;
          subtotalByCategory[itemCategory] =
              categorySubtotal - categoryDiscount;
        }
      }
    }
  }
  print('after coupon:' + subtotalByCategory.toString());

  // Apply on top discounts next
  // double remainingSubtotalAfterCoupons = subtotal - discountAmount;
  for (var discount in discounts.where((d) => d.type == DiscountType.OnTop)) {
    if (discount.category == Category.All) {
      // Apply coupon to all categories
      for (var category in subtotalByCategory.keys) {
        if (discount.parameters == 'percentage') {
          double categoryDiscount =
              subtotalByCategory[category]! * (discount.amount / 100);
          discountAmount += categoryDiscount;
          subtotalByCategory[category] =
              subtotalByCategory[category]! - categoryDiscount;
        } else if (discount.parameters == 'amount' &&
            discount.everyAmount != null) {
          double categoryDiscount =
              (subtotalByCategory[category]! ~/ discount.everyAmount!) *
                  discount.amount;
          discountAmount += categoryDiscount;
          subtotalByCategory[category] =
              subtotalByCategory[category]! - categoryDiscount;
        } else {
          //fix amount case
          double categoryDiscount = (discount.amount / items.length) *
              items.where((item) => item.category == category).length;
          discountAmount += categoryDiscount;
          subtotalByCategory[category] =
              subtotalByCategory[category]! - categoryDiscount;
        }
      }
    } else {
      // Apply coupon to specific category
      ItemCategory? itemCategory = discount.category.toItemCategory();
      if (itemCategory != null &&
          subtotalByCategory.containsKey(itemCategory)) {
        double categorySubtotal = subtotalByCategory[itemCategory]!;

        if (discount.parameters == 'percentage') {
          double categoryDiscount = categorySubtotal * (discount.amount / 100);
          discountAmount += categoryDiscount;
          subtotalByCategory[itemCategory] =
              categorySubtotal - categoryDiscount;
        } else if (discount.parameters == 'amount' &&
            discount.everyAmount != null) {
          double categoryDiscount =
              (categorySubtotal ~/ discount.everyAmount!) * discount.amount;
          discountAmount += categoryDiscount;
          subtotalByCategory[itemCategory] =
              categorySubtotal - categoryDiscount;
        } else {
          double categoryDiscount = discount.amount;
          discountAmount += categoryDiscount;
          subtotalByCategory[itemCategory] =
              categorySubtotal - categoryDiscount;
        }
      }
    }
  }
  print('after ontop:' + subtotalByCategory.toString());

  // Apply seasonal discounts or points
  double remainingSubtotalAfterOnTop = subtotal - discountAmount;
  if (points > 0) {
    double maxPointsToUse = remainingSubtotalAfterOnTop * 0.2;
    double pointsToUse = points > maxPointsToUse ? maxPointsToUse : points;
    discountAmount += pointsToUse;
  } else {
    for (var discount
        in discounts.where((d) => d.type == DiscountType.Seasonal)) {
      double categorySubtotal = discount.category == Category.All
          ? remainingSubtotalAfterOnTop
          : subtotalByCategory[discount.category.toItemCategory()] ?? 0;

      if (discount.parameters == 'percentage') {
        discountAmount += categorySubtotal * (discount.amount / 100);
      } else if (discount.parameters == 'amount' &&
          discount.everyAmount != null) {
        discountAmount +=
            (categorySubtotal ~/ discount.everyAmount!) * discount.amount;
      } else {
        discountAmount += discount.amount;
      }
    }
  }
  print('after special:' + subtotalByCategory.toString());

  // Calculate final price
  finalPrice = subtotal - discountAmount;
  if (finalPrice < 0) {
    finalPrice = 0;
  }
  return finalPrice;
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
