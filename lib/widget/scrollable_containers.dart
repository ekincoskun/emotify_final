import 'package:flutter/material.dart';

class HorizontalScrollableWidget extends StatelessWidget {
  final String title;
  final List<String> texts;
  final Function(int) onTap;

  HorizontalScrollableWidget({
    required this.title,
    required this.texts,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              texts.length,
              (index) => GestureDetector(
                onTap: () => onTap(index),
                child: Container(
                  width: 185,
                  height: 200,
                  margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    texts[index],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 44, 44, 124),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
