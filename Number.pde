class Number {
  String num;
  float y = 0;
  int x;
  color c;

  Number(String num, int xValue) {
    textSize(28);
    this.num = num;
    this.x = xValue;
    c = color(175, 175, 175, 175);
  }

  void fall() {
    fill(c);
    text(num, x, y);
    y++;
  }
}

