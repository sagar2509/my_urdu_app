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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<UrduChar> currentChapterList = ChapterData.getMasterList();
  List<UrduChar> filteredChars = [];
  String currentTitle = AppConstants.masterList;
  bool showOnlyDeltas = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    currentTitle = AppConstants.home; // Start on the Home Dashboard
    currentChapterList =
        []; // Start with an empty list until a chapter is selected
    filteredChars = []; // Initialize with everything
    showOnlyDeltas = false; // Default to showing all characters
    _searchController.clear(); // Ensure search is clear on startup
    searchQuery = ""; // Clear search query on startup
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
      filteredChars =
          newList; // Reset filter to show all chars in the new chapter
      showOnlyDeltas = false; // Reset delta filter on chapter change
      _searchController.clear();
      searchQuery = "";
      _runFilter();
    });
    // Only close drawer if it is actually open.
    if (_scaffoldKey.currentState?.isDrawerOpen == true) {
      _scaffoldKey.currentState?.closeDrawer();
    }
  }

  bool _isSearching = false; // Track if we are in "Search Mode"
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            _buildChapterTile(AppConstants.home, Icons.home, () {
              _switchChapter([], AppConstants.home);
            }),
            const Divider(),
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
          // 1. Check for Home Page first
          if (currentTitle == AppConstants.home)
            Expanded(child: _buildHomeDashboard())

          // 2. Otherwise, render the Chapter View (Filter + Grid)
          else ...[
            // Only show the FilterChip for the Master List
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

            // Use LayoutBuilder for the Responsive Grid
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate columns based on target width (120px)
                  int crossAxisCount = (constraints.maxWidth / 120).floor();
                  if (crossAxisCount < 2) crossAxisCount = 2;
                  if (crossAxisCount > 8) crossAxisCount = 8;

                  return Directionality(
                    // LTR for Numbers, RTL for everything else
                    textDirection: currentTitle == AppConstants.urduNumbers
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: filteredChars.length,
                      itemBuilder: (context, index) =>
                          CharCard(char: filteredChars[index]),
                    ),
                  );
                },
              ),
            ),
          ],
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

  // --- Bonus: A Home Dashboard (could be triggered from a "Home" button in the drawer) ---
  Widget _buildHomeDashboard() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.menu_book_outlined, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            AppConstants.appTitle,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Text(
              "Learn Urdu by understanding the core 'engines' and 'logic' behind the script.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Trigger the "Basics" chapter from the home button
              final basicsData = ChapterData.getBasics();
              _switchChapter(basicsData, AppConstants.basics);
            },
            child: const Text("Begin with Basics"),
          ),
        ],
      ),
    );
  }
}
