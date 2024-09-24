import 'package:flutter/material.dart';
import 'package:myfluffy/screen/CatDetailPage.dart';

class FindPage extends StatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  Map<String, List<String>> zoneCats = {
    'Bangkok': ['Fluffy', 'Snowball', 'Garfield'],
    'Ladkrabang': ['Kitty', 'Whiskers', 'Bangkok', 'Siamese', 'Tom'],
  };

  Map<String, List<String>> filteredZoneCats = {};
  bool isSortedByName = false;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredZoneCats = Map.from(zoneCats); 
  }

  void searchCat(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredZoneCats = Map.from(zoneCats); 
      } else {
        filteredZoneCats = {};
        zoneCats.forEach((zone, cats) {
          final matchedCats = cats.where((cat) {
            return cat.toLowerCase().contains(query.toLowerCase());
          }).toList();
          if (matchedCats.isNotEmpty) {
            filteredZoneCats[zone] = matchedCats;
          }
        });
      }
    });
  }

  void sortCats() {
    setState(() {
      if (isSortedByName) {
        filteredZoneCats = Map.from(zoneCats);
      } else {
        // Sort alphabetically by name
        List<String> allCats = [];
        zoneCats.values.forEach((cats) => allCats.addAll(cats));
        allCats.sort((a, b) => a.compareTo(b));
        filteredZoneCats = {'All Cats': allCats};
      }
      isSortedByName = !isSortedByName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Missing Cats'),
        backgroundColor: Colors.yellow[300],
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: sortCats, 
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
              onChanged: searchCat, // searchCat method
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for a missing cat...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredZoneCats.keys.length,
                itemBuilder: (context, zoneIndex) {
                  String zone = filteredZoneCats.keys.elementAt(zoneIndex);
                  List<String> catsInZone = filteredZoneCats[zone] ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        zone,
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
                        itemCount: catsInZone.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CatDetailPage(catName: catsInZone[index]),
                                ),
                              );
                            },
                            child: buildCatTile(catsInZone[index]),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCatTile(String catName) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pets, size: 40, color: Color.fromARGB(255, 79, 71, 6)),
          const SizedBox(height: 10),
          Text(
            catName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
