/* bokeh.js - P5.js bokeh background animation */

let bokehs = [];
const NUM_BOKEH = 25;
let inputX, inputY;
let parallaxX = 0, parallaxY = 0;

function setup() {
  frameRate(30);
  const cnv = createCanvas(windowWidth, windowHeight);
  cnv.id('bgCanvas');
  
  for (let i = 0; i < NUM_BOKEH; i++) {
    bokehs.push(new Bokeh());
  }
}

function draw() {
  clear();
  
  parallaxX += ((inputX || width/2) - width/2 - parallaxX) * 0.05;
  parallaxY += ((inputY || height/2) - height/2 - parallaxY) * 0.05;
  
  bokehs.forEach(b => {
    b.update();
    b.show(parallaxX * (b.size/500), parallaxY * (b.size/500));
  });
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}

function mouseMoved() {
  inputX = mouseX;
  inputY = mouseY;
}

function touchMoved() {
  inputX = mouseX;
  inputY = mouseY;
  return false;
}

class Bokeh {
  constructor() {
    this.reset();
  }
  
  reset() {
    this.x = random(-width, width * 2);
    this.y = random(-height, height * 2);
    this.size = random(85, 300);
    this.alpha = random(80, 200);
    this.speedX = random(-2, 1.5);
    this.speedY = random(-2, 1);
  }
  
  update() {
    this.x += this.speedX;
    this.y += this.speedY;
    
    if (this.x < -this.size) this.x = width + this.size;
    if (this.x > width + this.size) this.x = -this.size;
    if (this.y < -this.size) this.y = height + this.size;
    if (this.y > height + this.size) this.y = -this.size;
  }
  
  show(offsetX, offsetY) {
    const ctx2 = drawingContext;
    ctx2.save();
    
    ctx2.shadowBlur = this.size / 5;
    ctx2.shadowColor = `rgba(245, 222, 179, ${this.alpha / 255 * 0.6})`;
    ctx2.shadowOffsetX = -this.size * 0.05;
    ctx2.shadowOffsetY = -this.size * 0.05;
    
    noStroke();
    fill(245, 222, 179, this.alpha * 0.8);
    ellipse(this.x + offsetX, this.y + offsetY, this.size);
    
    ctx2.shadowBlur = this.size / 10;
    ctx2.shadowColor = `rgba(0, 0, 0, ${this.alpha / 255 * 0.1})`;
    ctx2.shadowOffsetX = -this.size * 0.03;
    ctx2.shadowOffsetY = -this.size * 0.05;
    
    fill(245, 222, 179, this.alpha * 0.4);
    ellipse(this.x + offsetX, this.y + offsetY, this.size * 0.9);
    
    ctx2.restore();
  }
}