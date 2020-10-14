class Category {
  final String name;
  final int numOfCourses;
  final String image;

  Category(this.name, this.numOfCourses, this.image);
}

List<Category> categories = categoriesData
    .map((item) => Category(item['name'], item['courses'], item['image']))
    .toList();

var categoriesData = [
  {"name": "तोकिएको", 'courses': 17, 'image': "assets/images/marketing.png"},
  {"name": "नयाँ तोक्नुहोस्", 'courses': 25, 'image': "assets/images/ux_design.png"},
  {
    "name": " विवरण थप ",
    'courses': 13,
    'image': "assets/images/photography.png"
  },
  {"name": "हाजिरी गरिएका", 'courses': 4, 'image': "assets/images/all_logs.png"},
  {"name": "ईतिहास विवरणहरू", 'courses': 17, 'image': "assets/images/business.png"},

];