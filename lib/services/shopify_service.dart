import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ShopifyService {
  //static const String shopDomain = 'frank-dev-1.myshopify.com';
  static const String shopDomain = 'smg-test-frontend.myshopify.com';
  //static const String storefrontToken = '065229935565e672fdfbc9b257b282ea';
  static const String storefrontToken = '6d7572e370b1cf4a9f8c2dc2c66f1cd3';  

  static Future<List<Product>> fetchProducts() async {
    final url = Uri.https(shopDomain, '/api/2024-07/graphql.json');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',        
        'X-Shopify-Storefront-Access-Token': storefrontToken,
      },
      body: jsonEncode({
        'query': '''
        {
          products(first: 10) {
            edges {
              node {
                id
                title
                handle
                description
                images(first: 1) {
                  edges {
                    node {
                      url
                    }
                  }
                }
                variants(first: 1) {
                  edges {
                    node {
                      price {
                        amount
                      }
                    }
                  }
                }
              }
            }
          }
        }
        '''
      }),
    );
    

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final edges = data['data']['products']['edges'] as List;
      return edges.map((e) => Product.fromJson(e['node'])).toList();
    } else {
      throw Exception('Error al obtener productos: ${response.body}');
    }
  }
}
