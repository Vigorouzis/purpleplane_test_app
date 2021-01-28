import 'package:equatable/equatable.dart';
import 'package:purpleplane_test_app/models/post.dart';
import 'package:purpleplane_test_app/models/user.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainFirst extends MainState {
  final List<Post> posts;

  const MainFirst(this.posts);

  @override
  List<Object> get props => [posts];
}

class MainSecond extends MainState {
  final User user;

  const MainSecond(this.user);

  @override
  List<Object> get props => [user];
}
