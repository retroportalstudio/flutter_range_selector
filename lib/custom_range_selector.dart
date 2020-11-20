import 'package:flutter/material.dart';

class CustomRangeSelector extends StatefulWidget {
  final double start;
  final double end;
  final int divisions;
  final Function(double start) onStartChange;
  final Function(double end) onEndChange;
  final double width;
  final double height;

  const CustomRangeSelector(
      {Key key, @required this.start, @required this.end, @required this.divisions, @required this.onStartChange, @required this.onEndChange, @required this.width, @required this.height})
      : super(key: key);

  @override
  _CustomRangeSelectorState createState() => _CustomRangeSelectorState();
}

class _CustomRangeSelectorState extends State<CustomRangeSelector> {
  double barHeight = 0;
  List<Widget> topDividers = [], bottomDividers = [];

  double startPosition = 0;
  double endPosition = 0;

  @override
  void initState() {
    super.initState();

    startPosition = widget.start * widget.width;
    endPosition = widget.end * widget.width;

    barHeight = widget.height * 0.75;
    double markerDistance = widget.width / widget.divisions;
    List markers = List.generate(widget.divisions - 1, (index) => (markerDistance) * (index + 1));

    topDividers = markers
        .map((mp) => Positioned(
              top: 0,
              left: mp - 1,
              child: Container(
                color: Colors.black,
                height: 10,
                width: 2,
              ),
            ))
        .toList();

    bottomDividers = markers
        .map((mp) => Positioned(
              bottom: 0,
              left: mp - 1,
              child: Container(
                color: Colors.black,
                height: 10,
                width: 2,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Container(
            height: barHeight,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            child: Stack(
              children: [
                ...topDividers,
                ...bottomDividers,
              ],
            ),
          ),
          Positioned(
              top: 0,
              left: startPosition - 1,
              child: Container(
                width: 2,
                height: barHeight,
                color: Colors.red,
              )),
          Positioned(
              top: 0,
              left: endPosition - 1,
              child: Container(
                width: 2,
                height: barHeight,
                color: Colors.red,
              )),
          Positioned(
              bottom: 0,
              left: startPosition - 10,
              child: GestureDetector(
                onPanUpdate: (panUpdate) {
                  double newPosition = (startPosition + panUpdate.delta.dx).clamp(0.0, widget.width);
                  if (newPosition <= endPosition - 10) {
                    widget.onStartChange(double.parse((newPosition / widget.width).toStringAsFixed(2)));
                    setState(() {
                      startPosition = newPosition;
                    });
                  }
                },
                child: Container(
                  width: 20,
                  height: widget.height - barHeight,
                  color: Colors.red,
                ),
              )),
          Positioned(
              bottom: 0,
              left: endPosition - 10,
              child: GestureDetector(
                onPanUpdate: (panUpdate) {
                  double newPosition = (endPosition + panUpdate.delta.dx).clamp(0.0, widget.width);
                  if (newPosition >= startPosition + 10) {
                    widget.onEndChange(double.parse((newPosition / widget.width).toStringAsFixed(2)));
                    setState(() {
                      endPosition = newPosition;
                    });
                  }
                },
                child: Container(
                  width: 20,
                  height: widget.height - barHeight,
                  color: Colors.red,
                ),
              )),
          Positioned(
              top: 0,
              left: startPosition,
              child: Container(
                width: endPosition - startPosition,
                height: barHeight,
                color: Colors.deepOrange.withAlpha(100),
              ))
        ],
      ),
    );
  }
}
