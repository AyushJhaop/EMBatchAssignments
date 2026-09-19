import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Assignment: REST API with FutureBuilder and SharedPreferences Caching

void main() {
  runApp(const ApiApp());
}

class ApiApp extends StatelessWidget {
  const ApiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Assignment',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const ApiScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Post Model for JSONPlaceholder API
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}

// User Model for JSONPlaceholder API
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
    };
  }
}

// API Service Class
class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsKey = 'cached_posts';
  static const String usersKey = 'cached_users';
  static const String lastFetchKey = 'last_fetch_time';

  // Fetch Posts with Caching
  static Future<List<Post>> fetchPosts() async {
    try {
      // Try to get cached data first
      final cachedPosts = await getCachedPosts();
      final lastFetchTime = await getLastFetchTime();
      final now = DateTime.now().millisecondsSinceEpoch;
      
      // If we have cached data and it's less than 5 minutes old, use it
      if (cachedPosts.isNotEmpty && 
          lastFetchTime != null && 
          (now - lastFetchTime) < 300000) { // 5 minutes
        print('Using cached posts data');
        return cachedPosts;
      }

      print('Fetching fresh posts data from API');
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final posts = jsonData.map((json) => Post.fromJson(json)).toList();
        
        // Cache the data
        await cachePosts(posts);
        await setLastFetchTime(now);
        
        return posts;
      } else {
        // If API fails, return cached data if available
        if (cachedPosts.isNotEmpty) {
          print('API failed, using cached posts data');
          return cachedPosts;
        }
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      // If everything fails, try to return cached data
      final cachedPosts = await getCachedPosts();
      if (cachedPosts.isNotEmpty) {
        print('Error occurred, using cached posts data: $e');
        return cachedPosts;
      }
      throw Exception('Failed to load posts: $e');
    }
  }

  // Fetch Users with Caching
  static Future<List<User>> fetchUsers() async {
    try {
      final cachedUsers = await getCachedUsers();
      final lastFetchTime = await getLastFetchTime();
      final now = DateTime.now().millisecondsSinceEpoch;
      
      if (cachedUsers.isNotEmpty && 
          lastFetchTime != null && 
          (now - lastFetchTime) < 300000) {
        print('Using cached users data');
        return cachedUsers;
      }

      print('Fetching fresh users data from API');
      final response = await http.get(Uri.parse('$baseUrl/users'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final users = jsonData.map((json) => User.fromJson(json)).toList();
        
        await cacheUsers(users);
        await setLastFetchTime(now);
        
        return users;
      } else {
        if (cachedUsers.isNotEmpty) {
          print('API failed, using cached users data');
          return cachedUsers;
        }
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      final cachedUsers = await getCachedUsers();
      if (cachedUsers.isNotEmpty) {
        print('Error occurred, using cached users data: $e');
        return cachedUsers;
      }
      throw Exception('Failed to load users: $e');
    }
  }

  // Cache Posts
  static Future<void> cachePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = posts.map((post) => post.toJson()).toList();
    await prefs.setString(postsKey, json.encode(postsJson));
  }

  // Get Cached Posts
  static Future<List<Post>> getCachedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(postsKey);
    if (cachedData != null) {
      final List<dynamic> jsonData = json.decode(cachedData);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    }
    return [];
  }

  // Cache Users
  static Future<void> cacheUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((user) => user.toJson()).toList();
    await prefs.setString(usersKey, json.encode(usersJson));
  }

  // Get Cached Users
  static Future<List<User>> getCachedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(usersKey);
    if (cachedData != null) {
      final List<dynamic> jsonData = json.decode(cachedData);
      return jsonData.map((json) => User.fromJson(json)).toList();
    }
    return [];
  }

  // Set Last Fetch Time
  static Future<void> setLastFetchTime(int timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastFetchKey, timestamp);
  }

  // Get Last Fetch Time
  static Future<int?> getLastFetchTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(lastFetchKey);
  }

  // Clear Cache
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(postsKey);
    await prefs.remove(usersKey);
    await prefs.remove(lastFetchKey);
  }
}

// Main API Screen
class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Post>> _postsFuture;
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _refreshData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _refreshData() {
    setState(() {
      _postsFuture = ApiService.fetchPosts();
      _usersFuture = ApiService.fetchUsers();
    });
  }

  void _clearCache() async {
    await ApiService.clearCache();
    _refreshData();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cache cleared successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Assignment'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.article), text: 'Posts'),
            Tab(icon: Icon(Icons.people), text: 'Users'),
          ],
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
        actions: [
          IconButton(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Data',
          ),
          IconButton(
            onPressed: _clearCache,
            icon: const Icon(Icons.clear),
            tooltip: 'Clear Cache',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsTab(),
          _buildUsersTab(),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    return FutureBuilder<List<Post>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        return _buildDataWidget<Post>(
          snapshot: snapshot,
          emptyMessage: 'No posts available',
          itemBuilder: (post) => PostCard(post: post),
        );
      },
    );
  }

  Widget _buildUsersTab() {
    return FutureBuilder<List<User>>(
      future: _usersFuture,
      builder: (context, snapshot) {
        return _buildDataWidget<User>(
          snapshot: snapshot,
          emptyMessage: 'No users available',
          itemBuilder: (user) => UserCard(user: user),
        );
      },
    );
  }

  Widget _buildDataWidget<T>({
    required AsyncSnapshot<List<T>> snapshot,
    required String emptyMessage,
    required Widget Function(T) itemBuilder,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading data...'),
          ],
        ),
      );
    } else if (snapshot.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _refreshData,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inbox,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(emptyMessage),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshData,
              child: const Text('Refresh'),
            ),
          ],
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          _refreshData();
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return itemBuilder(snapshot.data![index]);
          },
        ),
      );
    }
  }
}

// Post Card Widget
class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Text(
            post.id.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          post.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              post.body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  'User ${post.userId}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          _showPostDetail(context);
        },
      ),
    );
  }

  void _showPostDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Post ${post.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Title:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(post.title),
              const SizedBox(height: 16),
              Text(
                'Content:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(post.body),
              const SizedBox(height: 16),
              Text(
                'Author: User ${post.userId}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// User Card Widget
class UserCard extends StatelessWidget {
  final User user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Text(
            user.name[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('@${user.username}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(Icons.email, 'Email', user.email),
                const SizedBox(height: 8),
                _buildDetailRow(Icons.phone, 'Phone', user.phone),
                const SizedBox(height: 8),
                _buildDetailRow(Icons.web, 'Website', user.website),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _launchEmail(user.email),
                      icon: const Icon(Icons.email, size: 16),
                      label: const Text('Email'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _launchWebsite(user.website),
                      icon: const Icon(Icons.web, size: 16),
                      label: const Text('Website'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.teal,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _launchEmail(String email) {
    // In a real app, you would use url_launcher package
    print('Launch email to: $email');
  }

  void _launchWebsite(String website) {
    // In a real app, you would use url_launcher package
    print('Launch website: $website');
  }
}