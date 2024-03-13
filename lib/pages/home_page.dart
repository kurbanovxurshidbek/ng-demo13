import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ngdemo13/pages/add_post_page.dart';
import '../models/post_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String data = "no data";
  bool isLoading = true;
  List<Post> posts = [];

  loadPosts() async {
    var response =
        await Network.GET(Network.API_POST_LIST, Network.paramsEmpty());
    LogService.d(response!);
    List<Post> postList = Network.parsePostList(response!);
    setState(() {
      posts = postList;
      isLoading = false;
    });
  }

  updatePost() async {
    Post post = Post(id: 1, title: "Nextgen 2", body: "Academy 2", userId: 1);
    var response = await Network.PUT(
        Network.API_POST_UPDATE + post.id.toString(),
        Network.paramsUpdate(post));
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  deletePost() async {
    Post post = Post(id: 1, title: "Nextgen 2", body: "Academy 2", userId: 1);
    var response = await Network.DEL(
        Network.API_POST_DELETE + post.id.toString(), Network.paramsEmpty());
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  Future _callAddPostPage() async {
    bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddPostPage();
    }));

    if (result) {
      loadPosts();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Networking"),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx, index) {
                return _itemOfPost(posts[index]);
              },
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox.shrink(),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          _callAddPostPage();
        },
      ),
    );
  }

  Widget _itemOfPost(Post post) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(post.body!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
          Divider(),
        ],
      ),
    );
  }
}
