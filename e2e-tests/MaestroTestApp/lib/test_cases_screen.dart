import 'package:flutter/material.dart';
import 'test_cases.dart';

class TestCasesScreen extends StatelessWidget {
  const TestCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Cases')),
      body: ListView(
        children: testCases
            .map((tc) => ListTile(
                  title: Text(tc.title),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => tc.screen),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
