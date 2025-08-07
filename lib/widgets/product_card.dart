import 'package:flutter/material.dart';
import 'package:flutter_shopify/services/shopify_service.dart';
import '../models/product.dart';
import '../screens/product_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        leading: product.imageUrl.isNotEmpty
            ? Image.network(product.imageUrl, width: 50, fit: BoxFit.cover)
            : const Icon(Icons.image_not_supported),
        title: Text(product.title, 
          style: TextStyle(
            fontSize: 20, // Tamaño del texto
            fontWeight: FontWeight.bold, // Peso/tipo de fuente
            color: Color(0xFF2196F3), // Color del texto
            fontFamily: 'Roboto', // Fuente (asegúrate de tenerla cargada)
          )),
        subtitle: Text('Precio: \$${product.price}'),
        trailing: IconButton(
          icon: const Icon(Icons.open_in_new),
          /*onPressed: () {
            final url = 'https://${ShopifyService.shopDomain}/products/${product.handle}';
            // Puedes usar url_launcher para abrir el enlace
            // launch(url);
          },*/
          onPressed: () async {
            final url = Uri.parse('https://${ShopifyService.shopDomain}/products/${product.handle}');
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
        ),
        // 👇 Navegación al detalle
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailPage(product: product),
            ),
          );
        },
      ),
    );
  }
}
