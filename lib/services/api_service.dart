import 'package:dio/dio.dart';
import 'package:fake_store_app/constants/api_constant.dart';
import 'package:fake_store_app/models/article_model.dart';

class ApiService {
  var dio = Dio();

  static Future<List<ArticleModel>> fetchArticle() async {
    Response response = await Dio().get(ApiConstants.APIARTICLE);
    return (response.data as List).map((json) => ArticleModel.fromJson(json)).toList();
  }

  static Future<List<ArticleModel>> fetchArticleByCategories(String categoriesname) async {
    Response response = await Dio().get("${ApiConstants.APIARTICLEBYCATEGORIE}$categoriesname");
    return (response.data as List).map((json) => ArticleModel.fromJson(json)).toList();
  }

  static Future<ArticleModel> fetchArticleById(int articleId) async {
    Response response = await Dio().get("${ApiConstants.APIARTICLEBYID}$articleId");

    ArticleModel articleModel = ArticleModel.fromJson(response.data);
    return articleModel;
  }
}
