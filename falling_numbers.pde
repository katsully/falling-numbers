import java.util.Iterator;
import codeanticode.syphon.*;

ArrayList<Number> numbers = new ArrayList<Number>();
int xValue = 0;
int currNum = 1;
int startingNum = 1;
boolean looping = true;
boolean waiting = true;
int numRows = 1;
int rowsStop = 3;
int firstRowNum = 3;  // how many numbers in the first row

SyphonServer server;

void setup() {
  size(850, 400, P2D);
  background(0);
  displayFirstRow(firstRowNum, currNum, xValue);

  // Create syphon server to send frames out
  server = new SyphonServer(this, "Processing Spyhon");
}

void draw() {
  // clear the screen to allow for animation
  background(0);

  // increase the y value to make the numbers 'fall'
  for (Iterator<Number> iter = numbers.iterator (); iter.hasNext(); ) {
    Number num = iter.next();
    num.fall();
    // if number falls off the screen remove from arraylist
    if (num.y > height) {
      iter.remove();
    }
  }

  if (numbers.get(numbers.size()-1).y == 30) {
    if (numRows != rowsStop) {
      // add new row
      int counter = 0;
      for (int i=startingNum; i<=currNum; i++) {
        // if double digit number
        if (i > 10) {
          // offset non single digit numbers
          int offsetX = 0;
          if (startingNum > 10) {
            offsetX = ((i-10)-(startingNum-10)) * 20;
          } else {
            offsetX = (i-10) * 20;
          }
          numbers.add(new Number(str(i), counter*20+offsetX, false));
        } else {
          numbers.add(new Number(str(i), counter*20, false));
        }
        counter++;
      }

      // add three new number at end of line
      if (currNum % 3 == 0) {
        for (int i=0; i<3; i++) {
          if (currNum >= 10) {
            xValue = numbers.get(numbers.size()-1).x + 40;
          } else {
            xValue += 20;
          }
          numbers.add(new Number(str(currNum+1), xValue, false));
          currNum++;
        }
      }
      numRows++;
    } else {
      if (!waiting) {
        if (rowsStop == 5 || (rowsStop == 3 && firstRowNum == 12)) {
          rowsStop=3;
          if (firstRowNum == 12) {
            firstRowNum = 15;
          } else {
            firstRowNum=12;
          }
        } else {
          rowsStop++;
        }
        if (currNum == 63) {
          currNum = 1;
          startingNum = 1;
          rowsStop = 3;
          firstRowNum = 3; 
        } else {
          currNum -=2;
          startingNum = currNum;
        }
        xValue = 0;
        displayFirstRow(firstRowNum, currNum, xValue);
        waiting = true;
        numRows = 1;
      } else {
        waiting = false;
        // add in hidden number which creates space between rows
        numbers.add(new Number(str(0), 0, true));
      }
    }
  }
  server.sendScreen();
}

void displayFirstRow(int firstRow, int curr, int x) {
  this.firstRowNum = firstRow;
  this.currNum = curr;
  this.xValue = x;
  for (int i=0; i<=firstRowNum; i++) {
    numbers.add(new Number(str(currNum), xValue, false));
    if (i<firstRowNum-1) {
      currNum++;
      if (currNum > 10) {
        xValue+=40;
      } else {
        xValue+=20;
      }
    }
  }
} 

// hit P for pause
void keyPressed() {
  final int k = keyCode;
  if (k == 'P') {
    if (looping) noLoop();
    else loop();
  }
}

