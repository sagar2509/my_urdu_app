import 'package:flutter/material.dart';
import 'models/urdu_char.dart';
import 'widgets/char_card.dart';
import 'chapters/chapters_data.dart';
import 'core/constants.dart';

void main() => runApp(const MaterialApp(home: UrduLogicApp()));

class UrduLogicApp extends StatefulWidget {
  const UrduLogicApp({super.key});

  @override
  State<UrduLogicApp> createState() => _UrduLogicAppState();
}

class _UrduLogicAppState extends State<UrduLogicApp> {
  List<UrduChar> currentChapterList = ChapterData.getMasterList();
  List<UrduChar> filteredChars = [];
  String currentTitle = AppConstants.masterList;
  bool showOnlyDeltas = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredChars = currentChapterList; // Initialize with everything
  }

  void _runFilter() {
    setState(() {
      filteredChars = currentChapterList.where((char) {
        final matchesSearch =
            char.phonetic.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesDelta = showOnlyDeltas ? char.isDelta : true;
        return matchesSearch && matchesDelta;
      }).toList();
    });
  }

  void _switchChapter(List<UrduChar> newList, String newTitle) {
    setState(() {
      currentChapterList = newList;
      currentTitle = newTitle;
      _isSearching = false; // Reset search on chapter change
      _searchController.clear();
      searchQuery = "";
      _runFilter();
    });
    Navigator.pop(context); // Close the drawer
  }

  bool _isSearching = false; // Track if we are in "Search Mode"
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- 1. The Top Navigation Bar ---
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search phonetics...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  searchQuery = value;
                  _runFilter();
                },
              )
            : const Text(AppConstants.appTitle),
        actions: [
          // Toggle Search Icon
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  searchQuery = "";
                  _runFilter();
                }
              });
            },
          ),
        ],
      ),

      // --- 2. The Sidebar Navigation (Chapters)
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text(AppConstants.menu)),
            _buildChapterTile(AppConstants.basics, Icons.architecture, () {
              _switchChapter(ChapterData.getBasics(), AppConstants.basics);
            }),
            _buildChapterTile(AppConstants.advanced, Icons.new_releases, () {
              _switchChapter(ChapterData.getAdvanced(), AppConstants.advanced);
            }),
            _buildChapterTile(AppConstants.urduSpecials, Icons.star, () {
              _switchChapter(
                  ChapterData.getUrduSpecials(), AppConstants.urduSpecials);
            }),
            _buildChapterTile(AppConstants.masterList, Icons.check, () {
              _switchChapter(
                  ChapterData.getMasterList(), AppConstants.masterList);
            }),
          ],
        ),
      ),

      // --- 3. The Main Content ---
      body: Column(
        children: [
          // Small filter chip row below the app bar for "Deltas"
          if (currentTitle == AppConstants.masterList)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilterChip(
                label: const Text("Urdu-Only"),
                selected: showOnlyDeltas,
                onSelected: (val) {
                  setState(() {
                    showOnlyDeltas = val;
                    _runFilter();
                  });
                },
              ),
            ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.85,
                ),
                itemCount: filteredChars.length,
                itemBuilder: (context, index) =>
                    CharCard(char: filteredChars[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Sidebar Tiles
  Widget _buildChapterTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
