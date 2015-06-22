//colorjam
//draw a series of vertical stripes based on color algorithms
int w = 1024;
int h = 300;

//tweakable vars
int RANGE = 120;
int MINRANGE = 80;
int MINWID = 3;
int MAXWID = 30;
int SAT = 220;
int BRI = 230;
int SEED = 180;

StripeDraw stripeDraw;

//a class for an agent that draws the stripes
class StripeDraw {
  int stHue, stLoc, stWid, stWidLast, stHei, stopLoc, stSat, stBri, stHueRange, stMinHueRange, stMinWid, stMaxWid;

  //constructor
  StripeDraw(int wid, int hei, int range, int minRange, int end, int minWid, int maxWid, int bri, int sat, int seedHue) {
    this.stHue = seedHue;
    this.stHueRange = range;
    this.stMinHueRange = minRange;
    this.stBri = bri;
    this.stSat = sat;
    this.stLoc = 0;
    this.stWid = 0;
    this.stHei = hei;
    this.stMinWid = minWid;
    this.stMaxWid = maxWid;
    this.stopLoc = end;
  }

  //update the agent's attribute
  void update() {
    int hueShft = floor(random(this.stHueRange)-stHueRange/2);
    this.stHue += hueShft;
    if (this.stHue > 255) {
      this.stHue -= 255;
    } else if (this.stHue < 0) {
      this.stHue += 255;
    }
    this.stWidLast = this.stWid;
    this.stWid = floor(map(abs(hueShft), 0, this.stHueRange/2, this.stMinWid, this.stMaxWid));
    this.stLoc += this.stWidLast;
  }

  //take the current state and render the corresponding stripe
  void render() {
    //force color mode at render time
    colorMode(HSB);
    noStroke();
    fill(this.stHue, this.stSat, this.stBri);
    rect(this.stLoc, 0, this.stWid, this.stHei);
  }
}

void setup() {
  size(w, h);

  //StripeDraw(int wid, int hei, int range, int minRange, int end, int minWid, int maxWid, int bri, int sat, int seedHue); 
  stripeDraw = new StripeDraw(w, h, RANGE, MINRANGE, w, MINWID, MAXWID, SAT, BRI, SEED);

  //while the agent has space to move on the campus, keep drawing stripes
  while (stripeDraw.stLoc < stripeDraw.stopLoc) {
    stripeDraw.update();
    stripeDraw.render();
  }

  //save the image
  save("./renders/" + floor(random(2000)) + ".jpg");
}

