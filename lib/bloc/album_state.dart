part of 'album_bloc.dart';

@immutable
sealed class AlbumState {}

final class AlbumInitial extends AlbumState {}

final class AlbumLoading extends AlbumState {}


final class AlbumSuccess extends AlbumState {
  final List<Album> albums;
  AlbumSuccess({required this.albums});
}

final class AlbumError extends AlbumState {}
