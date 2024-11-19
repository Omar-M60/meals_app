import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

enum Filter {
  gluttenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.gluttenFree: false,
          Filter.lactoseFree: false,
          Filter.vegeterian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool value) {
    state = {
      ...state,
      filter: value,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final filters = ref.watch(filtersProvider);
  return dummyMeals.where((meal) {
    if (filters[Filter.gluttenFree]! && !meal.isGlutenFree) return false;
    if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
    if (filters[Filter.vegeterian]! && !meal.isVegetarian) return false;
    if (filters[Filter.vegan]! && !meal.isVegan) return false;

    return true;
  }).toList();
});
