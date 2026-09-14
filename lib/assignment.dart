import 'package:flutter/material.dart';

// Product data model class
class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({Key? key}) : super(key: key);

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  // List of all products
  List<Product> allProducts = [
    Product(
      id: 1,
      name: "iPhone 15 Pro",
      category: "Electronics",
      price: 999.99,
      imageUrl: "https://via.placeholder.com/150x150/007bff/ffffff?text=iPhone",
      description: "Latest iPhone with advanced camera system",
    ),
    Product(
      id: 2,
      name: "Samsung Galaxy S24",
      category: "Electronics",
      price: 899.99,
      imageUrl: "https://via.placeholder.com/150x150/28a745/ffffff?text=Samsung",
      description: "Flagship Android phone with AI features",
    ),
    Product(
      id: 3,
      name: "MacBook Air M3",
      category: "Laptops",
      price: 1299.99,
      imageUrl: "https://via.placeholder.com/150x150/6c757d/ffffff?text=MacBook",
      description: "Lightweight laptop with M3 chip",
    ),
    Product(
      id: 4,
      name: "Nike Air Max",
      category: "Shoes",
      price: 129.99,
      imageUrl: "https://via.placeholder.com/150x150/dc3545/ffffff?text=Nike",
      description: "Comfortable running shoes",
    ),
    Product(
      id: 5,
      name: "Sony WH-1000XM5",
      category: "Electronics",
      price: 349.99,
      imageUrl: "https://via.placeholder.com/150x150/ffc107/ffffff?text=Sony",
      description: "Noise cancelling wireless headphones",
    ),
    Product(
      id: 6,
      name: "Adidas Ultraboost",
      category: "Shoes",
      price: 179.99,
      imageUrl: "https://via.placeholder.com/150x150/17a2b8/ffffff?text=Adidas",
      description: "Premium running shoes with boost technology",
    ),
    Product(
      id: 7,
      name: "Dell XPS 13",
      category: "Laptops",
      price: 999.99,
      imageUrl: "https://via.placeholder.com/150x150/6f42c1/ffffff?text=Dell",
      description: "Compact ultrabook for professionals",
    ),
    Product(
      id: 8,
      name: "Apple Watch Series 9",
      category: "Electronics",
      price: 399.99,
      imageUrl: "https://via.placeholder.com/150x150/fd7e14/ffffff?text=Watch",
      description: "Smart watch with health monitoring",
    ),
  ];

  // Filtered products list
  List<Product> filteredProducts = [];
  
  // Search controller
  TextEditingController searchController = TextEditingController();
  
  // Selected category filter
  String selectedCategory = "All";
  
  // Available categories
  List<String> categories = ["All", "Electronics", "Laptops", "Shoes"];

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts; // Initially show all products
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Handle search text changes
  void _onSearchChanged() {
    _filterProducts();
  }

  // Filter products based on search text and category
  void _filterProducts() {
    setState(() {
      filteredProducts = allProducts.where((product) {
        // Check search text
        bool matchesSearch = product.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()) ||
            product.description
                .toLowerCase()
                .contains(searchController.text.toLowerCase());
        
        // Check category filter
        bool matchesCategory = selectedCategory == "All" || 
            product.category == selectedCategory;
        
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  // Handle category filter change
  void _onCategoryChanged(String? newCategory) {
    if (newCategory != null) {
      setState(() {
        selectedCategory = newCategory;
      });
      _filterProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Listing'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[100],
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                // Category Filter
                Row(
                  children: [
                    const Text(
                      'Category: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        isExpanded: true,
                        onChanged: _onCategoryChanged,
                        items: categories.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Results Count
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blue[50],
            child: Text(
              'Found ${filteredProducts.length} products',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          // Product List
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Try adjusting your search or filter',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredProducts.length,
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCard(product: product);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
            ),
          ),
        ),
        title: Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              product.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    product.category,
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          // Show product details
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(product.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Category: ${product.category}'),
                  const SizedBox(height: 8),
                  Text('Price: \$${product.price.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  Text('Description: ${product.description}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Main function to run the app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Listing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductListingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}