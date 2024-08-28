part of 'album_bloc.dart';

@immutable
sealed class AlbumState {}

final class AlbumInitial extends AlbumState {}

final class AlbumSuccess extends AlbumState {
  final List<Album> albums;
  final bool pageMax;
  AlbumSuccess({required this.albums, required this.pageMax});
}

final class AlbumError extends AlbumState {
  final String message;
  AlbumError({required this.message});
}
