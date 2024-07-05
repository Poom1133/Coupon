# Poomrapee Chaiprasop
  test set2

# Feature
- calculate final price
- use coupon by category
- use multiple coupon
- use point

# Additional Feature
- you can change the amount of points by click at the points number, 
it will show the popup to config.
- remove used coupon

# Guide
- open the application file
- select the json data file (example 'data.json' in root project)
- select the discount campaign and See how it work!!!
  
  **JSON files have rules for each variable. Please follow the rules in the data model; otherwise, the data will not be imported.
  
# Price calculate 
  Coupon > On Top > Seasonal/Point
  ```
  final price = total - coupon > total_remain - ontop > total_remain - Seasonal/Point
  ```
# Data model
for data model I use in the project, you can see json form in data.json
## Discount
```dart
class DiscountModel {
  final String id;
  final DiscountType type; // Coupon, OnTop, Seasonal
  final String parameters; // Either "amount" or "percentage"
  final double amount;
  final double? max;  //to implement in the future
  final Category category;
  final double? everyAmount; // Nullable, used for Seasonal type
  final String? name;
  final String? description;
}
```


## items
```dart
class ItemModel {
  final String id;
  final String name;
  final double price;
  final ItemCategory category; //Clothing, Accessories, Electronics
}
```



## Test Cases

| No.       | Case                                           | Total Price | Total by Category                           | Discount Applied                                           | Discount Amount | Final Price |
|-----------|------------------------------------------------|-------------|---------------------------------------------|------------------------------------------------------------|-----------------|-------------|
| 1         | All                                            | 1000.0      | 1000.0 | None                                                                                         | 0.0             | 1000.0      |
| 2         | All, Coupon                                    | 1000.0      | 1000.0 | 150 THB off on all items                                                                     | 150.0           | 850.0      |
| 2         | All, Coupon                                    | 1000.0      | 1000.0 | 10% off on all items                                                                         | 100.0           | 900.0      |
| 3         | All, Coupon, On-top                             | 1000.0      | Clothing: 600.0 | 10% off + 5% on top clothing                                                            | 127.0 (100.0 + 27.0)          | 873.0      |
| 4         | All, Coupon, On-top, Seasonal                   | 1000.0      | Clothing: 600.0 | 10% off + 5% on top clothing + 10 THB every 100 THB              |    207.0 (100.0 + 27.0 + 80)       |    793.0         |
| 5         | All, Coupon, On-top, Points                     | 1000.0      | Clothing: 600.0 | 10% off + 5% on top clothing + Use max Points(20% of total price)|    301.6      (100.0 + 27.0 + 174.6)     |      698.4       |
| 6         | All, On-top                             | 1000.0      | Clothing: 600.0 | 5% off on clothing                                        |          30.0     |         970.0    |
| 7         | All, Points            | 1000.0      | 1000.0                                       | Use max Points(20% of total price)                            |       200.0        |      800.0       |
| 8         | All, On-top  | 1000.0      | electronic: 200                                       | 20 THB off     |             20.0  |          980.0   |
| 9         | All, On-top, Points    | 1000.0      | electronic: 200                                       | 20 THB off + Use max Points(20% of total price)|   216.0 (20.0 + 196.0)      |        784.0     |
| 10        | All items                                      | 1000.0      | 1000.0                                              | 100% off coupon                                            | 1000.0          | 0.0         |

