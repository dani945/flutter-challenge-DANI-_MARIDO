import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:infosyst/api/apiFuction.dart';
import 'package:infosyst/helper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List dataProduct = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  var cari = TextEditingController();
  bool isLoading = false;
  bool ishide = true;

  @override
  void initState() {
    super.initState();
    // getAllProductByCategory(widget.category);
  }

  // getAllProductByCategory(String category) async {
  //   dataProduct.clear();
  //   var res = await ApiFunction().getAllProductByCategory(category);
  //   res["products"].forEach((el) {
  //     setState(() {
  //       dataProduct.add(el);
  //     });
  //   });
  // }

  seacrhItem(String value) async {
    setState(() {
      isLoading = true;
    });

    if (value.isNotEmpty) {
      setState(() {
        ishide = false;
        dataProduct.clear();
      });

      var res = await ApiFunction().searchItem(value);
      res["products"].forEach((el) {
        setState(() {
          isLoading = false;
          dataProduct.add(el);
        });
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          ishide = true;
          isLoading = false;
          dataProduct.clear();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: cari,
              onChanged: (value) {
                seacrhItem(value);
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: ishide
                      ? const SizedBox.shrink()
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              cari.text = "";
                              dataProduct.clear();
                              ishide = true;
                            });
                            // getAllProductByCategory(widget.category);
                          },
                        ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    for (var i = 0; i < dataProduct.length; i++)
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CarouselSlider(
                              items: dataProduct[i]["images"]
                                  .map<Widget>((item) => Container(
                                        child: Container(
                                          margin: const EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                              child: Stack(
                                                children: <Widget>[
                                                  Image.network(
                                                    item,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Positioned(
                                                    bottom: 0.0,
                                                    left: 0.0,
                                                    right: 0.0,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(
                                                                200, 0, 0, 0),
                                                            Color.fromARGB(
                                                                0, 0, 0, 0)
                                                          ],
                                                          begin: Alignment
                                                              .bottomCenter,
                                                          end: Alignment
                                                              .topCenter,
                                                        ),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 20.0),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ))
                                  .toList(),
                              carouselController: _controller,
                              options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 2.0,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                            ),
                            // CarouselSlider(
                            //   options: CarouselOptions(
                            //     height: MediaQuery.of(context).size.height * 0.3,
                            //     viewportFraction: 1.0,
                            //     enlargeCenterPage: false,
                            //     // autoPlay: false,
                            //   ),
                            //   items: dataProduct[i]["images"]
                            //       .map<Widget>((item) => Center(
                            //               child: Image.network(
                            //             item,
                            //             fit: BoxFit.fill,
                            //             height:
                            //                 MediaQuery.of(context).size.height *
                            //                     0.3,
                            //           )))
                            //       .toList(),
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  dataProduct[i]["title"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Price : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.grey),
                                ),
                                Expanded(
                                    child: Text(
                                  dataProduct[i]["price"].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.red),
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text(dataProduct[i]["description"])),
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Persentase Diskon",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "${dataProduct[i]["discountPercentage"].toString()} %",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          color: Colors.grey),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      dataProduct[i]["rating"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          color: Colors.grey),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Stok",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      dataProduct[i]["stock"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          color: Colors.grey),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                      )
                  ],
                ),
        ),
      ),
    );
  }
}
