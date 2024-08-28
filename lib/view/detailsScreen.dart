import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import '../data/model/Album.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailsScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: PhotoView(
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent
                    ),
                    imageProvider: NetworkImage(album.thumbnailUrl ?? ''),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Padding( padding: const EdgeInsets.all(8.0),
            child: Text(album.title?? '', style:  TextStyle(color: Colors.black,
            fontSize: 20.spMin,fontWeight: FontWeight.w500
            ),
            ),
          ),
          SizedBox(height: 10.h,),
          Padding( padding: const EdgeInsets.all(8.0),
            child: Text('Album ID: ${album.albumId}', style:  TextStyle(color: Colors.black,
                fontSize: 20.spMin,fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
