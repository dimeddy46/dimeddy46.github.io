int speed = 2, playerSize = 20, targetSize = 10, windowSafezone = targetSize / 2, lastSecond = 0;

float x1, y1, pX, pY, x2, y2;
float viewArea = 30.0, finalX, finalY, fps;
Dot fovLeft = new Dot(0,0), fovRight = new Dot(0,0);
boolean[] keys = new boolean[4];
ArrayList<Line> lines = new ArrayList<Line>();

Shape[] shapes = new Shape[] 
{
      new Shape(200, 300, 50), 
      new Shape(600, 600, 50), 
      new Shape(100, 700, 70),
      new Shape(900, 200, 100),
      new Shape(1000, 400, 100),
      new Shape(400, 300, 100),
      new Shape(600, 200, 100),
};
void setup() 
{     
     frameRate(120);
     size(1200, 800);
     x1 = width / 2;
     y1 = height / 2;
}

void printFrameRate()
{ 
     if(second() != lastSecond)
     { 
         fps = frameRate;
         lastSecond = second();
     }
     
     fill(0,0,255);
     textSize(18);
     text("FPS: "+floor(fps), 10, 20); 
}

void draw()
{
    background(200);
    printFrameRate();
    drawShapes();
    getPlayerInput();  
    setMouseProjection(); 
    
    float[] collision = computeCollision();     
    if(collision[0] != -1)
    { 
        finalX = collision[0];
        finalY = collision[1];
    }
    
    setFOV();
}

void setFOV(){
     
}

void drawShapes() 
{
    for(int i = 0;i < shapes.length; ++i)
    {
        shapes[i].drawObject();
    }   
    
    // player target 
    fill(255, 0, 0);
    rect(finalX - targetSize / 2, finalY - targetSize / 2, targetSize, targetSize);
    line(pX, pY, finalX, finalY);
}

void getPlayerInput()
{
    if(keys[0]) y1 -= speed;
    if(keys[1]) y1 += speed;
    if(keys[2]) x1 -= speed;
    if(keys[3]) x1 += speed;
    fill(255, 0, 0);
    rect(x1, y1, playerSize, playerSize);
    
    pX = x1+playerSize / 2; 
    pY = y1+playerSize / 2;
    
    x2 = mouseX;
    y2 = mouseY;      
}

void keyPressed() 
{ 
    switch(key) 
    {
       case 'w' : keys[0] = true; break;
       case 's' : keys[1] = true; break;
       case 'a' : keys[2] = true; break;
       case 'd' : keys[3] = true; break;
    }
}

void keyReleased() 
{
    switch(key) 
    {
       case 'w' : keys[0] = false; break;
       case 's' : keys[1] = false; break;
       case 'a' : keys[2] = false; break;
       case 'd' : keys[3] = false; break;
    }
}
