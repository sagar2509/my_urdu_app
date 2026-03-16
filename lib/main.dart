import 'package:flutter/material.dart';
import 'models/urdu_char.dart';
import 'widgets/char_card.dart';

void main() => runApp(const MaterialApp(home: UrduLogicApp()));

class UrduLogicApp extends StatefulWidget {
  const UrduLogicApp({super.key});

  @override
  State<UrduLogicApp> createState() => _UrduLogicAppState();
}

class _UrduLogicAppState extends State<UrduLogicApp> {
  // 1. The Full Master List (Referencing the list from the previous step)
  final List<UrduChar> allChars = [
    // --- The Alif Family ---
    UrduChar(glyph: "ا", phonetic: "Alif", family: "alif"),
    UrduChar(glyph: "آ", phonetic: "Alif Madda", isDelta: true, family: "alif"),

    // --- The 'Be' Family (The Boat) ---
    UrduChar(glyph: "ب", phonetic: "Be", family: "boat"),
    UrduChar(glyph: "پ", phonetic: "Pe", isDelta: true, family: "boat"),
    UrduChar(glyph: "ت", phonetic: "Te", family: "boat"),
    UrduChar(glyph: "ٹ", phonetic: "Tte", isDelta: true, family: "boat"),
    UrduChar(glyph: "ث", phonetic: "Se", family: "boat"),

    // --- The 'Jeem' Family (The Hook) ---
    UrduChar(glyph: "ج", phonetic: "Jeem", family: "hook"),
    UrduChar(glyph: "چ", phonetic: "Che", isDelta: true, family: "hook"),
    UrduChar(glyph: "ح", phonetic: "Barri He", family: "hook"),
    UrduChar(glyph: "خ", phonetic: "Khe", family: "hook"),

    // --- The 'Dal' Family (The Angle) ---
    UrduChar(glyph: "د", phonetic: "Dal", family: "angle"),
    UrduChar(glyph: "ڈ", phonetic: "Ddal", isDelta: true, family: "angle"),
    UrduChar(glyph: "ذ", phonetic: "Zaal", family: "angle"),

    // --- The 'Re' Family (The Slide) ---
    UrduChar(glyph: "ر", phonetic: "Re", family: "slide"),
    UrduChar(glyph: "ڑ", phonetic: "Rre", isDelta: true, family: "slide"),
    UrduChar(glyph: "ز", phonetic: "Ze", family: "slide"),
    UrduChar(glyph: "ژ", phonetic: "Zhe", isDelta: true, family: "slide"),

    // Adding a few more to complete the pattern...
    UrduChar(glyph: "ک", phonetic: "Kaaf", family: "stick"),
    UrduChar(glyph: "گ", phonetic: "Gaaf", isDelta: true, family: "stick"),
  ];

  // 2. The "Calculated" List (What the user actually sees)
  List<UrduChar> filteredChars = [];
  bool showOnlyDeltas = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredChars = allChars; // Initialize with everything
  }

  void _runFilter() {
    setState(() {
      filteredChars = allChars.where((char) {
        final matchesSearch =
            char.phonetic.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesDelta = showOnlyDeltas ? char.isDelta : true;
        return matchesSearch && matchesDelta;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Urdu Logic Builder"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search by phonetic (e.g. 'Pe')",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    searchQuery = value;
                    _runFilter();
                  },
                ),
              ),
              // Delta Toggle
              FilterChip(
                label: const Text("Show Urdu-Only (Deltas)"),
                selected: showOnlyDeltas,
                onSelected: (bool value) {
                  showOnlyDeltas = value;
                  _runFilter();
                },
              ),
            ],
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.85, // Adjust this to make cards taller/shorter
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: filteredChars.length,
          itemBuilder: (context, index) => CharCard(char: filteredChars[index]),
        ),
      ),
    );
  }
}
