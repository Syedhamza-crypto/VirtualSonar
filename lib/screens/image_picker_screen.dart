import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles = [];
  bool _isLoading = false;
  String _generatedImageUrl = '';
  final String _hostUrl =
      'http://34.227.227.1'; // Replace with your actual host URL

  // Function to pick multiple images
  Future<void> _pickImages() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    setState(() {
      _imageFiles = pickedImages;
    });
  }

  // Function to call API and generate image
  Future<void> _generateImage() async {
    if (_imageFiles == null || _imageFiles!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one image')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$_hostUrl/image_gen/generate/'));

      // Add files to request
      for (var imageFile in _imageFiles!) {
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          imageFile.path,
        ));
      }

      var response = await request.send();

      // Debugging response status code
      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 201) {
        var responseBody = await http.Response.fromStream(response);

        // Debugging response body
        print('Response Body: ${responseBody.body}');

        // Parse the response body
        Map<String, dynamic> responseData = json.decode(responseBody.body);

        // Get the generated image URL from the response
        String generatedImagePath =
            responseData['images'][0]['generated_image'];

        // Concatenate host URL with the image path
        setState(() {
          _generatedImageUrl = '$_hostUrl$generatedImagePath';
        });
      } else {
        // Debugging non-200 status codes
        print('Error Response: ${response.statusCode}');
        var responseBody = await http.Response.fromStream(response);
        print('Error Response Body: ${responseBody.body}');

        throw Exception('Failed to generate image');
      }
    } catch (e) {
      // Logging error
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate image')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Images and Generate'),
        backgroundColor: const Color.fromARGB(202, 233, 208, 171),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_imageFiles != null && _imageFiles!.isNotEmpty)
              Wrap(
                spacing: 8,
                children: _imageFiles!.map((image) {
                  return Image.file(
                    File(image.path),
                    height: 100,
                    width: 100,
                  );
                }).toList(),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImages,
              child: const Text('Pick Images'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_generatedImageUrl.isNotEmpty)
              Image.network(_generatedImageUrl),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateImage,
              child: const Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
