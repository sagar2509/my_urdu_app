import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../models/lesson.dart';
import '../models/urdu_char.dart';
import '../state/progress_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/char_card.dart';
import 'quiz_screen.dart';

/// Shows the glyphs of a single [Lesson] in a searchable, filterable grid.
/// Generalized from the old "chapter" screen so any lesson from any module
/// renders the same way — new modules don't need a new screen.
class LessonScreen extends StatefulWidget {
  final CharLesson lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _showOnlyDeltas = false;
  String _searchQuery = '';

  List<UrduChar> get _filteredChars {
    return widget.lesson.chars.where((char) {
      final matchesSearch =
          char.phonetic.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesDelta = _showOnlyDeltas ? char.isDelta : true;
      return matchesSearch && matchesDelta;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();
    final chars = widget.lesson.chars;
    final viewedCount = progress.viewedCountIn(chars.map((c) => c.id));

    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          _buildProgressBar(viewedCount, chars.length),
          if (widget.lesson.showFilters) _buildFilterSection(),
          Expanded(child: _buildGrid()),
        ],
      ),
      floatingActionButton: chars.length >= 4
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => QuizScreen(lesson: widget.lesson)),
              ),
              icon: const Icon(Icons.quiz),
              label: const Text('Quiz'),
            )
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: AppConstants.searchHint,
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => setState(() => _searchQuery = value),
            )
          : Text(widget.lesson.title),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          tooltip: _isSearching ? 'Close search' : 'Search',
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchController.clear();
                _searchQuery = '';
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildProgressBar(int viewed, int total) {
    final ratio = total == 0 ? 0.0 : viewed / total;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$viewed / $total explored',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: ratio, minHeight: 6),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FilterChip(
        label: const Text(AppConstants.urduOnlyLabel),
        selected: _showOnlyDeltas,
        onSelected: (val) => setState(() => _showOnlyDeltas = val),
      ),
    );
  }

  Widget _buildGrid() {
    final chars = _filteredChars;
    // Leave extra room at the bottom so the floating Quiz button doesn't
    // sit on top of (and block taps on) the last row of cards.
    final hasQuizFab = widget.lesson.chars.length >= 4;

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth / 120).floor();
        if (crossAxisCount < 2) crossAxisCount = 2;
        if (crossAxisCount > 8) crossAxisCount = 8;

        return Directionality(
          textDirection: widget.lesson.direction,
          child: GridView.builder(
            padding: EdgeInsets.fromLTRB(
              AppConstants.cardPadding,
              AppConstants.cardPadding,
              AppConstants.cardPadding,
              hasQuizFab ? 96 : AppConstants.cardPadding,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppConstants.gridSpacing,
              mainAxisSpacing: AppConstants.gridSpacing,
              childAspectRatio: AppConstants.cardAspectRatio,
            ),
            itemCount: chars.length,
            itemBuilder: (context, index) => CharCard(char: chars[index]),
          ),
        );
      },
    );
  }
}
