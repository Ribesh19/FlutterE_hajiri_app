import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/models/Assigned.dart';
import 'package:e_hajiri_app/models/destinations.dart';
import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({
    Key key,
    this.itemIndex,
  //  this.product,
    this.assigned,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  //final Product product;
  final Assigned assigned;
  final Function press;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      //  color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            //Those are our background
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                //  color: kBlueColor,
                color: itemIndex.isEven ? kBlueColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22)),
              ),
            ),
            // our product image
          Positioned(
              right: 10,
            child:
            ClipRRect(
              // top: 24,
              borderRadius: BorderRadius.circular(22),
              child: Container(
                //margin: EdgeInsets.only(right: 10),
                //padding: EdgeInsets.symmetric(horizontal:  kDefaultPadding),
                padding: EdgeInsets.only(
                  left: kDefaultPadding * 2,
                ),
                height: 136,
                width: 180,
                child: //Image.asset(
                      Image.network(
                    //"assets/images/Item_1.png",
                   // product.image,
                    assigned.imageurl,
                    // fit: BoxFit.cover,
                    fit: BoxFit.cover),
              ),
            )
          ),
            //Product title and price'
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image takes 200 width, thats why we set out total width -200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                       // product.title,
                          assigned.destinationname,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    //it uses the available space
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5, // 30 padding
                          vertical: kDefaultPadding / 4 // 5 top and bottom
                          ),
                      decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              topRight: Radius.circular(22))),
                      child: Text(
                        // "\$58",
                        assigned.date,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
