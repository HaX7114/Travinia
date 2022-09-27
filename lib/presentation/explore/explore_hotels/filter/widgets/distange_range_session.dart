import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class DistanceRangeSession extends StatefulWidget {
  const DistanceRangeSession({
    Key? key,
  }) : super(key: key);

  @override
  _DistanceRangeSessionState createState() => _DistanceRangeSessionState();
}

class _DistanceRangeSessionState extends State<DistanceRangeSession> {
  RangeValues _currentRangeValues = const RangeValues(50, 5000);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidth.w25,
            top: AppWidth.w20,
          ),
          child: SecondaryText(
            text: 'Distance from city center',
            size: FontSize.s18,
          ),
        ),
        SizedBox(
          height: AppHeight.h20,
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            inactiveTickMarkColor: Colors.transparent,
            activeTickMarkColor: Colors.transparent,
          ),
          child: RangeSlider(
            inactiveColor: Theme.of(context).dividerColor,
            max: 5000,
            min: 40,
            divisions: 10,
            values: _currentRangeValues,
            labels: RangeLabels(_currentRangeValues.start.toStringAsFixed(1),
                _currentRangeValues.end.toStringAsFixed(0)),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                print(_currentRangeValues);
              });
            },
          ),
        ),
      ],
    );
  }
}