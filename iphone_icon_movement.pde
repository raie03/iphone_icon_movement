//iPhoneのホーム画面でのアプリの位置の入れ替えをするときの動作
ArrayList<Icon> icon = new ArrayList<Icon>();
Icon draggId;
int draggId2;
float time =500;//動作完了までの速さ(ms)
float sigmoid_x = 3;//イージングの緩急の強さ(オリジナルは3)
int distance = 60; //移動を開始するまでの距離
boolean easing = true; //イージングをするか
float pTime = 0;
int a;
int b;
int c;
int iconNum = 4;//アイコンの段数
int ids[] = new int[iconNum*4];
boolean isMoving = false;
float speed = 5; //アイコンの移動速度
void setup()
{
  size(600, 900);
  for (int i=0; i<iconNum; i++)
  {
    for (int j=0; j<4; j++)
    {
      icon.add(new Icon(40+j*140, 40+i*140, i*4+j, i*4+j));
    }
  }
  
  for(int i=0; i<ids.length; i++)
  {
    ids[i] = i;
  }
}

void draw()
{
  background(255);
  for (int i=0; i<icon.size(); i++)
  {
    icon.get(i).display();
    icon.get(i).dragg();
    if (draggId != null && icon.get(i).M == false)
    {
      if (dist(icon.get(draggId2).x, icon.get(draggId2).y, icon.get(i).x, icon.get(i).y) <distance && icon.get(draggId2).id != icon.get(i).id)
      {
        isMoving = true;
        
        int tmp = icon.get(i).id;
        //int tmp2 = icon.get(draggId2).id;

        if (icon.get(i).id > icon.get(draggId2).id && icon.get(draggId2).x > icon.get(i).x)//前から後ろに持ってくるとき　移動したいアイコンより右側にいる時
        {
          a = icon.get(draggId2).id;
          b = icon.get(i).id;
          c = draggId2;
          for (int j=icon.get(i).id-1; j>=icon.get(draggId2).id; j--)
          {
            if (icon.get(ids[j+1]).id > icon.get(ids[j]).id)
            {
              icon.get(ids[j+1]).id = icon.get(ids[j]).id;
              icon.get(ids[j+1]).mTime = millis();
              icon.get(ids[j+1]).M = true;
              
            }
            else
            {
              icon.get(ids[j]).id = icon.get(ids[j+1]).id;
              icon.get(ids[j]).mTime = millis();
              icon.get(ids[j]).M = true;
              
            }
          }
          
          
          for(int j = a; j < b; j++)
          {
            ids[j] = ids[j+1];
          }
          ids[b] = c;
          icon.get(draggId2).id = tmp;
        }
        
        
        else if(icon.get(i).id < icon.get(draggId2).id && icon.get(draggId2).x < icon.get(i).x)//後ろから前に持ってくるとき　移動したいアイコンより左側にいる時
        {
          a = icon.get(draggId2).id;
          b = icon.get(i).id;
          c = draggId2;
          
          for (int j=icon.get(i).id; j<=icon.get(draggId2).id-1; j++)
          {
            if (icon.get(ids[j+1]).id > icon.get(ids[j]).id)
            {
              icon.get(ids[j]).id = icon.get(ids[j+1]).id;
              icon.get(ids[j]).mTime = millis();
              icon.get(ids[j]).M = true;
            }
            else
            {
              icon.get(ids[j+1]).id = icon.get(ids[j]).id;
              icon.get(ids[j]).mTime = millis();
              icon.get(ids[j]).M = true;
            }
          }
          
          for(int j = a-1; j >= b; j--)
          {
            ids[j+1] = ids[j];
          }
          ids[b] = c;
          icon.get(draggId2).id = tmp;
        }
        icon.get(i).mTime = millis();
        icon.get(i).M = true;
        icon.get(i).tx = 40+(icon.get(i).id%4)*140;
        icon.get(i).ty = 40+(icon.get(i).id/4)*140;
        icon.get(i).lx = 40+(icon.get(i).id%4)*140 - icon.get(i).x;
        icon.get(i).ly = 40+(icon.get(i).id/4)*140 - icon.get(i).y;
      }
    }
    icon.get(i).tx = 40+(icon.get(i).id%4)*140;
    icon.get(i).ty = 40+(icon.get(i).id/4)*140;
    icon.get(i).lx = 40+(icon.get(i).id%4)*140 - icon.get(i).x;
    icon.get(i).ly = 40+(icon.get(i).id/4)*140 - icon.get(i).y;

    icon.get(i).move();
  }
}

void mousePressed()
{
  for (int i=0; i<icon.size(); i++)
  {
    if (mouseX > icon.get(i).x && mouseX < icon.get(i).x + 100 && mouseY > icon.get(i).y && mouseY < icon.get(i).y+100)
    {
      icon.get(i).D = true;
      draggId = icon.get(i);
      draggId2 = i;
    }
    
  }
  println("idの順番は"+icon.get(draggId2).id + " : " +  "配列の順番は"+ draggId2);
  print("ids: ");
  for(int i=0;i<ids.length;i++)
  {
    print(ids[i] + ":");
  }
  
  println();
  println(draggId2);
  println("draggId2:"+a);
  println("icon.get(i).id:"+b);
}

void mouseReleased()
{
  for (int i=0; i<icon.size(); i++)
  {
    if (icon.get(i).D == true)
    {
      icon.get(i).D = false;
      isMoving = true;

      icon.get(i).M = true;
      icon.get(i).tx = 40+(icon.get(i).id%4)*140;
      icon.get(i).ty = 40+(icon.get(i).id/4)*140;
      icon.get(i).lx = 40+(icon.get(i).id%4)*140 - icon.get(i).x;
      icon.get(i).ly = 40+(icon.get(i).id/4)*140 - icon.get(i).y;
      icon.get(i).mTime = millis();
    }
  }
}
