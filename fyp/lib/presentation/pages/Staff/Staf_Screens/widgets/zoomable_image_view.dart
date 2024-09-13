import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ZoomableImageView extends StatefulWidget {
  final String imageUrl;

  const ZoomableImageView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ZoomableImageViewState createState() => _ZoomableImageViewState();
}

class _ZoomableImageViewState extends State<ZoomableImageView> {
  @override
  void initState() {
    super.initState();
    //_secureScreen();
  }

  // Future<void> _secureScreen() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image View'),
        centerTitle: true,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.imageUrl),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
