class Number {
  String num;
  float y = 0;
  int x;
  color c;
  
  Number(String num, int xValue, boolean hidden) {
    textSize(28);
    this.num = num;
    this.x = xValue;
    if (hidden) {
      c = color(0,0,0);
    } else {
      c = color(175, 175, 175, 175);
    }
  }
  
  void fall() {
    
  }
}
