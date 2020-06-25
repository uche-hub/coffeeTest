import 'dart:io';
import 'package:coffeetest/cardview/coffee_card.dart';
import 'package:coffeetest/coffeeModel/coffee-model.dart';
import 'package:coffeetest/main.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  PageController _controller = PageController(initialPage: 0, viewportFraction: 0.75);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffede7e6),
      /// SafeArea is basically a glorified Padding widget.
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            /// crossAxisAlignment defines how the children are aligned horizontally in that Column.
            /// mainAxisAlignment in a Column aligns its children vertically.
            /// spaceEvenly Divides the extra space evenly between children and before and after the children.
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                /// Creates insets with only the given values non-zero.
                padding: EdgeInsets.only(top: 50.0, left: 50.0),
                child: Text(
                  "Select",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text(
                  "Coffee",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2
                  ),
                ),
              ),
              /// To give space in between
              SizedBox(height: 60,),
              Center(
                child: Container(
                  height: 400,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: CoffeeList.coffeeList.length,
                    itemBuilder: (context, index){
                      Coffee coffee = CoffeeList.coffeeList[index];
                      /// Pass Coffee Data
                      var name = coffee.coffeeName;
                      var image = coffee.coffeeImage;
                      var price = coffee.coffeePrice;
                      /// A widget that detects gestures.
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return MyHomePage(coffeeName: name, coffeeImage: image, coffeePrice: price,);
                            }
                          ));
                        },
                        child: CoffeeCard(
                            coffeeName: name,
                            coffeeImage: image,
                            coffeePrice: price,
                            coffeeSubtext: coffee.coffeesubText
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
