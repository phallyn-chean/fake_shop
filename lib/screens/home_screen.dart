import 'package:fake_store_app/models/article_model.dart';
import 'package:fake_store_app/screens/article_screen.dart';
import 'package:fake_store_app/services/api_service.dart';
import 'package:fake_store_app/widgets/categories_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _value = 0;
  List<String> CategoriesList = [
    "All",
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Fake Store App",
          style: GoogleFonts.ubuntuMono(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 140,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/svgviewer-png-output.png"), fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  CategoriesList.length,
                  (index) {
                    return MyRadioListTile(
                      value: index,
                      groupValue: _value,
                      leading: CategoriesList[index],
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder<List<ArticleModel>>(
            future: _value == 0
                ? ApiService.fetchArticle()
                : ApiService.fetchArticleByCategories(
                    CategoriesList[_value].toString(),
                  ),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return ArticleScreen(articleId: snapshot.data![index].id!);
                                }));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data![index].image!),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    snapshot.data![index].title!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.w700, color: Colors.black),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "\$${snapshot.data![index].price.toString()}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.ubuntuMono(color: const Color.fromARGB(255, 253, 104, 104), fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
