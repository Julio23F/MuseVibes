import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:musevibes/models/playlist_provider.dart';
import '../models/song.dart';
import '../pages/musicPlayer.dart';

class MusicList extends StatefulWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  //Obtenir le playlist
  late final dynamic playlistProvider;

  @override
  void initState () {
    super.initState();

    playlistProvider = Provider.of<PlaylistProvider>(context,listen: false);
  }

  void goToSong (int songIndex) {
    playlistProvider.currentSongIndex = songIndex;

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MusicPlayer())
    );
  }
  @override



  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),

      //Le Consumer est entouré par ChangeNotifierProvider dans main
      child: Consumer<PlaylistProvider>(
          builder: (context, value, child) {
            final List<Song> playlist = value.playlist;

            return ListView.builder(
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  final Song song = playlist[index];
                  return InkWell(
                    onTap: () {
                      goToSong(index);
                      print("index: ${index}");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Color(0xff30314d),
                          borderRadius: BorderRadius.circular(10)
                      ),

                      child: Row(
                        children: [
                          Text(
                            (index+1).toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(width: 25,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${song.artistName} - ${song.songName}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  "Bass - 04:30",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8)
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              size: 25,
                              color: Color(0xff31314f),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }

            );
          }
      ),
    );
  }
}

