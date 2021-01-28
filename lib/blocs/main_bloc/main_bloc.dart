import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purpleplane_test_app/models/post.dart';
import 'package:purpleplane_test_app/models/user.dart';
import 'package:purpleplane_test_app/services/api_provider.dart';
import 'package:purpleplane_test_app/services/shared_prefs.dart';

import 'main.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  ApiProvider _provider = ApiProvider();
  MainBloc(this._provider) : super(MainInitial());

  List<Post> _posts;
  SharedPrefs _sharedPref = SharedPrefs();
  User _user = User();
  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is GetPost) {
      _posts = await _provider.getPosts();
      yield MainFirst(_posts);
    }

    if (event is GetName) {
      _user = User.fromJson(await _sharedPref.read('user'));
      yield MainSecond(_user);
    }
  }
}
