import 'package:wideal/model/dprint.dart';
import 'package:wideal/config/api.dart';
import 'package:wideal/model/server/mainwindowdata.dart';
import 'package:wideal/model/server/secondstep.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestaurantData {
  // var _currentId = "";
  // ResponseRestaurant _currentRet;

  get(String id, Function(ResponseRestaurant) callback,
      Function(String) callbackError) async {
    // if (_currentId == id)
    //   return callback(_currentRet);

    try {
      var url = "${serverPath}getRestaurant?restaurant=$id";
      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': "application/json",
      }).timeout(const Duration(seconds: 30));

      dprint(url);
      dprint('Response status: ${response.statusCode}');
      dprint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResult = json.decode(response.body);
        if (jsonResult['error'] == '0') {
          ResponseRestaurant ret = ResponseRestaurant.fromJson(jsonResult);
          // _currentId = id;
          // _currentRet = ret;
          callback(ret);
        } else
          callbackError("error=${jsonResult['error']}");
      } else
        callbackError("statusCode=${response.statusCode}");
    } catch (ex) {
      callbackError(ex.toString());
    }
  }
}

class ResponseRestaurant {
  String error;
  String currency;
  String ver;
  List<DishesData> foods;
  Restaurants? restaurant;
  List<BannerData> banner1;
  List<CategoriesData> categories;
  List<RestaurantsReviewsData> restaurantsreviews;
  ResponseRestaurant(
      {required this.error,
      required this.foods,
      required this.currency,
      required this.restaurant,
      required this.categories,
      required this.restaurantsreviews,
      required this.banner1,
      required this.ver});
  factory ResponseRestaurant.fromJson(Map<String, dynamic> json) {
    List<DishesData> m = [];
    if (json['foods'] != null) {
      var items = json['foods'];
      var t = items.map((f) => DishesData.fromJson(f)).toList();
      m = t.cast<DishesData>().toList();
    }
    List<CategoriesData> _categories = [];
    if (json['categories'] != null) {
      var items = json['categories'];
      var t = items.map((f) => CategoriesData.fromJson(f)).toList();
      _categories = t.cast<CategoriesData>().toList();
    }
    List<RestaurantsReviewsData> _restaurantsreviews = [];
    if (json['restaurantsreviews'] != null) {
      var items = json['restaurantsreviews'];
      var t = items.map((f) => RestaurantsReviewsData.fromJson(f)).toList();
      _restaurantsreviews = t.cast<RestaurantsReviewsData>().toList();
    }
    var _restaurant;
    if (json['restaurant'] != null)
      _restaurant = Restaurants.fromJson(json['restaurant']);
    List<BannerData> _banner1 = [];
    if (json['banner1'] != null) {
      var items = json['banner1'];
      var t = items.map((f) => BannerData.fromJson(f)).toList();
      _banner1 = t.cast<BannerData>().toList();
    }
    return ResponseRestaurant(
      error: json['error'].toString(),
      ver: (json['ver'] == null) ? "1" : json['ver'].toString(),
      currency: json['currency'].toString(),
      foods: m,
      restaurant: _restaurant,
      categories: _categories,
      restaurantsreviews: _restaurantsreviews,
      banner1: _banner1,
    );
  }
}
