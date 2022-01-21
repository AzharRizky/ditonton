import 'package:about/about.dart' show AboutPage;
import 'package:core/core.dart' show DrawerItem, kDavysGrey, kGrey;
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart' show HomeMoviePage;
import 'package:tv_shows/tv_shows.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  DrawerItem _selectedDrawerItem = DrawerItem.movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: _buildDrawer(context, (DrawerItem newSelectedItem) {
        setState(() {
          _selectedDrawerItem = newSelectedItem;
        });
      }, _selectedDrawerItem),
      appBar: _buildAppBar(context, _selectedDrawerItem),
      body: _buildBody(context, _selectedDrawerItem),
    );
  }

  Widget _buildBody(BuildContext context, DrawerItem selectedDrawerItem) {
    if (selectedDrawerItem == DrawerItem.movie) {
      return HomeMoviePage();
    } else if (selectedDrawerItem == DrawerItem.tvShow) {
      return HomeTVShowPage();
    }
    return Container();
  }

  AppBar _buildAppBar(
    BuildContext context,
    DrawerItem activeDrawerItem,
  ) =>
      AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.routeName,
                arguments: activeDrawerItem,
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      );

  Drawer _buildDrawer(
    BuildContext context,
    Function(DrawerItem) itemCallback,
    DrawerItem activeDrawerItem,
  ) =>
      Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              tileColor:
                  activeDrawerItem == DrawerItem.movie ? kDavysGrey : kGrey,
              leading: Icon(Icons.movie_creation_outlined),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
                itemCallback(DrawerItem.movie);
              },
            ),
            ListTile(
              tileColor:
                  activeDrawerItem == DrawerItem.tvShow ? kDavysGrey : kGrey,
              leading: Icon(Icons.live_tv_rounded),
              title: Text('TV Shows'),
              onTap: () {
                Navigator.pop(context);
                itemCallback(DrawerItem.tvShow);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, WatchlistPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      );
}
