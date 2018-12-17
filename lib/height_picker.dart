import 'package:bmi_calculator/height_slider.dart';
import 'package:bmi_calculator/height_styles.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/cupertino.dart';

class HeightPicker extends StatefulWidget {
  final int maxHeight;
  final int minHeight;
  final int height;
  final double widgetHeight;
  final ValueChanged<int> onChange;

  HeightPicker({
    Key key,
    @required this.widgetHeight,
    @required this.height,
    @required this.onChange,
    this.maxHeight = 190,
    this.minHeight = 145,
  }) : super(key: key);

  int get totalUnits => maxHeight - minHeight;

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  double get _pixelsPerUnit {
    _drawingHeight / widget.totalUnits;
  }

  double get _sliderPosition {
    double halfOfBottomLabel = labelsFontSize / 2;
    int unitFromBottom = widget.height - widget.minHeight;
    return halfOfBottomLabel + unitFromBottom * _pixelsPerUnit;
  }

  double get _drawingHeight {
    double totalHeight = widget.widgetHeight;
    double marginBottom = marginBottomAdapted(context);
    double marginTop = marginTopAdapted(context);
    return totalHeight - (marginBottom + marginTop + labelsFontSize);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _drawSlider(),
        _drawLabels(),
      ],
    );
  }

  _drawLabels() {
    int labelsToDisplay = widget.totalUnits ~/ 5 + 1;
    List<Widget> labels = List.generate(
        labelsToDisplay,
            (idx) =>
            Text(
              "${widget.maxHeight - 5 * idx}",
              style: labelsTextStyle,
            ));

    return Align(
      alignment: Alignment.centerRight,
      child: IgnorePointer(
        child: Padding(
          padding: EdgeInsets.only(
            right: screenAwareSize(12.0, context),
            bottom: marginBottomAdapted(context),
            top: marginTopAdapted(context),
          ),
          child: Column(
              children: labels,
              mainAxisAlignment: MainAxisAlignment.spaceBetween),
        ),
      ),
    );
  }

  _drawSlider() {
    return Positioned(
      child: HeightSlider(height: widget.height),
      left: 0.0,
      right: 0.0,
      bottom: _sliderPosition,
    );
  }
}
