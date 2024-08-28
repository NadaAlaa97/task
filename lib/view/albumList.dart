import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_leadvision/bloc/album_bloc.dart';
import 'package:task_leadvision/view/detailsScreen.dart';
import 'customWidgets/paginationWidget.dart';

class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  late AlbumBloc albumBloc;
  int currentPage = 1;
  int totalPages = 5;

  @override
  void initState() {
    super.initState();
    albumBloc = BlocProvider.of<AlbumBloc>(context);
    albumBloc.add(FetchAlbum(page: currentPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album List Task', style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 24.spMin,
        )),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        )),
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumLoading) {
              return const Center(child: CircularProgressIndicator(color:
                Colors.blueGrey,));
            }
            if (state is AlbumSuccess) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.albums.length,
                      itemBuilder: (context, index) {
                        final album = state.albums[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: Image.network(album.thumbnailUrl ?? ''),
                              title: Text(album.title ?? ''),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => AlbumDetailsScreen(album: album),
                                ));
                              },
                            ),
                            const Divider(thickness: 2, color: Colors.blueGrey),
                          ],
                        );
                      },
                    ),
                  ),
                  PaginationWidget(
                    currentPage: currentPage,
                    totalPages: totalPages,
                    onPageSelected: (page) {
                      setState(() {
                        currentPage = page;
                        albumBloc.add(FetchAlbum(page: currentPage));
                      });
                    },
                  ),
                ],
              );
            } else if (state is AlbumError) {
              return const Center(child: Text('Failed to load albums'));
            }
            return Container();
          }
      ),
    );
  }

}
