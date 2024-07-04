import 'package:flutter/material.dart';
import 'package:playtorium_test/data.dart';
import '../function/price_calculator.dart';
import '../datamodel/discount_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double points = 1000;
  double finalPrice = 0;
  double totalPrice = 0;
  bool _usepoints = false;
  List<DiscountModel> usedDiscounts = [];
  final TextEditingController pointsController = TextEditingController();

  @override
  void dispose() {
    pointsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pointsController.text = points.toString();
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

  void addCoupon(DiscountModel discount) {
    setState(() {
      usedDiscounts.removeWhere((d) => d.type == discount.type);
      usedDiscounts.add(discount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playtorium Test',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              50, 20, 50, 20),
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
                  ...items.map((item) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.name, style: const TextStyle(fontSize: 16)),
                          Text(item.price.toStringAsFixed(2),
                              style: const TextStyle(fontSize: 16)),
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
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent[100],
                    ),
                    child: const Text(' Coupon ',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  ...discounts
                      .where((d) => d.type == DiscountType.Coupon)
                      .map((d) => Card(
                            child: ListTile(
                              title: Text(d.name!),
                              subtitle: Text(d.description!),
                              onTap: () {
                                addCoupon(d);
                                calculateFinalPrice();
                              },
                            ),
                          )),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent[100],
                    ),
                    child: const Text(' On Top Coupon ',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  ...discounts
                      .where((d) => d.type == DiscountType.OnTop)
                      .map((d) => Card(
                            child: ListTile(
                              title: Text(d.name!),
                              subtitle: Text(d.description!),
                              onTap: () {
                                addCoupon(d);
                                calculateFinalPrice();
                              },
                            ),
                          )),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent[100],
                    ),
                    child: const Text(' Special Coupon ',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  ...discounts
                      .where((d) => d.type == DiscountType.Seasonal)
                      .map((d) => Card(
                            child: ListTile(
                              title: Text(d.name!),
                              subtitle: Text(d.description!),
                              onTap: () {
                                _usepoints = false;
                                addCoupon(d);
                                calculateFinalPrice();
                              },
                            ),
                          )),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Change Points'),
                        content: TextField(
                          controller: pointsController,
                          keyboardType: TextInputType.number,
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                points = double.parse(pointsController.text);
                              });
                              calculateFinalPrice();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Points: ${points.toString()}',
                    style: const TextStyle(fontSize: 20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Use Points:', style: TextStyle(fontSize: 20)),
                  Switch(
                    value: _usepoints,
                    onChanged: (value) {
                      setState(() {
                        _usepoints = value;
                        usedDiscounts.removeWhere(
                            (d) => d.type == DiscountType.Seasonal);
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
                          TextSpan(
                            text: totalPrice.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          TextSpan(
                            text: '   ${finalPrice.toStringAsFixed(2)}',
                          ),
                        ],
                        style: const TextStyle(fontSize: 20)),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          usedDiscounts.clear();
                          calculateFinalPrice();
                        });
                      },
                      child: const Text('remove coupon')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
