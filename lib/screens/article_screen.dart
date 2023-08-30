import 'package:fake_store_app/models/article_model.dart';
import 'package:fake_store_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key, required this.articleId});

  final int articleId;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Article Details",
          style: GoogleFonts.ubuntuMono(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<ArticleModel>(
        future: ApiService.fetchArticleById(widget.articleId),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data!.image!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.ubuntuMono(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.category.toString(),
                                style: GoogleFonts.ubuntuMono(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 202, 184, 20),
                                  ),
                                  Text(
                                    snapshot.data!.rating!.rate.toString(),
                                    style: GoogleFonts.ubuntuMono(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "(${snapshot.data!.rating!.count.toString()} Reviews)",
                                    style: GoogleFonts.ubuntuMono(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black45,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Information",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.ubuntuMono(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data!.description!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                            style: GoogleFonts.ubuntuMono(
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${snapshot.data!.price!.toString()}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.ubuntuMono(color: Colors.black, fontSize: 23, fontWeight: FontWeight.w800),
                            ),
                            Container(
                              alignment: Alignment.center,
                              color: const Color(0xff0F172A),
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                              child: Text(
                                "+ Add To Cart",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.ubuntuMono(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
