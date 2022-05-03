import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/post_model.dart';
import 'package:cloudmate/src/resources/remote/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_class_event.dart';
part 'post_class_state.dart';

class PostClassBloc extends Bloc<PostClassEvent, PostClassState> {
  PostClassBloc() : super(PostClassInitial());

  Map<String, List<PostModel>> postsClass = {};
  String currentClassId = '';

  @override
  Stream<PostClassState> mapEventToState(PostClassEvent event) async* {
    if (event is GetPostClassEvent) {
      currentClassId = event.classId;
      await _getPosts();
      yield _getDonePostClass;
    }

    if (event is CleanPostClassEvent) {
      postsClass = {};
      yield PostClassInitial();
    }
  }

  // MARK: Private methods
  // GettingPostClass get _gettingPostClass => GettingPostClass(
  //       posts: postsClass[currentClassId] ?? [],
  //     );
  GetDonePostClass get _getDonePostClass => GetDonePostClass(
        posts: postsClass[currentClassId] ?? [],
      );

  Future<void> _getPosts() async {
    List<PostModel> _posts = await PostRepository().getListPostClass(classId: currentClassId);

    postsClass[currentClassId] = _posts;
  }
}
