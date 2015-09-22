import java.util.Iterator;
import codeanticode.syphon.*;

ArrayList<Number> numbers = new ArrayList<Number>();
int xValue = 0;
int currNum = 1;
boolean looping = true;

SyphonServer server;

void setup() {
  size(400, 600, P2D);
  background(0);
  numbers.add(new Number(str(currNum), xValue));
  currNum++;
  numbers.add(new Number(str(currNum), xValue));
  currNum++;
  numbers.add(new Number(str(currNum), xValue));
  
  // Create syphon server to send frames out
  server = new SyphonServer(this, "Processing Spyhon");
}

void draw() {
  background(0);
  for (Iterator<Number> iter = numbers.iterator (); iter.hasNext(); ) {
    Number num = iter.next();
    text(num.num, num.x, num.y);
    num.y++;
    if (num.y > height) {
      iter.remove();
    }
  }
  if (numbers.get(numbers.size()-1).y == 30) {
    // get static copy of size so it won't be affected by adding to numbers
    int currSize = numbers.size();
    // add new row
    for (int i=0; i<currNum; i++) {
      // if single digit number
      if (i > 9) {
        int offsetX = (i-9) * 20;
        numbers.add(new Number(str(i+1), i*20+offsetX));
      } else {
        numbers.add(new Number(str(i+1), i*20));
      }
    }
    // TODO fix issue adding in 11
    if (currNum > 10) {
      xValue = numbers.get(numbers.size()-1).x + 40;
    } else {
      xValue += 20;
    }
    // add new number at end of line
    numbers.add(new Number(str(currNum+1), xValue));
    if (currNum % 3 == ) {
      currNum+=3;
    }
  }
  server.sendScreen();
}

// pause
void keyPressed() {
  final int k = keyCode;
  if (k == 'S') {
    if (looping) noLoop();
    else loop();
  }
}

