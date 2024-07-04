import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:playtorium_test/data.dart';
import '../function/price_calculator.dart';
// import '../datamodel/item_model.dart';
import '../datamodel/discount_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double points = 200;
  double finalPrice = 0;
  double totalPrice = 0;
  bool _usepoints = false;
  List<DiscountModel> usedDiscounts = [];
  TextEditingController pointsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    calculateFinalPrice();
    calculateTotalprice();
  }

  void calculateTotalprice() {
    double subtotal = items.fold(0, (total, item) => total + item.price);
    setState(() {
      totalPrice = subtotal;
    });
  }

  void calculateFinalPrice() {
    setState(() {
      finalPrice =
          calculatefinalPrice(items, usedDiscounts, _usepoints ? points : 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playtorium Test'),
        backgroundColor: Color.fromARGB(255, 250, 103, 135),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              50, 20, 50, 20), // top, top, right, bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Cart',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  ...items.map((item) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(item.name),
                          Text(item.price.toStringAsFixed(2)),
                        ],
                      )),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Coupons',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Coupon'),
                  ...discounts
                      .where((d) => d.type == DiscountType.Coupon)
                      .map((d) => Card(
                            child: ListTile(
                              title: Text(d.name!),
                              subtitle: Text(d.description!),
                              onTap: () {},
                            ),
                          )),
                  const SizedBox(height: 10),
                  const Text('On-Top Coupon'),
                  ...discounts
                      .where((d) => d.type == DiscountType.OnTop)
                      .map((d) => Card(
                            child: ListTile(
                              title: Text(d.name!),
                              subtitle: Text(d.description!),
                              onTap: () {},
                            ),
                          )),
                  const SizedBox(height: 10),
                  const Text('Seasonal Coupon'),
                  ...discounts
                      .where((d) => d.type == DiscountType.Seasonal)
                      .map((d) => Card(
                            child: ListTile(
                              title: Text(d.name!),
                              subtitle: Text(d.description!),
                              onTap: () {},
                            ),
                          )),
                ],
              ),
              const SizedBox(height: 20),
              Text('Points: ${points.toString()}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Use Points:'),
                  Switch(
                    value: _usepoints,
                    onChanged: (value) {
                      setState(() {
                        _usepoints = value;
                        calculateFinalPrice();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                        text: 'Total:  ',
                        children: <TextSpan>[
                          new TextSpan(
                            text: totalPrice.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          new TextSpan(
                            text: '   ${finalPrice.toStringAsFixed(2)}',
                          ),
                        ],
                        style: const TextStyle(fontSize: 20)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
