import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/views/widgets/search_bar.dart';

/// {@template home}
/// Home screen
/// {@endtemplate}
class Home extends StatelessWidget {
  /// {@macro home}
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SearchBar(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                ),
                Icon(
                  Icons.lightbulb,
                  size: 128,
                  color: IconTheme.of(context).color?.withOpacity(0.2),
                ),
                const Text('Oh. So. Empty'),
                TextButton(
                  onPressed: () {
                    context.pushNamed('new_receipt');
                  },
                  child: const Text('Create new receipt'),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Create new receipt',
          onPressed: () {
            context.pushNamed('new_receipt');
          },
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
