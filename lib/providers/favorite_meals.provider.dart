import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.model.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFavoriteMeal(Meal meal) {
    final bool isFavorite = state.contains(meal);

    if (isFavorite) {
      //* If we removed a meal from the list then return false
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      //* If a meal is added then return true
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) => FavoriteMealsNotifier(),
);
