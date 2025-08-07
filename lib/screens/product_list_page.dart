import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/shopify_service.dart';
import '../widgets/product_card.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 4,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo_shop.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'Tienda Shopify',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
        ),
      ),

      // 👇 Aquí usamos Column
      body: Column(
        children: [
          // Primer elemento: un banner o texto superior
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.orange.shade100,
            child: Row(
              children: [
                Image.asset(
                  'assets/shopify-icon.png',
                  fit: BoxFit.cover,
                  width: 40,
                ),                
                SizedBox(width: 20), // Espacio entre elementos
                const Text(
                  'Listado de Productos',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Segundo elemento: la lista de productos
          Expanded( // 👈 Muy importante para que la lista ocupe el resto del espacio
            child: FutureBuilder<List<Product>>(
              future: ShopifyService.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      ProductCard(product: products[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
