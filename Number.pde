class Number {
  String num;
  float y;
  float x;
  color c;
  boolean fallingDown;

  Number(String num, boolean fallingDown, float xValue, float yValue) {
    textSize(28);
    this.num = num;
    this.fallingDown = fallingDown;
    this.x = xValue;
    this.y = yValue;
    c = color(175, 175, 175, 175);
  }

  void fall() {
    fill(c);
    text(num, x, y);
    if (fallingDown) {
      y++;
    } else {
      x--;
    }
  }
}

