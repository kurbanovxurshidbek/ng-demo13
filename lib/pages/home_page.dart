import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPosts();
    //createPost();
    //updatePost();
    //deletePost();
  }

  loadPosts() async {
    var response = await Network.GET(Network.API_POST_LIST, {});
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  createPost() async {
    Post post = Post(title: "Nextgen", body: "Academy", userId: 1);
    var response = await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  updatePost() async {
    Post post = Post(id: 1, title: "Nextgen 2", body: "Academy 2", userId: 1);
    var response = await Network.PUT(Network.API_POST_UPDATE + post.id.toString(), Network.paramsUpdate(post));
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  deletePost() async {
    Post post = Post(id: 1, title: "Nextgen 2", body: "Academy 2", userId: 1);
    var response = await Network.DEL(Network.API_POST_DELETE + post.id.toString(), Network.paramsEmpty());
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Networking"),
      ),
      body: Center(
        child: Text(data, style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
