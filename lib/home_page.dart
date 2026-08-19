import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Post data - list of posts
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'farmer_life',
      'subtitle': 'Rural Living',
      'imagePath': 'assets/images/spiderman.jpg',
      'caption': 'spiderman',
    },
    {
      'username': 'fashion_store',
      'subtitle': 'Online Shopping',
      'imagePath': 'assets/images/suit.png',
      'caption': 'fashion_store New collection just dropped! Shop now 👕🛍️',
    },
    {
      'username': 'streetwear_daily',
      'subtitle': 'Fashion & Style',
      'imagePath': 'assets/images/beans.png',
      'caption': 'streetwear_daily This jacket is fire! Available in all sizes 🔥',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ==========================================
      // APP BAR
      // ==========================================

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: const Text(
          'Instagram',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.favorite_border,
            ),
          ),

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.send_outlined,
            ),
          ),
        ],
      ),

      // ==========================================
      // BODY
      // ==========================================

      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostWidget(
            username: posts[index]['username'],
            subtitle: posts[index]['subtitle'],
            imagePath: posts[index]['imagePath'],
            caption: posts[index]['caption'],
          );
        },
      ),
    );
  }
}

// ==========================================
// POST WIDGET (REUSABLE)
// ==========================================

class PostWidget extends StatefulWidget {
  final String username;
  final String subtitle;
  final String imagePath;
  final String caption;

  const PostWidget({
    super.key,
    required this.username,
    required this.subtitle,
    required this.imagePath,
    required this.caption,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {

  // Like state
  int likes = 0;
  bool isLiked = false;

  // Like button function
  void toggleLike() {
    setState(() {
      if (isLiked) {
        likes--;
        isLiked = false;
      } else {
        likes++;
        isLiked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        // ======================================
        // PROFILE SECTION
        // ======================================

        Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [

              // Profile Icon
              Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(
                    width: 2,
                  ),
                ),

                child: const Icon(
                  Icons.person,
                  size: 30,
                ),
              ),

              const SizedBox(width: 12),

              // Username
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      widget.username,

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      widget.subtitle,

                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // Follow Button
              ElevatedButton(
                onPressed: () {},

                child: const Text(
                  'Follow',
                ),
              ),
            ],
          ),
        ),

        // ======================================
        // POST IMAGE
        // ======================================

        Container(
          width: double.infinity,
          height: 350,
          color: Colors.grey[300],

          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image,
                      size: 60,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Image not found',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.imagePath,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // ======================================
        // POST ACTIONS
        // ======================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),

          child: Row(
            children: [

              // LIKE
              IconButton(
                onPressed: toggleLike,

                icon: Icon(

                  isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,

                  size: 30,

                  color: isLiked
                      ? Colors.red
                      : Colors.black,
                ),
              ),

              // COMMENT
              IconButton(
                onPressed: () {},

                icon: const Icon(
                  Icons.chat_bubble_outline,
                  size: 28,
                ),
              ),

              // SHARE
              IconButton(
                onPressed: () {},

                icon: const Icon(
                  Icons.send_outlined,
                  size: 28,
                ),
              ),

              const Spacer(),

              // SAVE
              IconButton(
                onPressed: () {},

                icon: const Icon(
                  Icons.bookmark_border,
                  size: 28,
                ),
              ),
            ],
          ),
        ),

        // ======================================
        // LIKE COUNT
        // ======================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          child: Text(
            '$likes likes',

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // ======================================
        // CAPTION
        // ======================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          child: Text(
            widget.caption,

            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ======================================
        // LIKE BUTTON
        // ======================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          child: SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(

              onPressed: toggleLike,

              icon: Icon(
                isLiked
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),

              label: Text(
                isLiked
                    ? 'Liked'
                    : 'Like this post',
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
