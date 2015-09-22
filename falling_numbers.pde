import java.util.Iterator;
import codeanticode.syphon.*;

ArrayList<Number> numbers = new ArrayList<Number>();
int xValue = 0;
int currNum = 1;
int startingNum = 1;
boolean looping = true;
boolean waiting = true;

SyphonServer server;

void setup() {
  size(400, 600, P2D);
  background(0);
  numbers.add(new Number(str(currNum), xValue, false));
  currNum++;
  xValue+=20;
  numbers.add(new Number(str(currNum), xValue, false));
  currNum++;
  xValue += 20;
  numbers.add(new Number(str(currNum), xValue, false));

  // Create syphon server to send frames out
  server = new SyphonServer(this, "Processing Spyhon");
}

void draw(){
  // clear the screen to allow for animation
  background(0);
  
  // increase the y value to make the numbers 'fall'
  for (Iterator<Number> iter = numbers.iterator (); iter.hasNext(); ) {
    Number num = iter.next();
    fill(num.c);
    text(num.num, num.x, num.y);
    num.y++;
    // if number falls off the screen remove from arraylist
    if (num.y > height) {
      iter.remove();
    }
  }

  if (numbers.get(numbers.size()-1).y == 30) {
    // get static copy of size so it won't be affected by adding to numbers
    int currSize = numbers.size();

    // if currNum divisble by nine insert a break
//    println("conditional statement" + str(currNum % 9 != 0 && startingNum == 1));
    println("currNum " + str(currNum));
    println("starting number" + str(startingNum));
    if (currNum % 9 != 0 || startingNum != 1) {
      // add new row
      int counter = 0;
      for (int i=startingNum; i<=currNum; i++) {
        // if single digit number
        if (i > 10) {
          int offsetX = 0;//(startingNum-9);
          numbers.add(new Number(str(i), counter*20+offsetX, false));
        } else {
          numbers.add(new Number(str(i), counter*20, false));
        }
        counter++;
      }

      // add three new number at end of line
      if (currNum % 3 == 0) {
        for (int i=0; i<3; i++) {
          // TODO fix issue adding in 11
          if (currNum >= 10) {
            xValue = numbers.get(numbers.size()-1).x + 40;
          } else {
            xValue += 20;
          }
          numbers.add(new Number(str(currNum+1), xValue, false));
          currNum++;
        }
      }
    } else {
      println(waiting);
      if (!waiting) {
        currNum = 7;
        startingNum = 7;
        xValue = 0;
        numbers.add(new Number(str(currNum), xValue, false));
        currNum++;
        xValue+=20;
        numbers.add(new Number(str(currNum), xValue, false));
        currNum++;
        xValue += 20;
        numbers.add(new Number(str(currNum), xValue, false));
        waiting = true;
      } else {
        println("here");
        waiting = false;
        numbers.add(new Number(str(0), 0, true));
      }
    }
  }
  server.sendScreen();
}

// hit P for pause
void keyPressed() {
  final int k = keyCode;
  if (k == 'P') {
    if (looping) noLoop();
    else loop();
  }
}

