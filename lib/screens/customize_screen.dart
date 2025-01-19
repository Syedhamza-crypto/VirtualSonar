import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CustomizeScreen extends StatelessWidget {
  final String title;
  final List<String> imagePaths;

  const CustomizeScreen(
      {super.key, required this.title, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customize $title',
          style: const TextStyle(fontFamily: 'Cursive', fontSize: 24),
        ),
        backgroundColor: const ui.Color.fromRGBO(88, 140, 239, 1),
      ),
      body: DragAndDropGrid(imagePaths: imagePaths),
    );
  }
}

class DragAndDropGrid extends StatefulWidget {
  final List<String> imagePaths;

  const DragAndDropGrid({super.key, required this.imagePaths});

  @override
  _DragAndDropGridState createState() => _DragAndDropGridState();
}

class _DragAndDropGridState extends State<DragAndDropGrid> {
  late List<String?> gridImages;
  final GlobalKey _gridKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    gridImages = List<String?>.filled(9, null); // Initialize 3x3 grid
  }

  @override
  Widget build(BuildContext context) {
    bool isGridFull = gridImages.every((element) => element != null);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          colors: [
            ui.Color.fromARGB(197, 55, 196, 206),
            ui.Color.fromARGB(118, 7, 169, 206),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: RepaintBoundary(
              key: _gridKey,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: gridImages.length,
                itemBuilder: (context, index) {
                  return DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1),
                          color: Colors.white,
                        ),
                        child: gridImages[index] != null
                            ? Image.asset(
                                gridImages[index]!,
                                fit: BoxFit.cover,
                              )
                            : const Center(
                                child: Text(
                                  'Drop Here',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                      );
                    },
                    onAcceptWithDetails: (data) {
                      setState(() {
                        gridImages[index] = data as String?;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Colors.black),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Set 1',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ui.Color.fromARGB(255, 39, 39, 39),
                      ),
                    ),
                    _buildSlider(widget.imagePaths
                        .sublist(0, widget.imagePaths.length ~/ 2)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Set 2',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ui.Color.fromARGB(255, 41, 41, 41),
                      ),
                    ),
                    _buildSlider(widget.imagePaths
                        .sublist(widget.imagePaths.length ~/ 2)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const ui.Color.fromARGB(236, 96, 61, 239),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            onPressed: isGridFull
                ? () async {
                    await _saveGridAsImage();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Image saved to gallery!',
                          style: TextStyle(fontFamily: 'Cursive'),
                        ),
                        backgroundColor: ui.Color.fromARGB(255, 61, 167, 209),
                      ),
                    );
                  }
                : null,
            child: const Text(
              'Save Image',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSlider(List<String> images) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Draggable<String>(
            data: images[index],
            feedback: Material(
              child: Image.asset(
                images[index],
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(images[index], width: 100),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(images[index], width: 100),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveGridAsImage() async {
    try {
      RenderRepaintBoundary boundary =
          _gridKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/custom_jewelry.png';
        final file = File(filePath);
        await file.writeAsBytes(pngBytes);

        await GallerySaver.saveImage(file.path);
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }
}
