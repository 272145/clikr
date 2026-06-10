
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
final int OPTIONS = 4;

int mode = INTRO;


float x, y;
float vx, vy;
float d = 80;

int score = 0;
int lives = 3;
int highscore = 0;


int targetType = 0;

float sliderX = 300;
boolean dragging = false;



void setup() {
  size(900, 700);

  rectMode(CORNER);
  textAlign(CENTER, CENTER);

  resetGame();
}



void draw() {

  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == PAUSE) {
    pauseScreen();
  } else if (mode == GAMEOVER) {
    gameOver();
  } else if (mode == OPTIONS) {
    options();
  }
}



void intro() {

  background(215);

  // panel
  fill(190);
  stroke(100);
  rect(200, 120, 500, 400);

  fill(70);
  textSize(42);
  text("MINI CLICKER", width/2, 200);

  // buttons
  button(300, 320, 120, 50, "Start");
  button(480, 320, 120, 50, "Options");

  fill(100);
  textSize(14);
  text("Click the moving target to score points.", width/2, 470);
}



void game() {

  background(230);

  // top bar
  fill(180);
  noStroke();
  rect(0, 0, width, 60);

  fill(0);
  textAlign(LEFT, CENTER);
  textSize(24);

  text("Score: " + score, 20, 30);
  text("Lives: " + lives, 200, 30);

  // pause button
  button(760, 12, 110, 35, "PAUSE");


  x += vx;
  y += vy;


  if (x < d/2 || x > width - d/2) {
    vx *= -1;
  }

  if (y < d/2 + 60 || y > height - d/2) {
    vy *= -1;
  }


  drawTarget(x, y, d);

  // game over
  if (lives <= 0) {

    if (score > highscore) {
      highscore = score;
    }

    mode = GAMEOVER;
  }
}


void pauseScreen() {

  background(200);

  fill(100);
  textSize(60);
  text("PAUSE", width/2, 200);

  button(width/2 - 100, 350, 200, 60, "RESUME");

  fill(80);
  textSize(24);
  text("Score: " + score, width/2, 500);
  text("Lives: " + lives, width/2, 540);
}



void gameOver() {

  background(180, 0, 0);

  fill(255);

  textSize(60);
  text("GAME OVER", width/2, 220);

  textSize(34);
  text("Score: " + score, width/2, 340);

  text("High Score: " + highscore, width/2, 410);

  textSize(22);
  text("Click anywhere to return to menu", width/2, 560);
}



void options() {

  background(215);

  // panel
  fill(190);
  stroke(100);
  rect(180, 80, 540, 540);

  fill(70);
  textSize(42);
  text("OPTIONS", width/2, 140);

  // target buttons
  button(260, 220, 120, 60, "CAT");
  button(520, 220, 120, 60, "GHOST");

  
  fill(0);
  textSize(24);
  text("Target Size", width/2, 340);

  // slider line
  stroke(0);
  strokeWeight(4);
  line(250, 400, 650, 400);

  // slider knob
  fill(255);
  stroke(0);
  circle(sliderX, 400, 24);

  
  d = map(sliderX, 250, 650, 40, 160);


  fill(0);
  textSize(24);
  text("Preview", width/2, 470);

  drawTarget(width/2, 550, d);

  // back button
  button(30, 30, 100, 40, "BACK");
}



void drawTarget(float tx, float ty, float ts) {

  if (targetType == 0) {

    drawCat(tx, ty, ts);

  } else {

    drawGhost(tx, ty, ts);
  }
}



void drawCat(float x, float y, float s) {

  noStroke();

  fill(240);

  // head
  ellipse(x, y, s, s);

  // ears
  triangle(x-s/3, y-s/4,
           x-s/6, y-s/2,
           x, y-s/4);

  triangle(x+s/3, y-s/4,
           x+s/6, y-s/2,
           x, y-s/4);

  // eyes
  fill(0);

  ellipse(x-s/5, y, s/10, s/10);
  ellipse(x+s/5, y, s/10, s/10);

  // nose
  triangle(x, y+s/12,
           x-s/18, y+s/7,
           x+s/18, y+s/7);
}



void drawGhost(float x, float y, float s) {

  fill(255);

  // head
  ellipse(x, y-s/6, s, s);

  // body
  rectMode(CENTER);
  rect(x, y+s/6, s, s);

  // bottom waves
  ellipse(x-s/3, y+s/2, s/3, s/3);
  ellipse(x, y+s/2, s/3, s/3);
  ellipse(x+s/3, y+s/2, s/3, s/3);

  // eyes
  fill(0);

  ellipse(x-s/5, y-s/6, s/10, s/6);
  ellipse(x+s/5, y-s/6, s/10, s/6);
}



void button(float x, float y, float w, float h, String label) {

  // button body
  fill(220);
  stroke(120);
  rect(x, y, w, h);

  // hover effect
  if (mouseX > x &&
      mouseX < x+w &&
      mouseY > y &&
      mouseY < y+h) {

    stroke(255);
    strokeWeight(3);

  } else {

    stroke(90);
    strokeWeight(1);
  }

  rect(x, y, w, h);

  stroke(255);
  line(x, y, x+w, y);
  line(x, y, x, y+h);

  // shadow
  stroke(70);
  line(x+w, y, x+w, y+h);
  line(x, y+h, x+w, y+h);


  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(label, x+w/2, y+h/2);
}



boolean overButton(float x, float y, float w, float h) {

  return mouseX > x &&
    mouseX < x+w &&
    mouseY > y &&
    mouseY < y+h;
}



void mousePressed() {

  
  if (mode == INTRO) {

    // start
    if (overButton(300, 320, 120, 50)) {

      resetGame();
      mode = GAME;
    }


    if (overButton(480, 320, 120, 50)) {

      mode = OPTIONS;
    }
  }

  
  else if (mode == GAME) {

    // pause button
    if (overButton(760, 12, 110, 35)) {

      mode = PAUSE;
      return;
    }

    boolean hit = false;

    // hitbox
    if (targetType == 0) {

      if (dist(mouseX, mouseY, x, y) < d/2) {
        hit = true;
      }
    }

    else {

      if (mouseX > x-d/2 &&
          mouseX < x+d/2 &&
          mouseY > y-d/2 &&
          mouseY < y+d/2) {

        hit = true;
      }
    }

 
    if (hit) {

      score++;

      vx *= 1.08;
      vy *= 1.08;

    } else {

      lives--;
    }
  }


  else if (mode == PAUSE) {

    if (overButton(width/2 - 100, 350, 200, 60)) {
      mode = GAME;
    }
  }


  else if (mode == OPTIONS) {

    // cat
    if (overButton(260, 220, 120, 60)) {
      targetType = 0;
    }

    // ghost
    if (overButton(520, 220, 120, 60)) {
      targetType = 1;
    }

    // back
    if (overButton(30, 30, 100, 40)) {
      mode = INTRO;
    }

    // slider
    if (dist(mouseX, mouseY, sliderX, 400) < 20) {
      dragging = true;
    }
  }


  else if (mode == GAMEOVER) {

    resetGame();
    mode = INTRO;
  }
}



void mouseDragged() {

  if (mode == OPTIONS && dragging) {

    sliderX = mouseX;

    sliderX = constrain(sliderX, 250, 650);
  }
}



void mouseReleased() {

  dragging = false;
}



void resetGame() {

  score = 0;
  lives = 3;

  x = width/2;
  y = height/2;

  vx = random(-4, 4);
  vy = random(-4, 4);

  // make it faster
  
  if (abs(vx) < 2) vx = 3;
  if (abs(vy) < 2) vy = -3;
}
