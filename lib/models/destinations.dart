class Product {
  final int id, price;
  final String title, description, image;
  final double latitude, longitude;

  Product({this.id, this.price, this.title, this.description, this.image, this.latitude, this.longitude});
}

// list of products
// for our demo
List<Product> products = [
  Product(
    id: 1,
    price: 56,
    title: "Pharping Hydropower Station",
    image: "assets/images/farping_1.jpg",
    latitude: 27.613207 ,
    longitude: 85.289071 ,
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Product(
    id: 4,
    price: 68,
    title: "Kulekhani Hydropower Station",
    image: "assets/images/kulekhani_1.jpg",
    latitude: 27.608369,
    longitude: 85.157746,
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Product(
    id: 9,
    price: 39,
    title: "Bojini Hydropower Station",
    image: "assets/images/bojini_1.jpg",
    latitude: 37.726151,
    longitude: -122.419375,
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Product(
    id: 10,
    price: 120,
    title: "Modi Khola Hydroelectric Power Plant",
    image: "assets/images/modi_1.jpg",
    latitude: 28.272699,
    longitude: 83.741127,
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
];

