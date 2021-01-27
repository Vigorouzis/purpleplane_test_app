import 'package:flutter/material.dart';
import 'package:purpleplane_test_app/models/post.dart';
import 'package:purpleplane_test_app/models/user.dart';
import 'package:purpleplane_test_app/services/api_provider.dart';
import 'package:purpleplane_test_app/services/shared_prefs.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  SharedPrefs _sharedPref = SharedPrefs();
  User _user = User();
  List<Post> _items = List();
  ApiProvider _provider = ApiProvider();

  void loadFromSharedPref() async {
    _user = User.fromJson(await _sharedPref.read('user'));
  }

  void getAllPosts() async {
    _items = await _provider.getPosts();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loadFromSharedPref();
    getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: _currentIndex == 0
              ? ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(_items[index].body),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${_user.name}'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('${_user.singUpDate}'),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'First',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'Second',
            ),
          ],
        ),
      ),
    );
  }
}
