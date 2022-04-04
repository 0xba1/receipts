import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

/// {@template search_bar}
/// Search bar in home screen
/// {@endtemplate}
class SearchBar extends StatelessWidget {
  /// {@macro search_bar}
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 48,
        width: width - 16,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () {
            context.pushNamed('search');
          },
          borderRadius: BorderRadius.circular(100),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.menu_rounded,
                    ),
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.search,
              )
            ],
          ),
        ),
      ),
    );
  }
}
