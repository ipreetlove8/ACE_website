// import 'dart:html';

import 'dart:async';

import 'package:ace/notice/services.dart';
import 'package:ace/theme/app_theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../notice/model.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<DataModel> _notices;
  List<DataModel> _departments;
  List<DataModel> _facilities;
  List<DataModel> _crasoul;
  getData() async {
    _crasoul = await DataServices.table(tableName: "Crausal").getNotices();
    _notices = await DataServices.table(tableName: "Notices").getNotices();
    _departments =
        await DataServices.table(tableName: "Departments").getNotices();
    _facilities =
        await DataServices.table(tableName: "Facilities").getNotices();

// get Data First
    setState(() {});
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        leading: Image.asset("assets/images/favicon.png"),
        title: Text(
          "Ambala College Of Engineering And Applied Research.",
          style: TextStyle(
              // color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Consumer<AppThemeProvider>(
            builder: (context, AppThemeProvider themeProvider, child) {
              return Transform.scale(
                scale: 2,
                child: Switch(
                    inactiveThumbImage: AssetImage("assets/images/sun.png"),
                    activeThumbImage: AssetImage("assets/images/moon.png"),
                    activeTrackColor: Colors.cyanAccent,
                    inactiveTrackColor: Colors.grey,
                    value: themeProvider.currentThemeMode == AppThemeMode.Dark,
                    onChanged: (v) {
                      themeProvider.toggleTheme();
                    }),
              );
            },
          ),
          SizedBox(
            width: 50,
          ),
        ],
        // backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          Crausal(
            listData: _crasoul,
          ),
          SizedBox(
            height: 15,
          ),
          TitleList(title: "Notices", listData: _notices),
          SizedBox(
            height: 15,
          ),
          DescriptionView(),
          SizedBox(
            height: 15,
          ),
          TitleList(title: "Departments", listData: _departments),
          SizedBox(
            height: 15,
          ),
          TitleList(title: "Facilities", listData: _facilities),
          SizedBox(
            height: 15,
          ),
          DetailView(),
          SizedBox(
            height: 15,
          ),
          SocialLinkView(),
          SizedBox(
            height: 15,
          ),
          CreatorView(),
        ],
      ),
    );
  }
}

class TitleList extends StatelessWidget {
  TitleList({Key key, @required this.title, @required this.listData})
      : super(key: key);

  final String title;

  final List<DataModel> listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      // color: Colors.lime,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40),
          ),
          Expanded(
            child: listData != null
                ? listData.length > 0
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: DataCard(listData[index]),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "$title Not Found!",
                          style: TextStyle(
                              // color: Colors.white,
                              fontSize: 25),
                        ),
                      )
                : Center(
                    child: Text(
                      "Loading.....",
                      style: TextStyle(
                          // color: Colors.white,
                          fontSize: 25),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class DataCard extends StatefulWidget {
  final DataModel data;
  DataCard(this.data);

  @override
  _DataCardState createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SecondView(
                      data: widget.data,
                    )));
      },
      onHover: (v) {
        setState(() {
          isOn = v;
        });
      },
      child: Transform.scale(
        scale: isOn ? 0.98 : 1,
        child: Container(
          // color: Colors.deepOrangeAccent,
          width: 350,
          child: Card(
            // color: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                if (widget.data.imageUrl != null)
                  Expanded(
                    child: Hero(
                      tag: widget.data.imageUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          widget.data.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "${widget.data.name}",
                        style: TextStyle(
                            // color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     "${widget.data.shortDes}",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                    // TextButton(
                    //   onPressed: () async {
                    //     if (await canLaunch(widget.data.pdfUrl)) {
                    //       launch(widget.data.pdfUrl);
                    //     }
                    //   },
                    //   child: Text("Notice PDF"),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondView extends StatelessWidget {
  final DataModel data;
  SecondView({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.purple,
          title: Text(
            "Details Screen",
            style: TextStyle(
                // color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          // color: Colors.purpleAccent,

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                if (data.imageUrl != null)
                  Hero(
                    tag: data.imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        data.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                // Text(
                //   "",
                //   style: TextStyle(
                //       // color: Colors.white,
                //       fontSize: 35,
                //       fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                Center(
                  child: Text(
                    data.name,
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Short Description:",
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data.shortDes,
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Long Description:",
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data.longDes,
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ));
  }
}

class Crausal extends StatefulWidget {
  Crausal({@required this.listData});

  final List<DataModel> listData;

  @override
  _CrausalState createState() => _CrausalState();
}

class _CrausalState extends State<Crausal> {
  final PageController _pageController = PageController();
  int currentPageIndex = 0;
  bool isForward = true;
  crasualTimer() {
    Timer.periodic(Duration(seconds: 6), (timer) {
      if (_pageController != null) {
        if (isForward) {
          _pageController.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        } else {
          _pageController.previousPage(
              duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        }
        if (currentPageIndex == widget.listData.length - 1) {
          setState(() {
            isForward = false;
          });
        } else if (currentPageIndex == 0) {
          setState(() {
            isForward = true;
          });
        }
      }
    });
  }

  @override
  void initState() {
    crasualTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listData != null) {
      return Container(
        height: 350,
        width: 600,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.listData.length,
                  onPageChanged: (int i) {
                    if (i != currentPageIndex) {
                      setState(() {
                        currentPageIndex = i;
                      });
                    }
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      child: Image.network(
                        widget.listData[index].imageUrl,
                        // fit: BoxFit.fill,
                        loadingBuilder:
                            (context, child, ImageChunkEvent progress) {
                          if (progress == null) {
                            return child;
                          }
                          return Center(
                              child: ShemierEffect(
                            primaryColors: Colors.cyanAccent,
                            secondaryColors: Colors.black,
                            duration: Duration(seconds: 2),
                            child: Text(
                              "Loading....",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ));
                        },
                      ),
                    );
                    // return Container(
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       fit: BoxFit.scaleDown,
                    //       image: NetworkImage(listData[index].imageUrl,),
                    //     ),
                    //   ),
                    // );
                  }),
            ),
            Container(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.listData.length; i++)
                    GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(i,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color:
                              currentPageIndex == i ? Colors.cyan : Colors.grey,
                        ),
                        margin: EdgeInsets.all(5),
                        height: 10,
                        width: 10,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

class DescriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.purple,
      color: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            "Ambala College Of Engineering and Applied Research Devsthali\n"
            "Ambala Cantt – Jagadhari Road\n"
            "P.O. Sambhalkha Ambala,Haryana,India. Pin – 133 101.\n"
            "Degree: B.Tech\n"
            "Specializations Offered (18)\n"
            "Specializations\n"
            "Chemical stream: Biotechnology Engineering\n"
            "Computer Stream: Computer Science Engineering\n"
            "Electronics Stream: Electronics & Communication Engineering\n"
            "Mechanical Stream: Mechanical Engineering",
            style: TextStyle(
                // color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.purple,
      color: Colors.black26,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "Address:"
              "\nAmbala College Of Engineering and Applied Research Devsthali"
              "\nAmbala Cantt – Jagadhari Road, P.O. Sambhalkha"
              "\nAmbala,Haryana,India. Pin – 133 101."
              "\nAdmission Office Address:"
              "\nShop No. 19, Science Market, Opp. Hargolal Dharamshala, Ambala Cantt-133001"
              "\nEmail: info@ambalacollege.com"
              "\nContact Numbers:"
              "\n99960-31315 ,"
              "\n0171-2822002 ,0171-2828416,"
              "\n9996815503 ,9896266033 ,"
              "\n8000007983.",
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialLinkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 300,
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              child: Center(
            child: TextButton(
              onPressed: () async {
                const url = 'http://www.ambalacollege.com/';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'could not launch';
                }
              },
              child: Image.asset(
                'assets/images/favicon.png',
                height: 80,
                width: 80,
              ),
            ),
          )),
          Container(
              child: Center(
            child: TextButton(
              onPressed: () async {
                const url = 'https://www.facebook.com/ambalacollege/';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'could not launch';
                }
              },
              child: Image.asset(
                'assets/images/logo1.png',
                height: 80,
                width: 80,
              ),
            ),
          )),
          // Container(
          //     child: Image.asset(
          //   'assets/images/logo2.png',
          //   height: 50,
          //   width: 50,
          // )),
          // SizedBox(
          //   width: 10,
          // ),
          Container(
              child: Center(
            child: TextButton(
              onPressed: () async {
                const url =
                    'https://www.youtube.com/channel/UCZrYJuupM8NOvZ6EjQO6MrQ';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'could not launch';
                }
              },
              child: Image.asset(
                'assets/images/logo3.png',
                height: 150,
                width: 50,
              ),
            ),
          )),
          // Container(
          //     child: Center(
          //   child: TextButton(
          //     onPressed: () async {
          //       const url =
          //           'mailto:info@ambalacollege.com?subject=hello&body=It Is Awesome';
          //       if (await canLaunch(url)) {
          //         await launch(url);
          //       } else {
          //         throw 'could not launch';
          //       }
          //     },
          //     child: Image.asset(
          //       'assets/images/logo5.png',
          //       height: 90,
          //       width: 90,
          //     ),
          //   ),
          // )),
          Container(
              child: Center(
            child: TextButton(
              onPressed: () async {
                const url =
                    'https://www.google.com/maps/place/Ambala+College+of+Engineering+and+Applied+Research/@30.300762,76.930096,15z/data=!4m5!3m4!1s0x0:0x633afe83edecc5bf!8m2!3d30.3007621!4d76.9300956?hl=en-IN';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'could not launch';
                }
              },
              child: Image.asset(
                'assets/images/logo4.png',
                height: 110,
                width: 95,
              ),
            ),
          )),
          // Container(
          //     child: Center(
          //   child: TextButton(
          //     onPressed: () async {
          //       const url =
          //           'https://www.linkedin.com/authwall?trk=gf&trkInfo=AQFuu9a0qvosSwAAAXlMB7SgTQ4E4EEyMUnErjYjFv3u8jZSGC_F9j3S7KCjrDTmecm6tWN9Xf-0Jj8UtSnmdR0OZn4Hh8DFMOmZVzZWqt4GcR3fdHKKfREfsbHfFGSSI90qcxM=&originalReferer=https://www.google.com/&sessionRedirect=https%3A%2F%2Fin.linkedin.com%2Fschool%2Fambala-college-of-engineering-%2526-applied-research';
          //       if (await canLaunch(url)) {
          //         await launch(url);
          //       } else {
          //         throw 'could not launch';
          //       }
          //     },
          //     child: Image.asset(
          //       'assets/images/logo8.png',
          //       height: 110,
          //       width: 95,
          //     ),
          //   ),
          // )),
        ],
      ),
    );
  }
}

class CreatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black26,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Created By CodeWithPreet',
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

class ShemierEffect extends StatefulWidget {
  final Widget child;
  final Color primaryColors;
  final Color secondaryColors;
  Duration duration;
  ShemierEffect(
      {this.child,
      this.primaryColors = Colors.yellow,
      this.secondaryColors = Colors.white,
      this.duration}) {
    if (duration == null) {
      duration = Duration(milliseconds: 2000);
    }
  }
  @override
  _ShemierEffectState createState() => _ShemierEffectState();
}

class _ShemierEffectState extends State<ShemierEffect>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween(begin: 0.0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});

        if (_animation.status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              _animation.value - 0.1,
              _animation.value,
              _animation.value + 0.6
            ],
            colors: [
              widget.primaryColors,
              widget.secondaryColors,
              widget.primaryColors,
            ]).createShader(rect);
      },
      child: widget.child,
    );
  }
}
