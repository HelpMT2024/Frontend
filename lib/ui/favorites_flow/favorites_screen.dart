import 'package:flutter/material.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen_view_model.dart';

class FavoritesScreen extends StatefulWidget {
  final FavoritesScreenViewModel viewModel;

  const FavoritesScreen({super.key, required this.viewModel});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: const Center(
        child: Text('Favorites'),
      ),
    );
  }
}
