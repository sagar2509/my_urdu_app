import 'package:flutter/material.dart';
import 'models/urdu_char.dart';
import 'widgets/char_card.dart';
import 'chapters/chapters_data.dart';
import 'core/constants.dart';

void main() => runApp(const UrduCoreApp());

class UrduCoreApp extends StatelessWidget {
  const UrduCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      // --- CENTRALIZED COLOR & FONT SYSTEM ---
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'AppSans', // Your English font (Inter/Poppins)
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.w800), // Extra Bold
          bodyMedium: TextStyle(fontWeight: FontWeight.w400), // Regular
          labelSmall: TextStyle(fontWeight: FontWeight.w300), // Light
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9669B6),
          primary: const Color(0xFF9669B6), // Amethyst Purple
          secondary: const Color(0xFFE74C3C), // Soft Crimson
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFFDFEFE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF9669B6),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9669B6),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: const UrduLogicApp(),
    );
  }
}

class UrduLogicApp extends StatefulWidget {
  const UrduLogicApp({super.key});

  @override
  State<UrduLogicApp> createState() => _UrduLogicAppState();
}

class _UrduLogicAppState extends State<UrduLogicApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  List<UrduChar> currentChapterList = [];
  List<UrduChar> filteredChars = [];
  String currentTitle = AppConstants.home;
  bool showOnlyDeltas = false;
  String searchQuery = "";
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    currentChapterList = [];
    filteredChars = [];
    showOnlyDeltas = false;
    searchQuery = "";
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
      filteredChars = newList;
      showOnlyDeltas = false;
      _isSearching = false; // Close search when switching chapters
      _searchController.clear();
      searchQuery = "";
      _runFilter();
    });
    if (_scaffoldKey.currentState?.isDrawerOpen == true) {
      _scaffoldKey.currentState?.closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(theme),
      drawer: _buildDrawer(theme),
      body: _buildBody(theme),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search phonetics...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: theme.colorScheme.onPrimary.withOpacity(0.7)),
              ),
              style: TextStyle(color: theme.colorScheme.onPrimary),
              onChanged: (value) {
                searchQuery = value;
                _runFilter();
              },
            )
          : Text(currentTitle == AppConstants.home
              ? AppConstants.appTitle
              : currentTitle),
      actions: [
        if (currentTitle != AppConstants.home)
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
    );
  }

  Widget _buildDrawer(ThemeData theme) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.primaryColor),
            child: Center(
              child: Text(
                AppConstants.menu,
                style:
                    TextStyle(color: theme.colorScheme.onPrimary, fontSize: 24),
              ),
            ),
          ),
          _buildChapterTile(AppConstants.home, Icons.home, () {
            _switchChapter([], AppConstants.home);
          }),
          const Divider(),
          _buildChapterTile(AppConstants.basics, Icons.architecture, () {
            _switchChapter(ChapterData.getBasics(), AppConstants.basics);
          }),
          _buildChapterTile(AppConstants.advanced, Icons.auto_awesome, () {
            _switchChapter(ChapterData.getAdvanced(), AppConstants.advanced);
          }),
          _buildChapterTile("Urdu Numbers", Icons.numbers, () {
            _switchChapter(ChapterData.getUrduNumbers().cast<UrduChar>(),
                AppConstants.urduNumbers);
          }),
          _buildChapterTile(AppConstants.masterList, Icons.format_list_bulleted,
              () {
            _switchChapter(
                ChapterData.getMasterList(), AppConstants.masterList);
          }),
        ],
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
    return Column(
      children: [
        if (currentTitle == AppConstants.home)
          Expanded(child: _buildHomeDashboard())
        else ...[
          if (currentTitle == AppConstants.masterList) _buildFilterSection(),
          Expanded(child: _buildResponsiveGrid()),
        ],
      ],
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FilterChip(
        label: const Text("Urdu Alphabets Only"),
        selected: showOnlyDeltas,
        onSelected: (val) {
          setState(() {
            showOnlyDeltas = val;
            _runFilter();
          });
        },
      ),
    );
  }

  Widget _buildResponsiveGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth / 120).floor();
        if (crossAxisCount < 2) crossAxisCount = 2;
        if (crossAxisCount > 8) crossAxisCount = 8;

        return Directionality(
          textDirection: currentTitle == AppConstants.urduNumbers
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: filteredChars.length,
            itemBuilder: (context, index) =>
                CharCard(char: filteredChars[index]),
          ),
        );
      },
    );
  }

  Widget _buildChapterTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildHomeDashboard() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_stories,
              size: 80, color: Theme.of(context).primaryColor),
          const SizedBox(height: 20),
          const Text(
            AppConstants.appTitle,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Text(
              "Learn Urdu by understanding the core 'engines' and 'logic' behind the script.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
          ),
          ElevatedButton(
            onPressed: () =>
                _switchChapter(ChapterData.getBasics(), AppConstants.basics),
            child: const Text("Begin with Basics"),
          ),
        ],
      ),
    );
  }
}
