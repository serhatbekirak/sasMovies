import 'package:sasMovie/ignore/ConstantsIgnore.dart';

class APIConstants {
  static const String API_URL = "https://api.themoviedb.org/3/movie/";
  static const String API_IMAGE_PATH = "http://image.tmdb.org/t/p/w500/";
  static const String KEY = ConstantsIgnore.KEY;
  static const String LANGUAGE = "en-EN";

  static const String Popular = "popular";
  static const String Recommend = "top_rated";
  static const String Upcoming = "upcoming";
  static const String Credits = "/credits";

  static String mapToString(Map<String, String> parameters) {
    if (parameters == null) parameters = new Map<String, String>();
    parameters['api_key'] = KEY;
    parameters['language'] = LANGUAGE;
    if (parameters != null && parameters.length > 0) {
      String returnVal = "";
      parameters.forEach((key, val) {
        if (returnVal != "")
          returnVal = returnVal + "&";
        else
          returnVal = returnVal + "?";
        returnVal = returnVal + "$key" + "=" + "$val";
      });
      return returnVal;
    } else {
      return "";
    }
  }

}
