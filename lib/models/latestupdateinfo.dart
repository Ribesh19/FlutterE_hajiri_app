class Update {
  final String number;
  final String Date;
  final String  name;
  final String title;
  final bool isDone;

  Update({this.number, this.Date, this.title, this.isDone = false, this.name});
}



// list of products
// for our demo
List<Update> updates = [
  Update(
    number: "01",
    name: "Ribesh Maharjan",
    title: "Melamchi HydroPower Station",
    isDone: true,
    Date: "2077/05/03",
),
  Update(
    number: "02",
    name: "Max Lambertini",
    title: "Kaligandaki HydroPower Plant",
    isDone: true,
    Date: "2077/04/30",
 ),
  Update(
    number: "03",
    name: "Piotr Badura",
    title: "SunKoshi HydroPower Station",
    isDone: false,
    Date: "2077/05/02",
),
  Update(
    number: "04",
    name: "Ubaid Ifikhar",
    title: "Pharphing HydroPower Station",
    isDone: false,
    Date: "2077/04/32",
),
  Update(
    number: "05",
    name: "Umair Mirza",
    title: "Koshi HydroPower Station",
    isDone: true,
    Date: "2077/05/02",
  ),
  Update(
    number: "06",
    name: "Anup Prajapati",
    title: "Modi Khola HydroPower Plant",
    isDone: true,
    Date: "2077/04/31",
  ),
];

