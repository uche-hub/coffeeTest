import 'package:flutter/material.dart';

class CoffeeCard extends StatelessWidget {
  final coffeeName;
  final coffeeImage;
  final coffeePrice;
  final coffeeSubtext;

  CoffeeCard({Key key, this.coffeeName, this.coffeeImage, this.coffeePrice, this.coffeeSubtext}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    /// Builds a widget tree that can depend on the parent widget's size.
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var containerWidth = constraints.maxWidth;
          var containerHeight = constraints.maxHeight;
          print(containerWidth);
          print(containerHeight);
          return Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(right:15.0),
                width: 280,
                height: 380,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(45),
                  ),
                ),
              ),
              /// A widget that clips its child using a rounded rectangle.
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
                child: Image.asset(
                  coffeeImage,
                  width: 280,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: 45,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      coffeeName,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Text(
                      coffeeSubtext,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          wordSpacing: 1.4),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: containerHeight / 90,
                right: containerWidth / 15,
                child: Container(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text:"₦",style:TextStyle(
                                color: Color.fromRGBO(146, 144, 148,1)
                            ),
                            ),
                            TextSpan(
                                text: coffeePrice,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)
                            )
                          ]
                      ),
                    ),
                  ),
                  width: 65,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 34, 40, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}
