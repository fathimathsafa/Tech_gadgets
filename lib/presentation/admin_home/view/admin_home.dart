import 'package:flutter/material.dart';
import 'package:tech_gadgets/presentation/registration_screen/operations/sql_operations.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Future<List<Map<String, dynamic>>> purchasedProducts = SQL_Functions.getPurchasedProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchased Products'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: purchasedProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No purchased products found'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.asset(
                    product['image'],
                    width: 50,
                    height: 50,
                  ),
                  title: Text(product['productName']),
                  subtitle: Text(product['description']),
                  trailing: Text(product['price']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
