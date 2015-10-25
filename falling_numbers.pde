import codeanticode.syphon.*;
import java.util.Iterator;

ArrayList<Number> numbers = new ArrayList<Number>();
int currNum, startingNum, phraseLength, phraseGroups, phraseCounter;
boolean fallingDown = true;
boolean left = true;
boolean up = true;
float xValue = 100;
float yValue = 0;

SyphonServer server;

void setup() {
  size(1024, 768, P2D);
  background(0);
  reset();
  numbers.add(new Number(str(currNum), fallingDown, xValue, yValue));

  //Create syphon server to send frames out
  server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  // clear the screen to allow for animation
  background(0);

  // increase the y value to make the numbers 'fall'
  for (Iterator<Number> iter = numbers.iterator (); iter.hasNext(); ) {
    Number num = iter.next();
    num.fall();
    println("number: " + num.num + " x value " + num.x);
    // if number falls off the screen remove from arraylist
    if (num.y > height || num.x > width) {
      iter.remove();
    }
  }
  if (numbers.get(numbers.size()-1).fallingDown) {
    if (numbers.get(numbers.size()-1).y == 30) {
      currNum++;
      numbers.add(new Number(str(currNum), fallingDown, xValue, yValue));
    }
  } else {
    if (numbers.get(numbers.size()-1).x == 30) {
      currNum++;
      numbers.add(new Number(str(currNum), fallingDown, xValue, yValue));
    }
  }  

  if (phraseLength == (currNum-startingNum)) {
    if (currNum == 63) {
      reset();
    } else if (phraseCounter == phraseGroups) {
      if (phraseGroups == 5 || currNum == 45) {
        phraseGroups = 3;
        phraseLength = (currNum == 45) ? 15 : 12;
      } else {
        phraseGroups++;
        phraseLength = 3;
      }
      phraseCounter = 1;
      startingNum = currNum-3;
    } else {
      phraseLength += 3;
      phraseCounter ++;
    }
    //    xValue = (int)random(0, width-50);
    currNum = startingNum;
    if (fallingDown) {
      left = !left;
    } else {
      up = !up;
    }
    fallingDown = !fallingDown;
    if (fallingDown) {
      if (left) {
        xValue = random(255);
      } else {
        xValue = random(width-450, width);
      }
       yValue = 0;
    } else {
      if (up) {
        yValue = random(150);
      } else {
        yValue = random(height-300, height);
      }
      xValue = 0;
    }
  }
  fill(0);
  rect(225, 150, width-450, height-300);
  server.sendScreen();
}

void reset() {
  currNum = 1;
  startingNum = 0;
  phraseLength = 3;
  phraseGroups = 3;
  phraseCounter = 1;
}

// hit P for pause
void keyPressed() {
  final int k = keyCode;
  if (k == 'P') {
    if (looping) noLoop();
    else loop();
  }
}

