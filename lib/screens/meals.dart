import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.model.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_list_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    this.categoryColor,
    required this.meals,
  });

  final String? title;
  final Color? categoryColor;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(
      child: Text(
        'No meals...',
        style: Theme.of(context)
            .textTheme
            .headlineLarge!
            .copyWith(color: Colors.white),
      ),
    );

    if (meals.isNotEmpty) {
      body = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealListItem(
          meal: meals[index],
          onSelectMeal: (meal) => _selectMeal(
            context,
            meal,
          ),
        ),
      );
    }

    if (title == null) {
      return body;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
        backgroundColor: categoryColor,
      ),
      body: body,
    );
  }
}
