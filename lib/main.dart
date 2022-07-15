import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  TextEditingController _controller = TextEditingController(text: 'Sample Text\n샘플 텍스트');
  TextEditingController _textSizeController = TextEditingController(text: '20');
  TextEditingController _textColorController = TextEditingController(text: '000000');
  TextEditingController _textBgColorController = TextEditingController(text: 'FFFFFF');
  TextEditingController _letterSpacingController = TextEditingController(text: '0');
  TextEditingController _wordSpacingController = TextEditingController(text: '0');
  TextEditingController _heightController = TextEditingController(text: '0');

  TextEditingController _colorcontroller = TextEditingController();

  String _sampleText = 'Sample Text\n샘플 텍스트';
  bool _italic = false;

  double _fontSize = 20.0;
  double _letterSpacing = 0.0;
  double _wordSpacing = 0.0;
  double _height = 0.0;

  Color _textColor = Colors.black;
  Color _pickerColor = Colors.black;
  Color _textBgColor = Colors.white;

  final _fontNameList = [
    'PretendardThin',
    'PretendardExtraLight',
    'PretendardLight',
    'PretendardRegular',
    'PretendardMedium',
    'PretendardSemiBold',
    'PretendardBold',
    'PretendardExtraBold',
    'PretendardBlack',
  ];
  var _fontNameValue = 'PretendardMedium';

  final _fontWeightList = [
    'w100 (thin)',
    'w200 (extra light)',
    'w300 (light)',
    'w400 (regular)',
    'w500 (medium)',
    'w600 (semi-bold)',
    'w700 (bold)',
    'w800 (extra-bold)',
    'w900 (black)',
  ];
  var _fontWeightValue = 'w500 (medium)';

  FontWeight _getWeight(String value) {
    if (value == _fontWeightList[0]) return FontWeight.w100;
    if (value == _fontWeightList[1]) return FontWeight.w200;
    if (value == _fontWeightList[2]) return FontWeight.w300;
    if (value == _fontWeightList[3]) return FontWeight.w400;
    if (value == _fontWeightList[4]) return FontWeight.w500;
    if (value == _fontWeightList[5]) return FontWeight.w600;
    if (value == _fontWeightList[6]) return FontWeight.w700;
    if (value == _fontWeightList[7]) return FontWeight.w800;
    if (value == _fontWeightList[8]) return FontWeight.w900;
    return FontWeight.normal;
  }

  void _incrementCounter() {
    // setState(() {
    //   //_counter++;
    //   _sampleText = _controller.value.text.trim();
    // });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _pickerColor,
              onColorChanged: changeColor,
              hexInputBar: true,
              hexInputController: _colorcontroller,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   showLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
            //
            // child: MultipleChoiceBlockPicker(
            //   pickerColors: currentColors,
            //   onColorsChanged: changeColors,
            // ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() => _textColor = _pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void changeColor(Color color) => setState(() => _textColor = color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 800,
              height: 400,
              color: _textBgColor,
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     width: 1,
              //     color: Colors.orange,
              //   ),
              // ),
              child: Center(
                  child: Text(
                _sampleText,
                style: TextStyle(
                  fontFamily: _fontNameValue,
                  fontStyle: (_italic ? FontStyle.italic : null),
                  color: _textColor,
                  backgroundColor: _textBgColor,
                  fontWeight: _getWeight(_fontWeightValue),
                  fontSize: _fontSize,
                  wordSpacing: _wordSpacing,
                  letterSpacing: _letterSpacing,
                  height: _height,
                ),
              )),
            ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            SizedBox(height:20,),
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Sample Text',
              ),
              maxLines: 4,
              minLines: 2,
              onChanged: (value) => {
                setState(() {
                  _sampleText = value; //_controller.value.text.trim();
                })
              },
            ),
            SizedBox(height:10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: TextFormField(
                    maxLength: 6,
                    controller: _textSizeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Font Size',
                    ),
                    onChanged: (value) => {
                      setState(() {
                        _fontSize = double.parse(value); //_controller.value.text.trim();
                      })
                    },
                  ),
                ),
                SizedBox(width:10,),
                DropdownButton(
                  value: _fontNameValue,
                  items: _fontNameList.map(
                        (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _fontNameValue = value ?? '';
                    });
                  },
                ),
                SizedBox(width:10,),
                DropdownButton(
                  value: _fontWeightValue,
                  items: _fontWeightList.map(
                        (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _fontWeightValue = value ?? '';
                    });
                  },
                ),
                SizedBox(width:10,),
                Checkbox(
                  value: _italic,
                  onChanged: (bool? value) {
                    setState(() {
                      _italic = value ?? false;
                    });
                  },
                ),
                const Text('italic'),
              ],
            ),
            SizedBox(height:10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: TextFormField(
                    maxLength: 6,
                    controller: _textColorController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Text Color',
                    ),
                    onChanged: (value) => {
                      setState(() {
                        _textColor = fromHex(value); //_controller.value.text.trim();
                      })
                    },
                  ),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    maxLength: 6,
                    controller: _textBgColorController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Background Color',
                    ),
                    onChanged: (value) => {
                      setState(() {
                        _textBgColor = fromHex(value); //_controller.value.text.trim();
                      })
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height:10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: TextFormField(
                    maxLength: 6,
                    controller: _letterSpacingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Letter Spacing',
                    ),
                    onChanged: (value) => {
                      setState(() {
                        _letterSpacing = double.parse(value); //_controller.value.text.trim();
                      })
                    },
                  ),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    maxLength: 6,
                    controller: _wordSpacingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Word Spacing',
                    ),
                    onChanged: (value) => {
                      setState(() {
                        _wordSpacing = double.parse(value); //_controller.value.text.trim();
                      })
                    },
                  ),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    maxLength: 6,
                    controller: _heightController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Line Height',
                    ),
                    onChanged: (value) => {
                      setState(() {
                        _height = double.parse(value); //_controller.value.text.trim();
                      })
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Apply',
      //   child: const Text('Apply'),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
