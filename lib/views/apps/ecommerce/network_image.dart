

// ignore_for_file: depend_on_referenced_packages, use_super_parameters, avoid_print

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

Future<Uint8List?> fetchImageBytes(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
  } catch (e) {
    print("Error fetching image: $e");
  }
  return null;
}

class NetworkImageWidget extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  const NetworkImageWidget(
      {Key? key, required this.imageUrl, this.width, this.height})
      : super(key: key);

  @override
  _NetworkImageWidgetState createState() => _NetworkImageWidgetState();
}

class _NetworkImageWidgetState extends State<NetworkImageWidget> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    fetchImageBytes(widget.imageUrl).then((bytes) {
      if (mounted) {
        setState(() {
          imageBytes = bytes;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return imageBytes != null
        ? Image.memory(imageBytes!,
        width: widget.width ?? 100,
        height: widget.height ?? 100,
        fit: BoxFit.fill)
        : const Text('');
  }
}
