import 'package:flutter/material.dart';
import 'package:flutter_mvvm_example/view_model/image_view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImageListViewModel imageListViewModel = ImageListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
      ),
      body: FutureBuilder(
        future: imageListViewModel.fetchPictures(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: imageListViewModel.imageList!.length,
              itemBuilder: (BuildContext context, int index) => Container(
                color: Colors.grey,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image:
                      "${imageListViewModel.imageList![index].imageModel!.downloadUrl}",
                  fit: BoxFit.cover,
                ),
              ),
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index.isEven ? 2 : 1),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            );
          }
        },
      ),
    );
  }
}
