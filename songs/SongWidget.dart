import 'package:flutter/material.dart';
import 'Song.dart';

class SongWidget extends StatelessWidget {
  final Song song;

  const SongWidget({required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(song.imageUrl),
      ),
      title: Text(song.name),
      subtitle: Text('${song.writer} \n${song.category}'),
    );
  }
}
