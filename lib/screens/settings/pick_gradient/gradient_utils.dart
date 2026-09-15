import 'package:flutter/material.dart';

class GradientUtils {
  static List<Color> getGradientFromBorderId(String borderId) {
    for (var i = 0; i < gradients.length; i++) {
      if (gradients.keys.elementAt(i) == borderId) {
        return gradients.values.elementAt(i);
      }
    }
    return gradients.values.first;
  }

  static Map<String, List<Color>> gradients = {
    'Midnight': _defaultMidnight,
    'Deep sea': _deepSea,
    'Grapefruit sunset': _grapefruitSunset,
    'Solid vault': _solidVault,
    'Bright vault': _brightVault,
    'Politics': _politics,
    'SweetMorning': _sweetMorning,
    'Sylvia': _sylvia,
    'Transfile': _transfile,
    'DarSkies': _darSkies,
    'Suzy': _suzy,
    'Superman': _superman,
    'NightHawk': _nightHawk,
    'Haikus': _haikus,
    'Purplin': _purplin,
    'Inbox': _inbox,
    'LightOrange': _lightOrange,
    'Forest': _forest,
    'Miami': _miami,
    'Minnesota Vikings': _minnesotaVikings,
    'Joombla': _joombla,
    'Pizelex': _pizelex,
    'Blush': _blush,
    'Green Blue': _greenBlue,
    'Poncho': _poncho,
  };

  static const List<Color> _defaultMidnight = [
    Colors.black,
    Colors.blue,
  ];

  static const List<Color> mauve = [
    Color(0xFF42275a),
    Color(0xFF734B6D),
  ];

  static const List<Color> dusk = [
    Color(0xFF2C3E50),
    Color(0xFFFD746C),
  ];

  static const List<Color> _deepSea = [
    Color(0xFF2C3E50),
    Color(0xFF4CA1AF),
  ];

  static const List<Color> _grapefruitSunset = [
    Color(0xFFe96443),
    Color(0xFF904e95)
  ];

  static const List<Color> sunset = [Color(0xFF0B486B), Color(0xFFF56217)];

  static const List<Color> _solidVault = [
    Color(0xFF3a7bd5),
    Color(0xFF3a6073),
  ];

  static const List<Color> _brightVault = [
    Color(0xFF00d2ff),
    Color(0xFF928DAB),
  ];

  static const List<Color> _politics = [
    Color(0xFF2196f3),
    Color(0xFFf44336),
  ];

  static const List<Color> _sweetMorning = [
    Color(0xFFFF5F6D),
    Color(0xFFFFC371),
  ];

  static const List<Color> _sylvia = [
    Color(0xFFff4b1f),
    Color(0xFFff9068),
  ];

  static const List<Color> _transfile = [
    Color(0xFF16BFFD),
    Color(0xFFCB3066),
  ];

  static const List<Color> tranquil = [
    Color(0xFFEECDA3),
    Color(0xFFEF629F),
  ];

  static const List<Color> redOcean = [
    Color(0xFF1D4350),
    Color(0xFFA43931),
  ];

  static const List<Color> ali = [
    Color(0xFFff4b1f),
    Color(0xFF1fddff),
  ];

  static const List<Color> purpleWhite = [
    Color(0xFFBA5370),
    Color(0xFFF4E2D8),
  ];
  static const List<Color> decent = [
    Color(0xFF4CA1AF),
    Color(0xFFC4E0E5),
  ];
  static const List<Color> deepSpace = [
    Color(0xFF000000),
    Color(0xFF434343),
  ];
  static const List<Color> _darSkies = [
    Color(0xFF4B79A1),
    Color(0xFF283E51),
  ];
  static const List<Color> _suzy = [
    Color(0xFF834d9b),
    Color(0xFFd04ed6),
  ];
  static const List<Color> _superman = [
    Color(0xFF0099F7),
    Color(0xFFF11712),
  ];
  static const List<Color> _nightHawk = [
    Color(0xFF2980b9),
    Color(0xFF2c3e50),
  ];

  static const List<Color> _forest = [
    Color(0xFF5A3F37),
    Color(0xFF2C7744),
  ];
  static const List<Color> _miami = [
    Color(0xFF4DA0B0),
    Color(0xFFD39D38),
  ];
  static const List<Color> _minnesotaVikings = [
    Color(0xFF5614B0),
    Color(0xFFDBD65C)
  ];

  static const List<Color> _joombla = [
    Color(0xFF1e3c72),
    Color(0xFF2a5298),
  ];
  static const List<Color> _pizelex = [
    Color(0xFF114357),
    Color(0xFFF29492),
  ];
  static const List<Color> _haikus = [
    Color(0xFFfd746c),
    Color(0xFFff9068),
  ];
  static const List<Color> _purplin = [
    Color(0xFF6a3093),
    Color(0xFFa044ff),
  ];
  static const List<Color> _inbox = [
    Color(0xFF457fca),
    Color(0xFF5691c8),
  ];

  static const List<Color> _blush = [
    Color(0xFFB24592),
    Color(0xFFF15F79),
  ];
  static const List<Color> future = [
    Color(0xFFC02425),
    Color(0xFFF0CB35),
  ];
  static const List<Color> _greenBlue = [
    Color(0xFFc2e59c),
    Color(0xFF64b3f4),
  ];
  static const List<Color> _poncho = [
    Color(0xFF403A3E),
    Color(0xFFBE5869),
  ];
  static const List<Color> _lightOrange = [
    Color(0xFFFFB75E),
    Color(0xFFED8F03),
  ];
}
