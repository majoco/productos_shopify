import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, style: TextStyle(
            fontSize: 20, // Tamaño del texto
            fontWeight: FontWeight.bold, // Peso/tipo de fuente
            color: Colors.white, // Color del texto
            fontFamily: 'Roboto', // Fuente (asegúrate de tenerla cargada)
          )),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrl.isNotEmpty)
              Center(
                child: Image.network(
                  product.imageUrl,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20, // Tamaño del texto
                fontWeight: FontWeight.bold, // Peso/tipo de fuente
                color: Color(0xFF2196F3), // Color del texto
                fontFamily: 'Roboto', // Fuente (asegúrate de tenerla cargada)
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Precio: \$${product.price}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 20),

            // Botón Agregar al carrito
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Agregar al carrito', style: TextStyle(
                  fontSize: 20, // Tamaño del texto
                  fontWeight: FontWeight.bold, // Peso/tipo de fuente
                  color: Colors.white, // Color del texto
                  fontFamily: 'Roboto', // Fuente (asegúrate de tenerla cargada)
                )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Producto agregado al carrito')),
                  );
                  // Aquí puedes llamar a tu lógica real de carrito
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
