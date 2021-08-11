import 'package:flutter/material.dart';
import 'package:movie_app/provider/selected_movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

const kApiKey = '2245b5f50154a9b20eb98d97d66424aa';
const kBaseUrl = "https://api.themoviedb.org/3";
const kImageUrl = "https://image.tmdb.org/t/p/original";

SelectedMovieProvider kSelectedMovieProvider(BuildContext context) =>
    Provider.of<SelectedMovieProvider>(context, listen: false);

const kHeadingStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
);
const kContentStyle = TextStyle(
  color: Colors.white,
);
TextStyle kSubHeadingStyle = TextStyle(
  color: Colors.grey.shade600,
);

void kLaunchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
