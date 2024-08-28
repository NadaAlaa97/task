import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:task_leadvision/bloc/album_bloc.dart';

class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  final controller = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
    BlocProvider.of<AlbumBloc>(context).add(FetchAlbum());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album List Task', style:TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 24.spMin),),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r)
        )),
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state){
            if(state is AlbumError){
              return const Center(child: Text('Failed to load albums'));
            }
            if(state is AlbumSuccess){
              return ListView.builder(
                  controller: controller,
                itemCount: state.pageMax ? state.albums.length : state.albums.length + 1,
                itemBuilder: (context, index){
                    if(index >= state.albums.length){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    final album = state.albums[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: SizedBox(
                            width: 90,
                            height: 90,
                            child: FullScreenWidget(
                              disposeLevel: DisposeLevel.Low,
                              child: PhotoView(
                                backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                                  imageProvider: NetworkImage(album.thumbnailUrl ?? '',),
                                   ),
                            ),
                          ),
                          title: Text(album.title ?? ''),
                        ),
                        const Divider(thickness: 2, color: Colors.blueGrey,)
                      ],
                    );

                },
              );
            }
            return Container();
          }
      ),
    );
  }
  void onScroll(){
    if(controller.position.extentAfter == controller.position.maxScrollExtent){
      BlocProvider.of<AlbumBloc>(context).add(FetchAlbum());
    }
  }
}
