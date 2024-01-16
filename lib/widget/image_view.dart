import 'dart:io';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final File? file;
  const ImageView({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white,
          Color.fromARGB(255, 44, 44, 124),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(8),
      ),
      child: (file == null)
          ? _buildEmptyView()
          : Image.file(file!, fit: BoxFit.cover),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
        child: Text('Please pick a photo',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )));
  }
}
