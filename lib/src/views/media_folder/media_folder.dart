import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:status_saver/src/resources/route.manager.dart';
import 'package:video_player/video_player.dart';

class MediaFolderView extends StatefulWidget {
  const MediaFolderView({super.key});

  @override
  MediaFolderViewState createState() => MediaFolderViewState();
}

class MediaFolderViewState extends State<MediaFolderView> {
  late Future<List<FileSystemEntity>> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = getFiles();
  }

  Future<List<FileSystemEntity>> getFiles() async {
    final dir = await path_provider.getDownloadsDirectory();
    if (dir == null || !dir.existsSync()) {
      dir?.createSync();
    }
    return dir!.listSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Viewer'),
      ),
      body: FutureBuilder<List<FileSystemEntity>>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading files'));
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("empty folder"),
            );
          } else {
            final files = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
              ),
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                if (file is File) {
                  final extension = file.path.split('.').last.toLowerCase();
                  debugPrint(extension);

                  return Hero(
                    tag: "${file.hashCode}",
                    child: (extension == 'mp4')
                        ? _buildVideoItem(file)
                        : (extension == 'png')
                            ? _buildImageItem(file)
                            : const SizedBox(),
                  );
                }
                return const SizedBox();
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildImageItem(File file) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteManager.viewProfile, arguments: file);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.teal,
          ),
        ),
        child: Image.file(
          file,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.medium,

          // frameBuilder: (context, _, __, ___) => const Center(child: CircularProgressIndicator()),
          errorBuilder: (context, url, error) => const Icon(Icons.error),
        ),
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
