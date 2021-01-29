import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purpleplane_test_app/blocs/main_bloc/main_bloc.dart';
import 'package:purpleplane_test_app/blocs/main_bloc/main_event.dart';
import 'package:purpleplane_test_app/blocs/main_bloc/main_state.dart';
import 'package:purpleplane_test_app/services/api_provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  MainBloc _mainBloc;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (_currentIndex == 0) {
      _mainBloc.add(GetPost());
    } else {
      _mainBloc.add(GetName());
    }
  }

  @override
  void initState() {
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
    if (_currentIndex == 0) {
      _mainBloc.add(GetPost());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_currentIndex);
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state is MainFirst) {
                return ListView.builder(
                  itemCount: state.posts?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('${state.posts[index].id}'),
                      title: Text(state.posts[index].body),
                    );
                  },
                );
              }
              if (state is MainSecond) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${state.user.name}'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('${state.user.singUpDate}'),
                    ],
                  ),
                );
              }
              return Container();
            },
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
