import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_leadvision/data/repository/album_repository.dart';

import '../data/model/Album.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState>{
      final AlbumRepository albumRepository;
      int page = 1;
      AlbumBloc({required this.albumRepository}) : super(AlbumInitial()) {
        on<FetchAlbum> (fetchAlbum);
      }

      void fetchAlbum(FetchAlbum event , Emitter<AlbumState> emit) async{
        if(state is AlbumSuccess && (state as AlbumSuccess).pageMax) return ;
        try {
          if(state is AlbumInitial){
            final albums = await albumRepository.fetchAlbums(page);
            return emit(AlbumSuccess(albums: albums, pageMax: false));
          }
          final currentState = state as AlbumSuccess;
          final albums = await albumRepository.fetchAlbums(++page);
          emit(albums.isEmpty ? AlbumSuccess(albums: currentState.albums, pageMax: true)
              : AlbumSuccess(albums: currentState.albums + albums, pageMax: false));
        }
        catch(e){
          emit(AlbumError(message: 'Failed to load'));
        }
      }
}
