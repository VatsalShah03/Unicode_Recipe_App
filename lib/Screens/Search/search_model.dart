class Search {
  Search({
    required this.status,
    required this.nutrition,
    required this.category,
    required this.recipes,
  });
  late final String status;
  late final Nutrition nutrition;
  late final Category category;
  late final List<Recipes> recipes;

  Search.fromJson(Map<String, dynamic> json){
    status = json['status'];
    nutrition = Nutrition.fromJson(json['nutrition']);
    category = Category.fromJson(json['category']);
    recipes = List.from(json['recipes']).map((e)=>Recipes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['nutrition'] = nutrition.toJson();
    _data['category'] = category.toJson();
    _data['recipes'] = recipes.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Nutrition {
  Nutrition({
    required this.recipesUsed,
    required this.calories,
    required this.fat,
    required this.protein,
    required this.carbs,
  });
  late final int recipesUsed;
  late final Calories calories;
  late final Fat fat;
  late final Protein protein;
  late final Carbs carbs;

  Nutrition.fromJson(Map<String, dynamic> json){
    recipesUsed = json['recipesUsed'];
    calories = Calories.fromJson(json['calories']);
    fat = Fat.fromJson(json['fat']);
    protein = Protein.fromJson(json['protein']);
    carbs = Carbs.fromJson(json['carbs']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['recipesUsed'] = recipesUsed;
    _data['calories'] = calories.toJson();
    _data['fat'] = fat.toJson();
    _data['protein'] = protein.toJson();
    _data['carbs'] = carbs.toJson();
    return _data;
  }
}

class Calories {
  Calories({
    required this.value,
    required this.unit,
    required this.confidenceRange95Percent,
    required this.standardDeviation,
  });
  late final double value;
  late final String unit;
  late final ConfidenceRange95Percent confidenceRange95Percent;
  late final double standardDeviation;

  Calories.fromJson(Map<String, dynamic> json){
    value = json['value'];
    unit = json['unit'];
    confidenceRange95Percent = ConfidenceRange95Percent.fromJson(json['confidenceRange95Percent']);
    standardDeviation = json['standardDeviation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['unit'] = unit;
    _data['confidenceRange95Percent'] = confidenceRange95Percent.toJson();
    _data['standardDeviation'] = standardDeviation;
    return _data;
  }
}

class ConfidenceRange95Percent {
  ConfidenceRange95Percent({
    required this.min,
    required this.max,
  });
  late final double min;
  late final double max;

  ConfidenceRange95Percent.fromJson(Map<String, dynamic> json){
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['min'] = min;
    _data['max'] = max;
    return _data;
  }
}

class Fat {
  Fat({
    required this.value,
    required this.unit,
    required this.confidenceRange95Percent,
    required this.standardDeviation,
  });
  late final double value;
  late final String unit;
  late final ConfidenceRange95Percent confidenceRange95Percent;
  late final double standardDeviation;

  Fat.fromJson(Map<String, dynamic> json){
    value = json['value'];
    unit = json['unit'];
    confidenceRange95Percent = ConfidenceRange95Percent.fromJson(json['confidenceRange95Percent']);
    standardDeviation = json['standardDeviation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['unit'] = unit;
    _data['confidenceRange95Percent'] = confidenceRange95Percent.toJson();
    _data['standardDeviation'] = standardDeviation;
    return _data;
  }
}

class Protein {
  Protein({
    required this.value,
    required this.unit,
    required this.confidenceRange95Percent,
    required this.standardDeviation,
  });
  late final double value;
  late final String unit;
  late final ConfidenceRange95Percent confidenceRange95Percent;
  late final double standardDeviation;

  Protein.fromJson(Map<String, dynamic> json){
    value = json['value'];
    unit = json['unit'];
    confidenceRange95Percent = ConfidenceRange95Percent.fromJson(json['confidenceRange95Percent']);
    standardDeviation = json['standardDeviation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['unit'] = unit;
    _data['confidenceRange95Percent'] = confidenceRange95Percent.toJson();
    _data['standardDeviation'] = standardDeviation;
    return _data;
  }
}

class Carbs {
  Carbs({
    required this.value,
    required this.unit,
    required this.confidenceRange95Percent,
    required this.standardDeviation,
  });
  late final double value;
  late final String unit;
  late final ConfidenceRange95Percent confidenceRange95Percent;
  late final double standardDeviation;

  Carbs.fromJson(Map<String, dynamic> json){
    value = json['value'];
    unit = json['unit'];
    confidenceRange95Percent = ConfidenceRange95Percent.fromJson(json['confidenceRange95Percent']);
    standardDeviation = json['standardDeviation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['unit'] = unit;
    _data['confidenceRange95Percent'] = confidenceRange95Percent.toJson();
    _data['standardDeviation'] = standardDeviation;
    return _data;
  }
}

class Category {
  Category({
    required this.name,
    required this.probability,
  });
  late final String name;
  late final double probability;

  Category.fromJson(Map<String, dynamic> json){
    name = json['name'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['probability'] = probability;
    return _data;
  }
}

class Recipes {
  Recipes({
    required this.id,
    required this.title,
    required this.imageType,
    required this.url,
  });
  late final int id;
  late final String title;
  late final String imageType;
  late final String url;

  Recipes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    imageType = json['imageType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['imageType'] = imageType;
    _data['url'] = url;
    return _data;
  }
}