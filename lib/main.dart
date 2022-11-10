import 'package:flutter/material.dart';
import 'package:rest_api/models/post.dart';
import 'package:rest_api/services/services.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

// ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Post> posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    //fetch data
    getData();
  }

  getData() async {
    posts = (await RemoteServices().getPosts())!;

    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REST API Post"),
        backgroundColor: Colors.blue,
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Container(
              child: Text(
                posts![index].title,
                style: TextStyle(
                  fontSize: 20,

                ),
              ),
            );
          },
        ),
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
