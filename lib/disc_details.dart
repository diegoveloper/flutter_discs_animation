import 'package:flutter/material.dart';

import 'disc.dart';
import 'my_disc.dart';

class DiscDetails extends StatefulWidget {
  const DiscDetails({super.key, required this.disc});

  final Disc disc;

  @override
  State<DiscDetails> createState() => _DiscDetailsState();
}

class _DiscDetailsState extends State<DiscDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final height = size.height * 0.35;
    final width = size.width * 0.7;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Stack(
              children: [
                // Background for the selected disc
                Positioned(
                  height: height,
                  width: width,
                  child: Center(
                    child: Hero(
                      tag: 'selectedDisc',
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: MyDisc(disc: widget.disc)),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your username',
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Choose a username',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'You can change this any time',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
