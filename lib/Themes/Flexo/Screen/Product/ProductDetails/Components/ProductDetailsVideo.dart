import 'package:flutter/material.dart';
import 'package:nopsuite/Screens/Products/ProductDetails/Model/VideoModels.dart';
import 'package:nopsuite/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProductDetailsVideo{

  getView({required BuildContext context,required final VideoModel videoModel,bool? showFullScreen = false})
  {
    String? videoId = YoutubePlayer.convertUrlToId(videoModel.videoUrl);
    YoutubePlayerController? _controller;
    if(videoId!=null)
    {
      _controller = YoutubePlayerController(
        initialVideoId: videoId??"",
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          controlsVisibleAtStart: false,
        ),
      );
    }

    return StatefulBuilder(
      builder: (context,setState){
        return videoId!=null ? YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller!,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
          ),

          builder: (context, player){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // some widgets
                player,

              ],
            );
          },
        ) : Container(
          child: Center(
            child: FlexoTextWidget().contentText14(text: "Invalid Video URl"),
          ),
        );
      },
    );

  }
}