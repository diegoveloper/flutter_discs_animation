import 'package:flutter/material.dart';

import 'disc.dart';
import 'my_disc.dart';

class DiscsContent extends StatefulWidget {
  const DiscsContent({
    required this.onDiscSelected,
    super.key,
  });

  final ValueChanged<Disc> onDiscSelected;

  @override
  State<DiscsContent> createState() => _DiscsContentState();
}

class _DiscsContentState extends State<DiscsContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int? _selectedDiscIndex;
  int? _previousDiscIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Clean up previous disc state when animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _previousDiscIndex = null;
        });
      }
    });
  }

  final discs = [
    Disc(name: 'Disc 1', color: Colors.red),
    Disc(name: 'Disc 2', color: Colors.blue),
    Disc(name: 'Disc 3', color: Colors.green),
    Disc(name: 'Disc 4', color: Colors.brown),
    Disc(name: 'Disc 5', color: Colors.purple),
    Disc(name: 'Disc 6', color: Colors.orange),
  ];

  void _selectDisc(int index) {
    if (_selectedDiscIndex == index) return; // Same disc, do nothing

    setState(() {
      _previousDiscIndex = _selectedDiscIndex; // Store previous selection
      _selectedDiscIndex = index;
    });

    widget.onDiscSelected(discs[index]);

    // Restart animation from beginning
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: LayoutBuilder(builder: (context, constraints) {
        final selectedHeight = constraints.maxHeight * 0.5;

        // Calculate grid dimensions
        const columns = 3;
        final discSize = constraints.maxWidth / columns;

        // Dimensions for selected disc
        final selectedDiscSize = constraints.maxWidth * 0.6;
        final selectedDiscLeft = (constraints.maxWidth - selectedDiscSize) / 2;
        final selectedDiscTop = (selectedHeight - selectedDiscSize) / 2;

        final baseSize = selectedDiscSize * 1.1;

        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Stack(
              children: [
                // Background for the selected disc
                Positioned(
                  height: selectedHeight,
                  width: constraints.maxWidth,
                  child: Center(
                    child: Hero(
                      tag: 'selectedDisc',
                      child: Container(
                        width: baseSize,
                        height: baseSize,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: selectedDiscSize / 2,
                          backgroundColor: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ),

                // Position each disc in the grid
                ...discs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final disc = entry.value;

                  final row = index ~/ columns;
                  final col = index % columns;

                  final originalLeft = col * discSize;
                  final originalTop = selectedHeight + (row * discSize);

                  // If it's the currently selected disc, animate to center
                  if (_selectedDiscIndex == index) {
                    final animatedLeft = originalLeft +
                        (_animation.value * (selectedDiscLeft - originalLeft));
                    final animatedTop = originalTop +
                        (_animation.value * (selectedDiscTop - originalTop));
                    final animatedSize = discSize +
                        (_animation.value * (selectedDiscSize - discSize));

                    return Positioned(
                      left: animatedLeft,
                      top: animatedTop,
                      width: animatedSize,
                      height: animatedSize,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyDisc(
                          disc: disc,
                        ),
                      ),
                    );
                  }

                  // If it's the previously selected disc, animate back to original position
                  if (_previousDiscIndex == index) {
                    final reverseValue =
                        1.0 - _animation.value; // Reverse animation
                    final animatedLeft = originalLeft +
                        (reverseValue * (selectedDiscLeft - originalLeft));
                    final animatedTop = originalTop +
                        (reverseValue * (selectedDiscTop - originalTop));
                    final animatedSize = discSize +
                        (reverseValue * (selectedDiscSize - discSize));

                    return Positioned(
                      left: animatedLeft,
                      top: animatedTop,
                      width: animatedSize,
                      height: animatedSize,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyDisc(
                          disc: disc,
                        ),
                      ),
                    );
                  }

                  // Non-selected discs
                  return Positioned(
                    left: originalLeft,
                    top: originalTop,
                    width: discSize,
                    height: discSize,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => _selectDisc(index),
                        child: MyDisc(
                          disc: disc,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        );
      }),
    );
  }
}
