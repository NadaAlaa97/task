import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_leadvision/data/repository/album_repository.dart';

import '../data/model/Album.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState>{
      final AlbumRepository albumRepository;
      AlbumBloc({required this.albumRepository}) : super(AlbumInitial()) {
        on<FetchAlbum> (fetchAlbum);
      }

      Future<void> fetchAlbum(FetchAlbum event , Emitter<AlbumState> emit) async{
        emit(AlbumLoading());
        try {
         final albums = await albumRepository.fetchAlbums(event.page);
         emit(AlbumSuccess(albums: albums));
      } catch(e){
        emit(AlbumError());
        }
      }
}
