import 'package:flutter/material.dart';
import 'assignment.dart';
import 'navigation_assignment.dart';
import 'api_assignment.dart';
import 'todo_assignment.dart';
import 'dart_basics_assignment.dart' as dart_basics;
import 'null_safe_async_assignment.dart' as async_assignment;
import 'profile_card_assignment.dart';
import 'responsive_dashboard_assignment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignments Collection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AssignmentLauncher(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AssignmentLauncher extends StatelessWidget {
  const AssignmentLauncher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Assignments Collection'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            const Text(
              'Complete Assignment Collection',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              '8 Comprehensive Flutter & Dart Assignments',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            // Assignment 1: Dart Basics Script
            _buildAssignmentCard(
              context: context,
              title: '1. Dart Basics Script',
              description: 'Console program with variables, loops, functions, and OOP (inheritance) modeling a library system',
              icon: Icons.code,
              color: Colors.deepOrange,
              onTap: () => _showDartBasicsDialog(context),
            ),
            
            const SizedBox(height: 16),
            
            // Assignment 2: Null-Safe Async Fetcher
            _buildAssignmentCard(
              context: context,
              title: '2. Null-Safe Async Fetcher',
              description: 'Dart program using null safety, Future, and async/await to fetch mock API data with error handling',
              icon: Icons.sync,
              color: Colors.teal,
              onTap: () => _showAsyncFetcherDialog(context),
            ),
            
            const SizedBox(height: 16),
            
            // Assignment 3: Profile Card UI
            _buildAssignmentCard(
              context: context,
              title: '3. Profile Card UI',
              description: 'Flutter profile card using Column, Row, Container, CircleAvatar, Text, and Icon widgets',
              icon: Icons.person,
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileCardApp()),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Assignment 4: Responsive Dashboard UI
            _buildAssignmentCard(
              context: context,
              title: '4. Responsive Dashboard UI',
              description: 'Multi-section dashboard using ListView, GridView, MediaQuery, and Flexible/Expanded',
              icon: Icons.dashboard,
              color: Colors.indigo,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResponsiveDashboardApp()),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Assignment 5: Todo List App
            _buildAssignmentCard(
              context: context,
              title: '5. Todo List App with State',
              description: 'Fully functional todo list using StatefulWidget and setState with CRUD operations',
              icon: Icons.checklist,
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodoApp()),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Assignment 6: Product Catalog
            _buildAssignmentCard(
              context: context,
              title: '6. Dynamic Product Catalog',
              description: 'Product listing with ListView.builder, search/filter functionality using setState',
              icon: Icons.shopping_cart,
              color: Colors.blue,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductListingPage()),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Assignment 7: Multi-Screen Navigation App
            _buildAssignmentCard(
              context: context,
              title: '7. Multi-Screen App with Forms',
              description: '3-screen app (Home, Form, Detail) using named routes with comprehensive form validation',
              icon: Icons.navigation,
              color: Colors.amber,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavigationApp()),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Assignment 8: API Data Fetcher
            _buildAssignmentCard(
              context: context,
              title: '8. API Data Fetcher with Cache',
              description: 'REST API integration with FutureBuilder and SharedPreferences caching',
              icon: Icons.cloud_download,
              color: Colors.red,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ApiApp()),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Summary Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[400]!, Colors.blue[600]!],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'All Assignments Completed!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'This comprehensive collection demonstrates Flutter & Dart mastery including UI components, navigation, state management, API integration, responsive design, async programming, OOP concepts, and best practices.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDartBasicsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dart Basics Assignment'),
        content: const Text(
          'This is a console-based Dart program that demonstrates:\n\n'
          '• Variables and data types\n'
          '• Loops and control structures\n'
          '• Functions with parameters\n'
          '• OOP with classes and inheritance\n'
          '• Library management system\n\n'
          'Run this in the Dart console to see the full output.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              dart_basics.main();
            },
            child: const Text('Run Console Demo'),
          ),
        ],
      ),
    );
  }

  void _showAsyncFetcherDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Null-Safe Async Fetcher'),
        content: const Text(
          'This demonstrates:\n\n'
          '• Null safety with nullable types\n'
          '• Future and async/await patterns\n'
          '• Error handling with try-catch\n'
          '• Stream operations\n'
          '• Mock API data fetching\n\n'
          'Run this to see async operations in action.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              async_assignment.main();
            },
            child: const Text('Run Async Demo'),
          ),
        ],
      ),
    );
  }
}