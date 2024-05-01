import 'package:flutter/material.dart';
import 'SongWidget.dart';
import 'Song.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Song> songs = [
    Song(
      name: 'Song 1',
      writer: 'Writer 1',
      category: 'Category A',
      imageUrl: 'https://images.unsplash.com/photo-1485579149621-3123dd979885?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG11c2ljfGVufDB8fDB8fHww',
    ),
    Song(
      name: 'Song 2',
      writer: 'Writer 2',
      category: 'Category B',
      imageUrl: 'https://images.unsplash.com/photo-1494232410401-ad00d5433cfa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bXVzaWN8ZW58MHx8MHx8fDA%3D',
    ),
    Song(
    name: 'Bohemian Rhapsody',
    writer: 'Freddie Mercury',
    category: 'Rock',
    imageUrl: 'https://cdn.pixabay.com/photo/2024/01/17/11/53/piano-8514284_640.jpg',
  ),
  Song(
    name: 'Yesterday',
    writer: 'Paul McCartney',
    category: 'Pop',
    imageUrl: 'https://cdn.pixabay.com/photo/2016/03/28/09/36/music-1285165_1280.jpg',
  ),
  Song(
    name: 'Hotel California',
    writer: 'Don Felder, Glenn Frey, Don Henley',
    category: 'Rock',
    imageUrl: 'https://cdn.pixabay.com/photo/2016/09/08/21/09/piano-1655558_640.jpg',
  ),
  Song(
    name: 'Shape of You',
    writer: 'Ed Sheeran, Steve Mac, Johnny McDaid',
    category: 'Pop',
    imageUrl: 'https://cdn.pixabay.com/photo/2024/01/17/11/53/piano-8514284_640.jpg',
  ),
  Song(
    name: 'Despacito',
    writer: 'Luis Fonsi, Daddy Yankee',
    category: 'Latin Pop',
    imageUrl: 'https://cdn.pixabay.com/photo/2017/11/15/09/28/music-player-2951399_640.jpg',
  ),
    // Add more songs here...
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Song List'),
        ),
        body: ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            return SongWidget(song: songs[index]);
          },
        ),
      ),
    );
  }
}
