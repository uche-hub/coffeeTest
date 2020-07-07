import 'dart:convert';

import 'package:coffeetest/Screen/MyHomePage.dart';
import 'package:coffeetest/main.dart';
import 'package:coffeetest/models/cafe.dart';
import 'package:coffeetest/models/category.dart';
import 'package:coffeetest/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  int _currentIndex = 0;
  int _categoryIndex = 0;
  Cafe _cafe;
  List<Coffee> _coffeeList = List<Coffee>();
  Category _category;
  PageController _pageController = PageController(viewportFraction: 0.8);


  @override
  void initState() {
    super.initState();
  }

  Future<String> _loadAsset() async {
    return await Future.delayed(
        const Duration(seconds: 3), () => rootBundle.loadString('coffeeitem.json'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 231, 231, 1),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(238, 232, 232, 1)),
        child: FutureBuilder<String>(
          future: _loadAsset(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              _cafe = Cafe.fromJson(json.decode(snapshot.data));
              _category = _cafe.categories[_categoryIndex];
              _coffeeList = _cafe.categories[_categoryIndex].coffeeList;

              return Column(
                children: <Widget>[
                  Container(
                    padding:
                    const EdgeInsets.only(top: 50, left: 50, bottom: 20),
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
                                for (var i = 0; i < _coffeeList.length; i++)
                                  _indicators(
                                      context, _coffeeList[i], i, _currentIndex)
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
                        itemCount: _coffeeList.length,
                        itemBuilder: (context, index) =>
                            _pageItem(context, _coffeeList, index),
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
                                    _categoryIndex++;
                                  else if (_categoryIndex >=
                                      _cafe.categories.length - 1)
                                    _categoryIndex--;
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
                            LayoutBuilder(
                              builder: (context, constraints) => Container(
                                width: 300,
                                height: 50,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _cafe.categories.length,
                                    itemBuilder: (context, index) =>
                                        _categoryItem(index)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ],
                ),
              );
            }
          },
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

            Navigator.pushNamed(
                context,
                DetailScreen.routeName,
                arguments: coffee
            );
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
          _cafe.categories[index].name,
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