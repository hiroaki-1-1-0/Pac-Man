import ddf.minim.*;
Minim minim;
AudioPlayer player;

void setup(){
  size(800, 450); // 画面サイズのアスペクト比を4:3に指定
  smooth(); // エッジの角落とし（一応）
  frameRate(80); // フレームレートを80に設定
  minim = new Minim(this);
  player = minim.loadFile("./pac_man.mp3");
  player.play();}

int count1 = 0, count2 = 0, count3 = 0; // 口の逐次的制御用のカウンター、障害物への接触回数計算用のカウンター、障害物の色の変更用のカウンター
float d = 60, x = 0, y = 0, vx = 5, vy = 5, pi = PI/4; // パックマンの半径、座標、速度を設定
void draw(){
  background(0); // 背景色を黒色に指定
  if (count3 >= 0) fill(0); // 障害物の色を黒色に指定
  else fill(255, 255, 0); // 障害物の色を黄色に指定
  stroke(0, 0, 200); // 障害物の輪郭線の色を青色に指定
  strokeWeight(4); // 障害物の輪郭線の太さを4に指定
  rectMode(CENTER); // 障害物の座標指定方法を「中央」に指定
  rect(width/2, height/2, 300, 120); // 障害物を描画
  noStroke(); // 輪郭線の非表示
  fill(255, 255, 0); // パックマンの色を黄色に指定
  arc(x+30, y+30, 60, 60, abs(sin(count1*0.2))*PI/4+pi, PI*2 - abs(sin(count1*0.2))*PI/4+pi, PIE); // 口を開閉するパックマンの描画
  x += vx; y += vy; // パックマンの座標の仮変更
  fill(255); // 文字の色を白色に指定
  textSize(50);
  textAlign(CENTER);
  text(str(count2), width/2, height/2); // 障害物への接触回数の表示
  
  // 左側にはみ出したパックマンへの対応
  if (x < 0) {
    vx *= -1;
    x = -x;
    if (vy > 0) pi -= PI/2;
    else pi += PI/2;
  }
  // 外枠の上側にはみ出したパックマンへの対応
  else if (y < 0) { 
    vy *= -1;
    y *= -1;
    if (vx > 0) pi += PI/2;
    else pi -= PI/2;
  }
  // 外枠の右側にはみ出したパックマンへの対応
  else if (x+d > width) { 
    vx *= -1;
    x = (2 * width) - x - (d * 2);
    if (vy > 0) pi += PI/2;
    else pi -= PI/2;
  }
  // 外枠の下側にはみ出したパックマンへの対応
  else if (y+d > height) { 
    vy *= -1;
    y = (2 * height) - y - (d * 2);
    if (vx > 0) pi -= PI/2;
    else pi += PI/2;
  }

  // 障害物を左側からはみ出したパックマンへの対応
  if ((x < width/2-152) && (x+60 > width/2-152) && (y+30 > height/2-62) && (y+30 < height/2+62) && (vx > 0)) { 
    vx *= -1;
//    x = width/2 - 152 -60 - ((x + 60) - width/2 + 152);
    x = width - x - 424;
    if (vy > 0) pi += PI/2;
    else pi -= PI/2;
    count2 += 1;
    count3 = -21;
  }
  // 障害物を右側からはみ出したパックマンへの対応
  else if ((x < width/2+152) && (x+60 > width/2+152) && (y+30 > height/2-62) && (y+30 < height/2+62) && (vx < 0)) { 
    vx *= -1;
//    x = x + 2 * (width/2 + 152 - x);
    x = width + 304 - x;
    if (vy > 0) pi -= PI/2;
    else pi += PI/2;
    count2 += 1;
    count3 = -21;
  }
  // 障害物を上からはみ出したパックマンへの対応
  else if ((x+30 < width/2+152) && (x+30 > width/2-152) && (y+60 > height/2-62) && (y < height/2-62) && (vy > 0)) { 
    vy *= -1;
//    y = y - 2 * (y + 60 - height/2 + 62);
    y = -y + height - 244;
    if (vx > 0) pi -= PI/2;
    else pi += PI/2;
    count2 += 1;
    count3 = -21;
  }
  // 障害物を下からはみ出したパックマンへの対応
  else if ((x+30 < width/2+152) && (x+30 > width/2-152) && (y+60 > height/2+62) && (y < height/2+62) && (vy < 0)) { 
    vy *= -1;
//    y = y + 2 * (height/2 + 62 - y);
    y = - y + height +124;
    if (vx > 0) pi += PI/2;
    else pi -= PI/2;
    count2 += 1;
    count3 = -21;
  }
  
  if (count1 == 80 * 7.5){
    vx *= 5;
    vy *= 5;
  }

  count1 += 1;
  count3 += 1;
}
void stop() {
  minim.stop();
  super.stop();
}
