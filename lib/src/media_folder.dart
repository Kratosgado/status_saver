import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';

class MediaFolderView extends StatefulWidget {
  final String folderPath;

  const MediaFolderView({Key? key, required this.folderPath}) : super(key: key);

  @override
  _MediaFolderViewState createState() => _MediaFolderViewState();
}

class _MediaFolderViewState extends State<MediaFolderView> {
  late List<File> files;

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  Future<void> loadFiles() async {
    final folder = Directory(widget.folderPath);
    if (await folder.exists()) {
      final folderContents = folder.listSync();
      final filePaths = folderContents.whereType<File>().map((file) => file.path).toList();
      setState(() {
        files = filePaths.map((path) => File(path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Folder'),
      ),
      body: files!.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: files!.length,
              itemBuilder: (BuildContext context, int index) {
                final file = files![index];
                final extension = file.path.split('.').last.toLowerCase();
                if (extension == 'mp4') {
                  return _buildVideoItem(file);
                } else if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
                  return _buildImageItem(file);
                } else {
                  return Container();
                }
              },
            ),
    );
  }

  Widget _buildImageItem(File file) {
    return InkWell(
      onTap: () {
        // Handle image tap
      },
      child: CachedNetworkImage(
        imageUrl: file.path,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildVideoItem(File file) {
    final videoPlayerController = VideoPlayerController.file(file);
    return FutureBuilder(
      future: videoPlayerController.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return InkWell(
            onTap: () {
              videoPlayerController.play();
            },
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_file_manager/flutter_file_manager.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:video_player/video_player.dart';

// class MediaFolderView extends StatefulWidget {
//   final String folderPath;

//   const MediaFolderView({Key? key, required this.folderPath}) : super(key: key);

//   @override
//   _MediaFolderViewState createState() => _MediaFolderViewState();
// }

// class _MediaFolderViewState extends State<MediaFolderView> {
//   late List<File> files;

//   @override
//   void initState() {
//     super.initState();
//     loadFiles();
//   }

//   Future<void> loadFiles() async {
//     final folder = Directory(widget.folderPath);
//     if (await folder.exists()) {
//       final filesInFolder = await FileManager.listFiles(widget.folderPath);
//       setState(() {
//         files = filesInFolder;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Media Folder'),
//       ),
//       body: files.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : SliverAnimatedGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 2,
//               ),
//               initialItemCount: files.length,
//               itemBuilder: (BuildContext context, int index, animatedDouble) {
//                 final file = files[index];
//                 final extension = file.path.split('.').last.toLowerCase();
//                 if (extension == 'mp4') {
//                   return _buildVideoItem(file);
//                 } else if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
//                   return _buildImageItem(file);
//                 } else {
//                   return Container();
//                 }
//               },
//               // staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
//             ),
//     );
//   }

//   Widget _buildImageItem(File file) {
//     return InkWell(
//       onTap: () {
//         // Handle image tap
//       },
//       child: CachedNetworkImage(
//         imageUrl: file.path,
//         fit: BoxFit.cover,
//         placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//       ),
//     );
//   }

//   Widget _buildVideoItem(File file) {
//     final videoPlayerController = VideoPlayerController.file(file);
//     return FutureBuilder(
//       future: videoPlayerController.initialize(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return InkWell(
//             onTap: () {
//               videoPlayerController.play();
//             },
//             child: AspectRatio(
//               aspectRatio: videoPlayerController.value.aspectRatio,
//               child: VideoPlayer(videoPlayerController),
//             ),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }
