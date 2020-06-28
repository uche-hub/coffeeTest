import 'package:coffeetest/cardview/coffee_card.dart';
import 'package:coffeetest/categoryModel/category_model.dart';
import 'package:coffeetest/coffeeModel/coffee-model.dart';
import 'package:coffeetest/helper/data.dart';
import 'package:coffeetest/main.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  /// calling the list from CategoryModel
  List<CategoryModel> categories = new List<CategoryModel>();

  /// Calling current pageView
  int _currentPage = 0;
  PageController _controller = PageController(initialPage: 0, viewportFraction: 0.75);

  /// to provide list
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
  }

  _onChanged(int index){
    setState(() {
      _currentPage = index;
    });
  }
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
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List<Widget>.generate(CoffeeList.coffeeList.length, (int index){
                      return AnimatedContainer(
                        duration: Duration(microseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == _currentPage) ? Colors.grey : Colors.grey.withOpacity(0.5)
                        ),
                      );
                    })
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: 400,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: CoffeeList.coffeeList.length,
                    onPageChanged: _onChanged,
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
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 70,
                  child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategoryTile(
                        categoryName: categories[index].categoryName
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

class CategoryTile extends StatelessWidget {
  final String categoryName;
  CategoryTile({this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return HomeView();
            }
        ));
      },
      child: Container(
        width: 120, height: 60,
        alignment: Alignment.center,
        child: Text(
          categoryName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w800
          ),
        ),
      ),
    );
  }
}

