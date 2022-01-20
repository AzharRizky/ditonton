import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const BASE_URL = 'https://api.themoviedb.org/3';
const WATCHLIST_ADD_SUCCESS_MESSAGE = 'Added to Watchlist';
const WATCHLIST_REMOVE_SUCCESS_MESSAGE = 'Removed from Watchlist';
const WACHLIST_TV_SHOW_EMPTY_MESSAGE = 'No watchlist tv show yet!';
const WACHLIST_MOVIE_EMPTY_MESSAGE = 'No watchlist movie yet!';
const NOW_PLAYING_HEADING_TEXT = 'Now Playing';
const POPULAR_HEADING_TEXT = 'Popular';
const TOP_RATED_HEADING_TEXT = 'Top Rated';

const NOT_STRING_REPLACEMENT = '-';
const FAILED_TO_FETCH_DATA_MESSAGE = 'Failed to fetch data';
const ABOUT_DESCRIPTION_TEXT =
    'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.';

// colors
const Color kRichBlack = Color(0xFF000814);
const Color kOxfordBlue = Color(0xFF001D3D);
const Color kPrussianBlue = Color(0xFF003566);
const Color kMikadoYellow = Color(0xFFffc300);
const Color kDavysGrey = Color(0xFF4B5358);
const Color kGrey = Color(0xFF303030);

// text style
final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);

// text theme
final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);

const kColorScheme = ColorScheme(
  primary: kMikadoYellow,
  primaryVariant: kMikadoYellow,
  secondary: kPrussianBlue,
  secondaryVariant: kPrussianBlue,
  surface: kRichBlack,
  background: kRichBlack,
  error: Colors.red,
  onPrimary: kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
