import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow_tech/ui/control_screen.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<void> _fetchOrders;

  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<OrdersManager>().fetchOrders();
  }

  final ordersManager = OrdersManager();

  @override
  Widget build(BuildContext context) {
    ChangeNotifierProvider(create: (context) => AuthManager());
    return Consumer<AuthManager>(builder: (context, authManager, child) {
      return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                authManager.isAuth ? 'Your Orders' : 'You Have To Log In',
                style: const TextStyle(
                  fontFamily: 'SFCompactRounded',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: Container(
            child: authManager.isAuth
                ? Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Consumer<OrdersManager>(
                            builder: (context, ordersManager, child) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: ordersManager.orderCount,
                                itemBuilder: (ctx, i) {
                                  if (authManager.authToken!.email ==
                                      ordersManager.items[i].email) {
                                    return OrderItemCard(
                                        ordersManager.items[i]);
                                  } else if (authManager.authToken!.email ==
                                          'admin@gmail.com' ||
                                      authManager.authToken!.email ==
                                          'panow@gmail.com') {
                                    return OrderItemCard(
                                        ordersManager.items[i]);
                                  }
                                  return Container();
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  )
                : AuthScreen(),
          ));
    });
  }
}
