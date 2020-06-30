
import 'dart:convert';

import 'package:coffeetest/coffeeitem.dart';
import 'package:coffeetest/main.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
with SingleTickerProviderStateMixin{

  Future<List<CoffeeItems>> getCoffeeItemsFromJSON(BuildContext context) async{
    String jsonString = await DefaultAssetBundle.of(context).loadString("assets/json_data/coffeeitem.json");
    List<dynamic> raw = jsonDecode(jsonString);
    return raw.map((f) => CoffeeItems.fromJSON(f)).toList();
  }


  int _currentIndex = 0;
  int _categoryIndex = 0;
  List<Coffee> coffeeList1 = List<Coffee>();
  List<Coffee> coffeeList2 = List<Coffee>();
  Category category1;
  Category category2;
  List<Category> categoryList = List<Category>();

  PageController _pageController = PageController(viewportFraction: 0.8);
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    this.coffeeList1.add(new Coffee(
        'images/coffee/coffee-1.png', 'Cappuccino', 'Lattesso', 29.0));
    this.coffeeList1.add(new Coffee(
        'images/coffee/coffee-7.png', 'Caffè Americano', 'Coffee 2', 99.0));
    this.coffeeList1.add(
        new Coffee('images/coffee/coffee-3.png', 'Espresso', 'Lattes', 49.0));
    this.coffeeList1.add(
        new Coffee('images/coffee/coffee-4.png', 'Robusta', 'Coffee 4', 19.0));
    this.coffeeList1.add(new Coffee(
        'images/coffee/coffee-5.png', 'Café Latte', 'Macchiatos', 199.0));
    this.coffeeList2.add(new Coffee(
        'images/coffee/coffee-6.png', 'Flat White', 'Coffee 6', 21.0));
    this.coffeeList2.add(new Coffee(
        'images/coffee/coffee-7.png', 'Short Macchiato', 'Dollop', 28.0));
    this.coffeeList2.add(
        new Coffee('images/coffee/coffee-8.png', 'Affogato', 'Coffee 8', 27.0));
    this.coffeeList2.add(
        new Coffee('images/coffee/coffee-9.png', 'Mocha', 'Coffee 9', 31.0));
    this.coffeeList2.add(new Coffee(
        'images/coffee/coffee-10.png', 'Ristretto', 'Coffee 10', 26.0));
    this.category1 = Category('Cappuccino', this.coffeeList1);
    this.category2 = Category('Americano', this.coffeeList2);
    this.categoryList.add(this.category1);
    this.categoryList.add(this.category2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Coffee> coffeeList = categoryList[_categoryIndex].coffeeList;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(238, 232, 232, 1)),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 50, left: 50, bottom: 20),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Coffee',
                        style: TextStyle(
                          fontSize: 37.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          for (var i = 0; i < coffeeList.length; i++)
                            _indicators(
                                context, coffeeList[i], i, _currentIndex)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: coffeeList.length,
                  itemBuilder: (context, index) =>
                      _pageItem(context, coffeeList, index),
                  pageSnapping: false,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            if (_categoryIndex == 0)
                              _categoryIndex = 1;
                            else if (_categoryIndex == 1) _categoryIndex = 0;
                          });
                        },
                        child: new Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 25.0,
                        ),
                        shape: new CircleBorder(),
                        color: Colors.white,
                        padding: EdgeInsets.all(16.0),
                      ),
                      FutureBuilder(
                        future: getCoffeeItemsFromJSON(context),
                        builder: (context, data) {
                          if(data.hasData){
                            List<CoffeeItems> coffeeItems = data.data;

                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: coffeeItems.length,
                                itemBuilder: (context, index){
                                  return ListTile(
                                    title: Text(coffeeItems[index].name),
                                    subtitle: Text(coffeeItems[index].price),
                                  );
                                }
                            );
                          }
                          else{
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget _indicators(context, Coffee coffee, int index, int currentIndex) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print('${coffee.title} indicator selected');
          },
          child: Container(
            width: index == currentIndex ? 16.0 : 5.0,
            height: 5.0,
            margin: EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: index == currentIndex ? Colors.black : Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ],
    );
  }

  Widget _priceWidget(price) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 40.0, maxWidth: 100.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                child: Text(
                  '₦',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  price,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageItem(context, List<Coffee> coffeeList, int index) {
    Coffee coffee = coffeeList[index];
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(80),
        ),
        child: InkWell(
          onTap: () {
            print('${coffee.title} is selected');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(coffee: coffee)));
          },
          child: Stack(
            children: <Widget>[
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.maxFinite,
                    alignment: Alignment.topRight,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    child: Wrap(
                      children: [
                        Image.asset(
                          coffee.url,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                coffee.category,
                                style: TextStyle(
                                    color: Color.fromRGBO(244, 194, 185, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(padding: const EdgeInsets.all(4)),
                              Text(
                                coffee.title,
                                style: TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              _priceWidget(coffee.price.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryItem(index) {
    return InkWell(
      onTap: () {
        setState(() {
          _categoryIndex = index;
          _pageController.jumpToPage(0);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Text(
          categoryList[index].title,
          style: TextStyle(
              fontWeight:
              _categoryIndex == index ? FontWeight.bold : FontWeight.normal,
              fontSize: _categoryIndex == index ? 22 : 18,
              color: _categoryIndex == index ? Colors.black : Colors.grey),
        ),
      ),
    );
  }
}

class Coffee {
  String url, category, title;
  double price;

  Coffee(this.url, this.category, this.title, this.price);

  @override
  String toString() {
    return "image ${this.url} -> category ${this.category} -> title ${this.title} -> price ${this.price}";
  }
}

class Category {
  String title;
  List<Coffee> coffeeList;

  Category(this.title, this.coffeeList);
}

