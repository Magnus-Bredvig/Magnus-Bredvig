import gifAnimation.*;

GifMaker gifExport;

PFont font;
PImage bgImage;

String includeName = "#include <supergiu>";
String helloWorld = "< hello, world! />";
String currentString;

int text_color = #000000;
int bg_color = #FFFFFF;

int text_size = 70;

int time = 0;

void setup() {
  size(1000, 120);
  frameRate(10);

  font = createFont("fonts/FiraMono-Bold.ttf", 100);
  textFont(font);
  textSize(text_size);

  currentString = includeName;

  gifExport = new GifMaker(this, "gif/hello.gif", 20);
  gifExport.setRepeat(0);
}

void draw() {
  background(bg_color);

  textAnimation();
  
  gifExport.setDelay(1);
  gifExport.addFrame();
}

void textAnimation() {
  time++;

  if(time > 20 && time < 40) {
    currentString = new String(glitchString(currentString, 1));
  }
  else if(time > 40 && time < 80) {
    currentString = new String(transformText(currentString, helloWorld));
  }
  else if(time > 80 && !currentString.equals(includeName)) {
    currentString = new String(transformText(currentString, includeName));
  }
  else if(time > 80 && currentString.equals(includeName)) {
    gifExport.finish();
    exit();
  }

  fill(text_color);
  textSize(text_size);
  text(currentString, width/2 - textWidth(includeName)/2, height/2 + 25);
}

char[] glitchString(String string, int numberOfChars){
  char[] newString = string.toCharArray();

  if(numberOfChars < string.length()){
    int[] charsToGlitch = new int[numberOfChars];

    for(int i = 0; i < numberOfChars; i++) {
      charsToGlitch[i] = int(random(0, string.length()));
    }

    for(int j = 0; j < numberOfChars; j++) {
      newString[charsToGlitch[j]] = (char)int(random(33, 122));
    }
  }

  return newString;
}

char[] transformText(String fromString, String toString) {
  char[] newString = fromString.toCharArray();

  int randomChar;
  Boolean done = false;

  do{
    randomChar = int(random(0, fromString.length()));

    if(randomChar > toString.length() - 1) {
      newString[randomChar] = ' ';
      break;
    }

    if(newString[randomChar] != toString.toCharArray()[randomChar]) {
      newString[randomChar] = toString.toCharArray()[randomChar];
      done = true;
    }
  } while(!done);

  return newString;
}
