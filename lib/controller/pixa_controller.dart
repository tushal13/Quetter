import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../helper/pixa_helper.dart';

class PixaController extends ChangeNotifier {
  List abstract = [];
  List aesthetic = [];
  List blackwhite = [];
  List nature = [];
  List illustration = [];
  List minimalism = [];
  List love = [];
  List sunrise = [];
  List people = [];
  PaletteGenerator? _paletteGenerator;
  Color? dominantColor;

  PixaController() {
    init();
  }

  init() async {
    abstract =
        await PixaHelper.pixaHelper.getBackground(query: 'abstract') ?? [];
    aesthetic =
        await PixaHelper.pixaHelper.getBackground(query: 'aesthetic') ?? [];
    blackwhite =
        await PixaHelper.pixaHelper.getBackground(query: 'black and white') ??
            [];
    nature = await PixaHelper.pixaHelper.getBackground(query: 'nature') ?? [];
    illustration =
        await PixaHelper.pixaHelper.getBackground(query: 'illustration') ?? [];
    minimalism =
        await PixaHelper.pixaHelper.getBackground(query: 'minimalism') ?? [];
    love = await PixaHelper.pixaHelper.getBackground(query: 'love') ?? [];
    sunrise = await PixaHelper.pixaHelper.getBackground(query: 'sunrise') ?? [];
    people = await PixaHelper.pixaHelper.getBackground(query: 'people') ?? [];
    notifyListeners();
  }

  updateDominantColor(String imageUrl) async {
    final imageProvider = NetworkImage(imageUrl);
    _paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageProvider,
      maximumColorCount: 20,
    );
    if (_paletteGenerator != null) {
      dominantColor = _paletteGenerator!.dominantColor!.color;
      notifyListeners();
    }
  }
}
