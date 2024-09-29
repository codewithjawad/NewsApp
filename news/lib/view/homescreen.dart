import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/model/newsheadlinesmodel.dart';
import 'package:news/viewmodel/viewnewsmodel.dart';
import 'package:intl/intl.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Viewnewsmodel view = Viewnewsmodel();
  final format = DateFormat('MMMM dd,yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/category.png',
              height: 30,
              width: 30,
            ),
          ),
          title: Center(
            child: Text(
              "News App",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w700),
            ),
          )),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.50,
            width: width * 1,
            child: FutureBuilder<newsheadlinesmodel>(
              future: view.fetchnewsheadlines(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SpinKitCircle(
                    size: 50,
                    color: Colors.blue,
                  ));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime datetime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return Stack(
                        children: [
                          Container(
                              height: height * 0.60,
                              width: width * 0.9,
                              padding: EdgeInsets.symmetric(
                                horizontal: height * 0.02,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const SpinKitCircle(
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              )),
                          Positioned(
                            bottom: 10,
                            left: 25,
                            width: width * 0.75,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SizedBox(
                                height: height * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Text(
                                          snapshot.data.articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles![index].author
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                            ),
                                          ),
                                          const Spacer(),
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
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
