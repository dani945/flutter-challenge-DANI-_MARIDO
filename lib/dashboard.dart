import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:infosyst/api/apiFuction.dart';
import 'package:infosyst/listProductPage.dart';
import 'package:infosyst/searchPage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage(
      {super.key,
      required this.image,
      required this.firstname,
      required this.lastname,
      required this.email});
  final String image;
  final String firstname;
  final String lastname;
  final String email;

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  List dataCategory = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    super.initState();
    getAllProductCategory();
  }

  getAllProductCategory() async {
    dataCategory.clear();
    var res = await ApiFunction().getAllProductCategory();
    res.forEach((el) {
      setState(() {
        dataCategory.add(el);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(children: [
              Image.asset("assets/header-login.png"),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5, // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            widget.image,
                            height: 100,
                            width: 100,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${widget.firstname} ${widget.lastname}"),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(widget.email)
                  ],
                ),
              )
            ]),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5, // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchPage()));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5, // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                      ),
                    ),
                    for (var i = 0; i < dataCategory.length; i++)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListProductPage(
                                        category: dataCategory[i],
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.width * 0.25,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5, // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                              child: Text(
                            dataCategory[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                          )),
                        ),
                      )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
