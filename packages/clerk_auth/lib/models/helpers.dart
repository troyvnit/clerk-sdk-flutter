DateTime? intToDateTime(dynamic input) {
  if (input is num) {
    return DateTime.fromMillisecondsSinceEpoch(input.toInt());
  }
  return null;
}

bool isOn(dynamic on) => on == 'on';

bool isTrue(dynamic boolean) => boolean == true;
