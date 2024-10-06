import 'package:flutter/material.dart';
import 'package:myfluffy/model/CatTile.dart';
import 'package:myfluffy/model/post.dart';
import 'package:myfluffy/screen/CatDetailPage.dart';
import 'package:provider/provider.dart';
import 'package:myfluffy/providers/catspost_provider.dart';

class FindPage extends StatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  TextEditingController searchController = TextEditingController();
  bool isSortedByName = false;

  @override
  void initState() {
    super.initState();
    // Fetch all posts once when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CatspostProvider>(context, listen: false).fetchAllPosts();
    });
  }

  void searchCat(String query) {
    Provider.of<CatspostProvider>(context, listen: false).searchPosts(query);
  }

  void sortCats() {
    Provider.of<CatspostProvider>(context, listen: false).sortPosts();
    setState(() {
      isSortedByName = !isSortedByName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Missing Cats', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF7B3FF4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Handle back navigation
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_by_alpha_rounded),
            onPressed: sortCats,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh all posts by calling provider fetch again
              Provider.of<CatspostProvider>(context, listen: false).fetchAllPosts();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              onChanged: searchCat,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for a location or pet name...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<CatspostProvider>(
                builder: (context, catProvider, child) {
                  if (catProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Group posts by location
                  Map<String, List<Post>> groupedPosts = {};
                  for (var post in catProvider.posts) {
                    if (!groupedPosts.containsKey(post.location)) {
                      groupedPosts[post.location] = [];
                    }
                    groupedPosts[post.location]!.add(post);
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await Provider.of<CatspostProvider>(context, listen: false).fetchAllPosts();
                    },
                    child: ListView.builder(
                      itemCount: groupedPosts.keys.length,
                      itemBuilder: (context, zoneIndex) {
                        String location = groupedPosts.keys.elementAt(zoneIndex);
                        List<Post> postsInLocation = groupedPosts[location] ?? [];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              location,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: postsInLocation.length,
                              itemBuilder: (context, index) {
                                Post post = postsInLocation[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CatDetailPage(post: post),
                                      ),
                                    );
                                  },
                                  child: CatTile(post: post), // Customize your CatTile widget
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
