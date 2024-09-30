import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/model/categoriesmodel.dart';
import 'package:news/model/newsheadlinesmodel.dart';
import 'package:news/view/detailscreen.dart';
import 'package:news/view/categories.dart';
import 'package:news/viewmodel/viewnewsmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ignore: camel_case_types, constant_identifier_names
enum filterList { BBC, ARY, AlJazeera, CNN, Reuters }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM, yy');
  filterList? selectedMenu;
  String newsSource = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<filterList>(
              initialValue: selectedMenu,
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (filterList item) {
                setState(() {
                  selectedMenu = item;
                  switch (item) {
                    case filterList.BBC:
                      newsSource = 'bbc-news';
                      break;
                    case filterList.ARY:
                      newsSource = 'ary-news';
                      break;
                    case filterList.AlJazeera:
                      newsSource = 'al-jazeera-english';
                      break;
                    case filterList.CNN:
                      newsSource = 'cnn';
                      break;
                    case filterList.Reuters:
                      newsSource = 'reuters';
                      break;
                  }
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<filterList>>[
                    const PopupMenuItem<filterList>(
                      value: filterList.BBC,
                      child: Text('BBC News'),
                    ),
                    const PopupMenuItem<filterList>(
                      value: filterList.ARY,
                      child: Text('ARY News'),
                    ),
                    const PopupMenuItem<filterList>(
                      value: filterList.AlJazeera,
                      child: Text('Al-Jazeera'),
                    ),
                    const PopupMenuItem<filterList>(
                      value: filterList.CNN,
                      child: Text('CNN News'),
                    ),
                    const PopupMenuItem<filterList>(
                      value: filterList.Reuters,
                      child: Text('Reuters News'),
                    ),
                  ])
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Categoriesview()));
          },
          icon: Image.asset(
            'assets/images/category.png',
            height: 25,
            width: 25,
          ),
        ),
        title: Center(
            child: Text('NEWS App',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w700))),
      ),
      body: ListView(
        children: [
          FutureBuilder<newsheadlinesmodel>(
              future: newsViewModel.fetchnewsheadlines(newsSource),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(child: Text("Error loading news data"));
                } else {
                  return SizedBox(
                    height: height * 0.55,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime datetime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detailscreen(
                                            newsImage: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .urlToImage ??
                                                'No Image found',
                                            title: snapshot.data!
                                                    .articles![index].title ??
                                                'No Title found',
                                            newsDate: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .publishedAt ??
                                                'No Date found',
                                            author: snapshot.data!
                                                    .articles![index].author ??
                                                'No Author found',
                                            description: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .description ??
                                                'No Description found',
                                            source: snapshot.data!
                                                .articles![index].source!.name
                                                .toString(),
                                            content: snapshot.data!
                                                    .articles![index].content ??
                                                'No Content found',
                                          )));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      height: height * 0.55,
                                      width: width * 0.8,
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => spinkit2,
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                              Icons.error_outline_outlined,
                                              color: Colors.red),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height: height * 0.22,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * 0.7,
                                            padding: const EdgeInsets.all(15),
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(snapshot.data!
                                                    .articles![index].author
                                                    .toString()),
                                                Text(format.format(datetime)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FutureBuilder<CategoriesModel>(
                future: newsViewModel.fetchCategory('General'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                        child: Text("Error loading categories"));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime datetime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: CachedNetworkImage(
                                    height: height * 0.18,
                                    width: width * 0.3,
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => spinkit2,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error_outline_outlined,
                                            color: Colors.red),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            format.format(datetime),
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  final spinkit2 = const SpinKitCircle(
    color: Colors.redAccent,
    size: 50.0,
  );
}
