import 'package:flutter/material.dart';
import 'HomeScreen.dart'; // Assuming you have a HomeScreen widget

class VoteScreen extends StatefulWidget {
  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  double _bjpValue = 0.0;
  double _aapValue = 0.0;
  double _congressValue = 0.0;
  double _tmcValue = 0.0;

  String _votedParty = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vote for Your Party'),
        backgroundColor: Colors.indigo, // Set app bar background color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20), // Top padding

          // Image holder
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.indigo.withOpacity(0.5), // Set image holder color
            child: Center(
              child: Text(
                'Your Party Logo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // Set text style
              ),
            ),
          ),

          SizedBox(height: 20), // Vertical spacing

          // Vote Allocation title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Vote Allocation',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.indigo), // Set title text style
            ),
          ),

          SizedBox(height: 20), // Vertical spacing

          // Sliders
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildSlider('BJP', _bjpValue, Colors.blue),
                _buildSlider('AAP', _aapValue, Colors.orange),
                _buildSlider('Congress', _congressValue, Colors.lightGreen),
                _buildSlider('TMC', _tmcValue, Colors.red),
              ],
            ),
          ),

          // Voted status
          _votedParty.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Congratulations, you have voted!',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back to Home'),
                ),
              ],
            ),
          )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildSlider(String party, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          party,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo), // Set party name text style
        ),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12), // Set thumb radius
            trackHeight: 40, // Set track height
            overlayColor: Colors.indigo.withOpacity(0.3), // Set overlay color
            activeTrackColor: color.withOpacity(0.8), // Set active track color
            inactiveTrackColor: color.withOpacity(0.2), // Set inactive track color
            thumbColor: color, // Set thumb color
            overlayShape: RoundSliderOverlayShape(overlayRadius: 24), // Set overlay shape
          ),
          child: Slider(
            value: value,
            min: 0.0,
            max: _votedParty.isEmpty ? 100.0 : 0.0,
            onChanged: _votedParty.isEmpty
                ? (newValue) {
              setState(() {
                if (_votedParty.isEmpty) {
                  switch (party) {
                    case 'BJP':
                      _bjpValue = newValue;
                      break;
                    case 'AAP':
                      _aapValue = newValue;
                      break;
                    case 'Congress':
                      _congressValue = newValue;
                      break;
                    case 'TMC':
                      _tmcValue = newValue;
                      break;
                  }
                  if (newValue == 100.0) {
                    _votedParty = party;
                  }
                }
              });
            }
                : null,
            label: party,
            divisions: 10, // Set number of divisions
          ),
        ),
      ],
    );
  }
}
