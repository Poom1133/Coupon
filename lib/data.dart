import '../datamodel/discount_model.dart';
import '../datamodel/item_model.dart';



// Define Discount Models
DiscountModel fixedDiscount1 = DiscountModel(
  id: '1',
  type: DiscountType.Coupon,
  parameters: 'amount',
  amount: 150.0,
  max: null,
  category: Category.All,
  everyAmount: null,
  name: '150 THB off',
  description: '150 THB off on all items',
);

DiscountModel fixedDiscount2 = DiscountModel(
  id: '2',
  type: DiscountType.Coupon,
  parameters: 'percentage',
  amount: 10.0,
  max: null,
  category: Category.All,
  everyAmount: null,
  name: '10% off',
  description: '10% off on all items',
);

DiscountModel onTopDiscount1 = DiscountModel(
  id: '6',
  type: DiscountType.OnTop,
  parameters: 'percentage',
  amount: 5.0,
  max: null,
  category: Category.Clothing,
  everyAmount: null,
  name: '5% on top',
  description: '5% on top for clothing items',
);

DiscountModel onTopDiscount2 = DiscountModel(
  id: '7',
  type: DiscountType.OnTop,
  parameters: 'amount',
  amount: 20.0,
  max: null,
  category: Category.Electronics,
  everyAmount: null,
  name: '20 THB on top',
  description: '20 THB on top for electronics items',
);
DiscountModel onTopDiscount3 = DiscountModel(
  id: '7',
  type: DiscountType.OnTop,
  parameters: 'amount',
  amount: 50.0,
  max: null,
  category: Category.Clothing,
  everyAmount: null,
  name: '50 THB on top',
  description: '50 THB on top for clothing items',
);
DiscountModel onTopDiscount4 = DiscountModel(
  id: '6',
  type: DiscountType.OnTop,
  parameters: 'percentage',
  amount: 100.0,
  max: null,
  category: Category.All,
  everyAmount: null,
  name: '100% on top',
  description: 'This is super deal',
);
DiscountModel onTopDiscount5 = DiscountModel(
  id: '6',
  type: DiscountType.OnTop,
  parameters: 'percentage',
  amount: 10.0,
  max: null,
  category: Category.All,
  everyAmount: null,
  name: '10% on top',
  description: '10% on top for all items',
);

DiscountModel seasonalDiscount = DiscountModel(
  id: '8',
  type: DiscountType.Seasonal,
  parameters: 'amount',
  amount: 10.0,
  max: null,
  category: Category.All,
  everyAmount: 100.0,
  name: '10 THB every 100 THB',
  description: '10 THB off for every 100 THB on all items',
);

// List of Discount Models
final List<DiscountModel> discounts = [
  fixedDiscount1,
  fixedDiscount2,
  onTopDiscount1,
  onTopDiscount2,
  onTopDiscount3,
  onTopDiscount5,
  onTopDiscount4,
  seasonalDiscount,
];

// Define Item Models
ItemModel item1 = ItemModel(
  id: '1',
  name: 'T-Shirt',
  price: 200.0,
  category: ItemCategory.Clothing,
);

ItemModel item2 = ItemModel(
  id: '2',
  name: 'Jeans',
  price: 200.0,
  category: ItemCategory.Clothing,
);

ItemModel item3 = ItemModel(
  id: '3',
  name: 'Watch',
  price: 200.0,
  category: ItemCategory.Accessories,
);

ItemModel item4 = ItemModel(
  id: '4',
  name: 'Headphones',
  price: 200.0,
  category: ItemCategory.Electronics,
);

ItemModel item5 = ItemModel(
  id: '5',
  name: 'Sneakers',
  price: 200.0,
  category: ItemCategory.Clothing,
);

// List of Item Models
final List<ItemModel> items = [
  item1,
  item2,
  item3,
  item4,
  item5,
];
