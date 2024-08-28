part of 'album_bloc.dart';

@immutable
sealed class AlbumEvent {}
class FetchAlbum extends AlbumEvent{
  final int page;
  FetchAlbum({required this.page});
}
