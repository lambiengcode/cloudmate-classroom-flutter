import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/post_model.dart';
import 'package:cloudmate/src/resources/remote/post_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:meta/meta.dart';

part 'post_home_event.dart';
part 'post_home_state.dart';

class PostHomeBloc extends Bloc<PostHomeEvent, PostHomeState> {
  PostHomeBloc() : super(PostHomeInitial());

  List<PostModel> posts = [];
  bool isOver = false;

  @override
  Stream<PostHomeState> mapEventToState(PostHomeEvent event) async* {
    if (event is OnPostHomeEvent) {
      posts = [];
      isOver = false;
      if (posts.isEmpty) {
        await _getPosts();
        yield _getDonePostHome;
      }
    }

    if (event is GetPostHomeEvent) {
      if (!isOver) {
        yield _gettingPostHome;
        await _getPosts();
        yield _getDonePostHome;
      }
    }

    if (event is CreatePostHomeEvent) {
      for (int index = 0; index < event.classChooses.length; index++) {
        PostModel? post = await PostRepository().createPost(
          content: event.content,
          classId: event.classChooses[index],
        );

        if (post != null) {
          posts.insert(0, post);
          yield _getDonePostHome;
        }
      }

      AppNavigator.pop();
    }

    if (event is CleanPostHomeEvent) {
      yield PostHomeInitial();
    }
  }

  // MARK: Private methods
  GettingPostHome get _gettingPostHome => GettingPostHome(posts: posts);
  GetDonePostHome get _getDonePostHome => GetDonePostHome(posts: posts);

  Future<void> _getPosts() async {
    List<PostModel> _posts = await PostRepository().getListPostHome();

    if (_posts.length < 15) {
      isOver = true;
    }

    posts.addAll(_posts);
  }
}
