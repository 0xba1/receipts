import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Search receipts',
                  prefixIcon: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
