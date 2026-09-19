// Assignment 2: Null-Safe Async Fetcher
// Build a Dart program using null safety, Future, and async/await to fetch and display mock API data. Handle null and error cases.

import 'dart:async';
import 'dart:convert';
import 'dart:math';

void main() async {
  print('=== NULL-SAFE ASYNC FETCHER ===\n');
  
  // Create API service
  MockApiService apiService = MockApiService();
  
  // Demonstrate various async operations with null safety
  await demonstrateBasicAsyncOperations(apiService);
  await demonstrateBatchOperations(apiService);
  await demonstrateErrorHandling(apiService);
  await demonstrateStreamOperations(apiService);
  
  print('\n✅ All async operations completed!');
}

// Demonstrate basic async operations with null safety
Future<void> demonstrateBasicAsyncOperations(MockApiService apiService) async {
  print('🔄 BASIC ASYNC OPERATIONS\n');
  
  try {
    // Fetch user data with null safety
    print('Fetching user data...');
    User? user = await apiService.fetchUser(1);
    
    if (user != null) {
      print('✅ User found: ${user.name} (${user.email})');
      
      // Fetch user posts - demonstrating optional chaining
      List<Post>? userPosts = await apiService.fetchUserPosts(user.id);
      
      if (userPosts != null && userPosts.isNotEmpty) {
        print('📝 User has ${userPosts.length} posts:');
        for (int i = 0; i < min(3, userPosts.length); i++) {
          print('   ${i + 1}. ${userPosts[i].title}');
        }
      } else {
        print('📝 User has no posts');
      }
    } else {
      print('❌ User not found');
    }
    
    // Demonstrate nullable return handling
    String? userStatus = await apiService.getUserStatus(1);
    print('👤 User status: ${userStatus ?? "No status available"}');
    
  } catch (e) {
    print('❌ Error in basic operations: $e');
  }
  
  print('');
}

// Demonstrate batch operations and concurrent fetching
Future<void> demonstrateBatchOperations(MockApiService apiService) async {
  print('🚀 BATCH OPERATIONS\n');
  
  try {
    print('Fetching multiple users concurrently...');
    
    // Create futures for multiple users
    List<Future<User?>> userFutures = [
      apiService.fetchUser(1),
      apiService.fetchUser(2),
      apiService.fetchUser(3),
      apiService.fetchUser(999), // This will return null
    ];
    
    // Wait for all futures to complete
    List<User?> users = await Future.wait(userFutures);
    
    // Filter out null values using null-aware operators
    List<User> validUsers = users.whereType<User>().toList();
    
    print('✅ Successfully fetched ${validUsers.length} out of ${userFutures.length} users');
    
    for (User user in validUsers) {
      print('👤 ${user.name} - ${user.email}');
    }
    
    // Demonstrate timeout handling
    print('\nFetching data with timeout...');
    try {
      List<Post>? posts = await apiService.fetchAllPosts()
          .timeout(Duration(seconds: 2));
      
      if (posts != null) {
        print('✅ Fetched ${posts.length} posts within timeout');
      }
    } on TimeoutException {
      print('⏰ Request timed out');
    }
    
  } catch (e) {
    print('❌ Error in batch operations: $e');
  }
  
  print('');
}

// Demonstrate comprehensive error handling
Future<void> demonstrateErrorHandling(MockApiService apiService) async {
  print('🛡️ ERROR HANDLING\n');
  
  // Test different error scenarios
  List<int> testIds = [1, -1, 404, 500];
  
  for (int id in testIds) {
    try {
      print('Testing user ID: $id');
      
      User? user = await apiService.fetchUser(id);
      
      if (user != null) {
        print('✅ Success: ${user.name}');
        
        // Try to get additional data
        UserProfile? profile = await apiService.fetchUserProfile(id);
        String profileInfo = profile?.bio ?? 'No bio available';
        print('   Bio: $profileInfo');
        
      } else {
        print('⚠️ No user found for ID: $id');
      }
      
    } on ApiException catch (e) {
      print('🚫 API Error: ${e.message} (Code: ${e.code})');
    } on NetworkException catch (e) {
      print('🌐 Network Error: ${e.message}');
    } catch (e) {
      print('❌ Unexpected Error: $e');
    }
  }
  
  // Demonstrate retry mechanism
  print('\nTesting retry mechanism...');
  try {
    Post? post = await apiService.fetchPostWithRetry(1, maxRetries: 3);
    if (post != null) {
      print('✅ Successfully fetched post after retries: ${post.title}');
    }
  } catch (e) {
    print('❌ Failed after all retries: $e');
  }
  
  print('');
}

// Demonstrate stream operations
Future<void> demonstrateStreamOperations(MockApiService apiService) async {
  print('🌊 STREAM OPERATIONS\n');
  
  try {
    print('Listening to real-time data stream...');
    
    // Listen to stream with null safety
    await for (DataUpdate? update in apiService.getDataUpdates().take(5)) {
      if (update != null) {
        String timestamp = update.timestamp.toString().substring(11, 19);
        print('📡 [$timestamp] ${update.type}: ${update.data ?? "No data"}');
      } else {
        print('📡 Received null update');
      }
    }
    
    print('✅ Stream completed');
    
  } catch (e) {
    print('❌ Stream error: $e');
  }
  
  print('');
}

// Data Models with null safety
class User {
  final int id;
  final String name;
  final String email;
  final String? phone; // Nullable field
  final Address? address; // Nullable nested object
  
  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      address: json['address'] != null 
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
    );
  }
  
  @override
  String toString() => 'User{id: $id, name: $name, email: $email}';
}

class Address {
  final String street;
  final String city;
  final String? zipcode; // Nullable
  
  Address({
    required this.street,
    required this.city,
    this.zipcode,
  });
  
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String?,
    );
  }
  
  @override
  String toString() => '$street, $city ${zipcode ?? ""}';
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  final DateTime? publishedAt; // Nullable
  
  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.publishedAt,
  });
  
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      publishedAt: json['publishedAt'] != null 
          ? DateTime.parse(json['publishedAt'] as String)
          : null,
    );
  }
}

class UserProfile {
  final int userId;
  final String? bio;
  final String? website;
  final Map<String, dynamic>? metadata;
  
  UserProfile({
    required this.userId,
    this.bio,
    this.website,
    this.metadata,
  });
  
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] as int,
      bio: json['bio'] as String?,
      website: json['website'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
}

class DataUpdate {
  final String type;
  final DateTime timestamp;
  final String? data;
  
  DataUpdate({
    required this.type,
    required this.timestamp,
    this.data,
  });
}

// Custom exceptions for better error handling
class ApiException implements Exception {
  final String message;
  final int code;
  
  ApiException(this.message, this.code);
  
  @override
  String toString() => 'ApiException: $message (Code: $code)';
}

class NetworkException implements Exception {
  final String message;
  
  NetworkException(this.message);
  
  @override
  String toString() => 'NetworkException: $message';
}

// Mock API Service with comprehensive async operations and null safety
class MockApiService {
  final Random _random = Random();
  final List<User> _users = [];
  final List<Post> _posts = [];
  
  MockApiService() {
    _initializeMockData();
  }
  
  void _initializeMockData() {
    // Initialize mock users with some having null optional fields
    _users.addAll([
      User(
        id: 1, 
        name: 'John Doe', 
        email: 'john@example.com',
        phone: '+1-555-0123',
        address: Address(street: '123 Main St', city: 'Anytown', zipcode: '12345'),
      ),
      User(
        id: 2, 
        name: 'Jane Smith', 
        email: 'jane@example.com',
        phone: null, // Nullable field
        address: null, // Nullable field
      ),
      User(
        id: 3, 
        name: 'Bob Johnson', 
        email: 'bob@example.com',
        phone: '+1-555-0456',
        address: Address(street: '456 Oak Ave', city: 'Springfield'),
      ),
    ]);
    
    // Initialize mock posts
    _posts.addAll([
      Post(id: 1, userId: 1, title: 'Introduction to Dart', body: 'Dart is a great language...'),
      Post(id: 2, userId: 1, title: 'Async Programming', body: 'Future and async/await...'),
      Post(id: 3, userId: 2, title: 'Null Safety Benefits', body: 'Null safety prevents...'),
      Post(id: 4, userId: 3, title: 'Flutter Development', body: 'Building mobile apps...'),
    ]);
  }
  
  // Simulate network delay
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(Duration(milliseconds: 100 + _random.nextInt(500)));
  }
  
  // Simulate random failures
  void _simulateRandomFailure(double failureRate) {
    if (_random.nextDouble() < failureRate) {
      throw NetworkException('Simulated network failure');
    }
  }
  
  // Fetch user with null safety - returns null if not found
  Future<User?> fetchUser(int id) async {
    await _simulateNetworkDelay();
    
    // Simulate different error conditions
    if (id < 0) {
      throw ApiException('Invalid user ID', 400);
    }
    
    if (id == 404) {
      throw ApiException('User not found', 404);
    }
    
    if (id == 500) {
      throw ApiException('Internal server error', 500);
    }
    
    // Simulate random network failures
    _simulateRandomFailure(0.1); // 10% failure rate
    
    // Return user if found, null otherwise
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null; // Return null if user not found
    }
  }
  
  // Fetch user posts with null safety
  Future<List<Post>?> fetchUserPosts(int userId) async {
    await _simulateNetworkDelay();
    
    _simulateRandomFailure(0.05); // 5% failure rate
    
    List<Post> userPosts = _posts.where((post) => post.userId == userId).toList();
    
    // Return null if no posts found or random condition
    if (userPosts.isEmpty || _random.nextBool()) {
      return null;
    }
    
    return userPosts;
  }
  
  // Get user status - nullable return
  Future<String?> getUserStatus(int userId) async {
    await _simulateNetworkDelay();
    
    List<String?> statuses = [
      'Active',
      'Away', 
      'Busy',
      null, // Some users have no status
      'Do not disturb',
    ];
    
    return statuses[_random.nextInt(statuses.length)];
  }
  
  // Fetch all posts with potential null return
  Future<List<Post>?> fetchAllPosts() async {
    // Simulate longer delay
    await Future.delayed(Duration(seconds: 1 + _random.nextInt(3)));
    
    _simulateRandomFailure(0.15); // 15% failure rate
    
    return List.from(_posts);
  }
  
  // Fetch user profile with nested nullable fields
  Future<UserProfile?> fetchUserProfile(int userId) async {
    await _simulateNetworkDelay();
    
    // Simulate profiles with various nullable fields
    Map<int, UserProfile> profiles = {
      1: UserProfile(
        userId: 1,
        bio: 'Software developer passionate about Dart and Flutter',
        website: 'https://johndoe.dev',
        metadata: {'theme': 'dark', 'notifications': true},
      ),
      2: UserProfile(
        userId: 2,
        bio: null, // No bio
        website: 'https://janesmith.com',
        metadata: null, // No metadata
      ),
      3: UserProfile(
        userId: 3,
        bio: 'Mobile app enthusiast',
        website: null, // No website
        metadata: {'language': 'en'},
      ),
    };
    
    return profiles[userId]; // Returns null if profile doesn't exist
  }
  
  // Fetch post with retry mechanism
  Future<Post?> fetchPostWithRetry(int postId, {int maxRetries = 3}) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        attempts++;
        await _simulateNetworkDelay();
        
        // Simulate high failure rate for retry demonstration
        _simulateRandomFailure(0.7); // 70% failure rate
        
        // If successful, return the post
        try {
          return _posts.firstWhere((post) => post.id == postId);
        } catch (e) {
          return null; // Post not found
        }
        
      } catch (e) {
        print('   Attempt $attempts failed: $e');
        
        if (attempts >= maxRetries) {
          rethrow; // Re-throw after all retries exhausted
        }
        
        // Wait before retrying
        await Future.delayed(Duration(milliseconds: 500 * attempts));
      }
    }
    
    return null;
  }
  
  // Stream of data updates with nullable elements
  Stream<DataUpdate?> getDataUpdates() async* {
    List<String> updateTypes = ['user_login', 'post_created', 'comment_added', 'user_logout'];
    List<String?> sampleData = [
      'User John logged in',
      'New post: "Hello World"',
      null, // Some updates have no data
      'Comment on post #123',
      'User Jane logged out',
    ];
    
    for (int i = 0; i < 10; i++) {
      // Simulate delay between updates
      await Future.delayed(Duration(milliseconds: 200 + _random.nextInt(300)));
      
      // Sometimes yield null to test null handling
      if (_random.nextDouble() < 0.2) { // 20% chance of null
        yield null;
      } else {
        yield DataUpdate(
          type: updateTypes[_random.nextInt(updateTypes.length)],
          timestamp: DateTime.now(),
          data: sampleData[_random.nextInt(sampleData.length)],
        );
      }
    }
  }
  
  // Batch fetch operations with mixed results
  Future<Map<String, dynamic?>> fetchBatchData(List<int> ids) async {
    Map<String, dynamic?> results = {};
    
    for (int id in ids) {
      try {
        User? user = await fetchUser(id);
        List<Post>? posts = user != null ? await fetchUserPosts(user.id) : null;
        
        results['user_$id'] = user;
        results['posts_$id'] = posts;
        
      } catch (e) {
        results['user_$id'] = null;
        results['posts_$id'] = null;
        results['error_$id'] = e.toString();
      }
    }
    
    return results;
  }
  
  // Complex async operation with multiple nullable dependencies
  Future<String?> generateUserSummary(int userId) async {
    try {
      // Fetch user data
      User? user = await fetchUser(userId);
      if (user == null) {
        return null;
      }
      
      // Fetch additional data concurrently
      List<dynamic> results = await Future.wait([
        fetchUserPosts(user.id),
        fetchUserProfile(user.id),
        getUserStatus(user.id),
      ]);
      
      List<Post>? posts = results[0] as List<Post>?;
      UserProfile? profile = results[1] as UserProfile?;
      String? status = results[2] as String?;
      
      // Build summary with null-aware operators
      StringBuffer summary = StringBuffer();
      summary.writeln('User: ${user.name} (${user.email})');
      
      if (user.phone != null) {
        summary.writeln('Phone: ${user.phone}');
      }
      
      if (user.address != null) {
        summary.writeln('Address: ${user.address}');
      }
      
      summary.writeln('Status: ${status ?? "Unknown"}');
      
      if (profile?.bio != null) {
        summary.writeln('Bio: ${profile!.bio}');
      }
      
      if (profile?.website != null) {
        summary.writeln('Website: ${profile!.website}');
      }
      
      int postCount = posts?.length ?? 0;
      summary.writeln('Posts: $postCount');
      
      return summary.toString();
      
    } catch (e) {
      return 'Error generating summary: $e';
    }
  }
}