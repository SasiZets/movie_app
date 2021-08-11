import 'package:flutter/foundation.dart';

class SelectedMovieProvider with ChangeNotifier {
  late String _movieName;
  void setMovieName(String name) {
    _movieName = name;
    notifyListeners();
  }

  String getMovieName() => _movieName;
}
