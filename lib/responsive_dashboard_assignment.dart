// Assignment 4: Responsive Dashboard UI
// Create a responsive multi-section dashboard using ListView, GridView, MediaQuery, and Flexible/Expanded that adapts to screen size.

import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveDashboardApp());
}

class ResponsiveDashboardApp extends StatelessWidget {
  const ResponsiveDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildSideNavigation(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if we should show desktop layout
          bool isDesktop = constraints.maxWidth >= 1200;
          bool isTablet = constraints.maxWidth >= 768 && constraints.maxWidth < 1200;
          bool isMobile = constraints.maxWidth < 768;

          if (isDesktop) {
            return _buildDesktopLayout(context);
          } else if (isTablet) {
            return _buildTabletLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 768
          ? _buildBottomNavigation()
          : null,
    );
  }

  // Desktop Layout (≥1200px)
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Side Navigation
        Container(
          width: 280,
          child: _buildSideNavigation(context),
        ),
        // Main Content
        Expanded(
          child: Column(
            children: [
              _buildTopAppBar(context, showMenuButton: false),
              Expanded(
                child: _buildMainContent(context, isDesktop: true),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Tablet Layout (768px-1199px)
  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        _buildTopAppBar(context, showMenuButton: true),
        Expanded(
          child: _buildMainContent(context, isDesktop: false),
        ),
      ],
    );
  }

  // Mobile Layout (<768px)
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildTopAppBar(context, showMenuButton: true),
        Expanded(
          child: _buildMainContent(context, isDesktop: false),
        ),
      ],
    );
  }

  Widget _buildTopAppBar(BuildContext context, {required bool showMenuButton}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showMenuButton)
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          Expanded(
            child: Row(
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                // Search Bar
                if (MediaQuery.of(context).size.width >= 600)
                  Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search, size: 20),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                const SizedBox(width: 16),
                // Notifications
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                ),
                // Profile
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&crop=face',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideNavigation(BuildContext context) {
    bool isDrawer = MediaQuery.of(context).size.width < 1200;
    
    Widget content = Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo/Title
          if (!isDrawer) const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Navigation Items
          _buildNavItem(Icons.dashboard_outlined, 'Overview', 0),
          _buildNavItem(Icons.analytics_outlined, 'Analytics', 1),
          _buildNavItem(Icons.people_outline, 'Users', 2),
          _buildNavItem(Icons.shopping_bag_outlined, 'Products', 3),
          _buildNavItem(Icons.payment_outlined, 'Sales', 4),
          _buildNavItem(Icons.settings_outlined, 'Settings', 5),
          
          const Spacer(),
          
          // User Profile Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&crop=face',
                  ),
                ),
                if (!isDrawer || MediaQuery.of(context).size.width > 300) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Administrator',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    if (isDrawer) {
      return Drawer(child: content);
    } else {
      return content;
    }
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        if (MediaQuery.of(context).size.width < 1200) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[800],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, {required bool isDesktop}) {
    return Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatsCards(context, isDesktop: isDesktop),
            const SizedBox(height: 24),
            _buildChartsSection(context, isDesktop: isDesktop),
            const SizedBox(height: 24),
            _buildDataTablesSection(context, isDesktop: isDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context, {required bool isDesktop}) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;
    double childAspectRatio;
    
    if (screenWidth >= 1200) {
      crossAxisCount = 4;
      childAspectRatio = 1.3;
    } else if (screenWidth >= 768) {
      crossAxisCount = 2;
      childAspectRatio = 1.5;
    } else {
      crossAxisCount = 2;
      childAspectRatio = 1.2;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        List<Map<String, dynamic>> stats = [
          {
            'title': 'Total Revenue',
            'value': '\$24,500',
            'change': '+12.5%',
            'icon': Icons.attach_money,
            'color': Colors.green,
            'isPositive': true,
          },
          {
            'title': 'Active Users',
            'value': '1,429',
            'change': '+5.2%',
            'icon': Icons.people,
            'color': Colors.blue,
            'isPositive': true,
          },
          {
            'title': 'Orders',
            'value': '342',
            'change': '-2.1%',
            'icon': Icons.shopping_cart,
            'color': Colors.orange,
            'isPositive': false,
          },
          {
            'title': 'Conversion',
            'value': '3.24%',
            'change': '+0.8%',
            'icon': Icons.trending_up,
            'color': Colors.purple,
            'isPositive': true,
          },
        ];

        var stat = stats[index];
        return _buildStatCard(stat);
      },
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                stat['icon'],
                color: stat['color'],
                size: 24,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: stat['isPositive'] 
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  stat['change'],
                  style: TextStyle(
                    color: stat['isPositive'] ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            stat['value'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat['title'],
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection(BuildContext context, {required bool isDesktop}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool shouldStack = constraints.maxWidth < 768;
        
        if (shouldStack) {
          return Column(
            children: [
              _buildRevenueChart(),
              const SizedBox(height: 16),
              _buildUserActivityChart(),
            ],
          );
        } else {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildRevenueChart(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildUserActivityChart(),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bar_chart,
                      size: 48,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Revenue Chart',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserActivityChart() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                List<Map<String, dynamic>> activities = [
                  {'label': 'Page Views', 'value': 1250, 'color': Colors.blue},
                  {'label': 'Sessions', 'value': 890, 'color': Colors.green},
                  {'label': 'Bounce Rate', 'value': 45, 'color': Colors.orange},
                  {'label': 'New Users', 'value': 234, 'color': Colors.purple},
                  {'label': 'Returning', 'value': 656, 'color': Colors.red},
                ];

                var activity = activities[index];
                double percentage = (activity['value'] / 1500) * 100;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            activity['label'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            activity['value'].toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(activity['color']),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTablesSection(BuildContext context, {required bool isDesktop}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool shouldStack = constraints.maxWidth < 1000;
        
        if (shouldStack) {
          return Column(
            children: [
              _buildRecentOrdersTable(),
              const SizedBox(height: 16),
              _buildTopProductsTable(),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildRecentOrdersTable(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTopProductsTable(),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildRecentOrdersTable() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Order ID')),
                DataColumn(label: Text('Customer')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Date')),
              ],
              rows: [
                _buildOrderRow('#1234', 'John Smith', '\$299.00', 'Completed', '2024-01-15'),
                _buildOrderRow('#1235', 'Jane Doe', '\$159.50', 'Pending', '2024-01-15'),
                _buildOrderRow('#1236', 'Bob Johnson', '\$89.99', 'Shipped', '2024-01-14'),
                _buildOrderRow('#1237', 'Alice Brown', '\$449.00', 'Completed', '2024-01-14'),
                _buildOrderRow('#1238', 'Charlie Davis', '\$199.99', 'Processing', '2024-01-13'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildOrderRow(String id, String customer, String amount, String status, String date) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'shipped':
        statusColor = Colors.blue;
        break;
      case 'processing':
        statusColor = Colors.purple;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(customer)),
        DataCell(Text(amount)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DataCell(Text(date)),
      ],
    );
  }

  Widget _buildTopProductsTable() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Products',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              List<Map<String, dynamic>> products = [
                {'name': 'iPhone 15 Pro', 'sales': 1250, 'revenue': '\$1,499,750'},
                {'name': 'MacBook Air M3', 'sales': 890, 'revenue': '\$1,068,900'},
                {'name': 'AirPods Pro', 'sales': 1560, 'revenue': '\$389,000'},
                {'name': 'iPad Air', 'sales': 670, 'revenue': '\$401,200'},
                {'name': 'Apple Watch', 'sales': 980, 'revenue': '\$392,000'},
              ];

              var product = products[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.phone_iphone,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${product['sales']} sold',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      product['revenue'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Overview',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Users',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}