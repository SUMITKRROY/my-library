import 'dart:async';

import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  Map<String, dynamic> product = {
    "first_cry": {
      "banner": [
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/banners/mktng_hp_jumbo_30may1685443022037.webp"
        },
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/banners/hp_desktop1685524018623.gif"
        },
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/banners/mktng_hp_mes_31may231685362621206.webp"
        },
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/banners/baby_hug_cpid_hp_new_may_1685518261072.webp"
        },
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/banners/slurrpfarm_hp_mkt_po3_all_slur401684394000830.webp"
        },
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/banners/mkng_hp_mes_1june231685522438900.webp"
        }
      ],
      "PREMIUM_BOUTIQUES": [
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/images/boutique/670x670/29975.webp",
          "title": "Slay All Day | 4-14Y",
          "subtitle": "Frocks, Dresses & More",
          "day": "NEW TODAY"
        },
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/images/boutique/670x670/29976.webp",
          "title": "What's Trending In Kids Fashion | Up To 24M",
          "subtitle": "Onesies, Rompers, Tops, Sets & more",
          "day": "NEW TODAY"
        },
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/images/boutique/670x670/29981.webp",
          "title": "Happy Feeding",
          "subtitle": "",
          "day": "NEW TODAY"
        },
        {
          "img_url":
          "https://cdn.fcglcdn.com/brainbees/images/boutique/670x670/29977.webp",
          "title": "Fashion at Play | 3-14Y",
          "subtitle": "Tops, Tees, Bottoms & more",
          "day": "NEW TODAY"
        }
      ]
    }
  };

  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < product['first_cry']['banner'].length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => MyBottomNavBarScreen()),
                  // );
                },
                child: Image.network(
                  'https://cdn.fcglcdn.com/brainbees/images/n/fc_logo.png',
                  height: 70,
                  width: 70,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for a Category, Brand or Product',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Perform search action
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),child:
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(

                      height: height*0.23,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: product['first_cry']['banner'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(
                                child: Image.network(product['first_cry']['banner'][index]['img_url'],

                                  fit: BoxFit.cover,),
                              ),
                            ],
                          );
                        },
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "PREMIUM BOUTIQUES",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              SizedBox(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // Number of columns in the grid
                    childAspectRatio: 0.75,
                  ),
                  shrinkWrap: true,
                  itemCount: 4,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
// Handle item tap event
// You can navigate to a detailed view or perform any other action
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(
                              product['first_cry']["PREMIUM_BOUTIQUES"][index]['img_url'],

                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              title: Text(product['first_cry']["PREMIUM_BOUTIQUES"][index]['title']),
                              subtitle: Text(product['first_cry']["PREMIUM_BOUTIQUES"][index]['subtitle']),
                              trailing: Text(
                                product['first_cry']["PREMIUM_BOUTIQUES"][index]['day'],
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
        )
    );
  }
}