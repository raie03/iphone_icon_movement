class Icon
{
  float x;
  float y;
  int w = 100;
  int h = 100;
  boolean D = false;
  boolean M = false;
  int id;
  int id2;
  float tx;
  float ty;
  float lx;
  float ly;

  float mTime;
  Icon(float _x, float _y, int _id, int _id2)
  {
    id = _id;
    x = 40+(id%4)*140;
    //x = _x;
    y = 40+(id/4)*140;
    //y = _y;
    id2 = _id2;
  }

  void display()
  {
    noFill();
    rect(x, y, w, h);
    fill(0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text(id, x+w/2, y+h/2);
    //text(id2, x+w/2+50, y+h/2);
    textSize(10);
    text(x + " : "+ y, x+w/2, y+h/2+20);
  }

  void dragg()
  {
    if (D == true)
    {
      x = mouseX - w/2;
      y = mouseY - h/2;
    }
  }

  void move()
  {
    if (M == true)
    {  
      pTime = millis() - mTime;
      float timeRate = pTime / time; //timeで設定した時間に動作が終わるようにするための割合
      float changeX = lx; //x移動量
      float changeY = ly; //y移動量
      float ease = map(timeRate, 0, 1, -sigmoid_x, sigmoid_x);
      float icon_x = map(1/(1+pow(2.718, -ease)), 0, 1, x, tx);
      float icon_y = map(1/(1+pow(2.718, -ease)), 0, 1, y, ty);
      
      if (abs(x - tx) >= 2)
      {
        if(easing == true)
          x =icon_x;
        else
          x += changeX/speed;
      }
      else
      {
        x = tx;
      }
      if (abs(y - ty) >= 2)
      {
        if(easing == true)
          y = icon_y;
        else
          y += changeY/speed;
      }
      else
      {
        y = ty;
      }

      if (x == 40+(id%4)*140 && y == 40+(id/4)*140)
      {
        M = false;
        isMoving = false;
      }
    }
  }
}
