
int w =7, h=7, player =1, bs, dir = 5, ypos=20;
boolean done = false;
int[][] board = new int[h][w];
int score1 =0;
int score2 =0;
int count =0;
int dx=0;
int dy=0;
void setup(){
  background(#FFFFFF);
  size(600,600); ellipseMode(CORNER);
  //size(displayWidth,displayHeight); ellipseMode(CORNER);
  //ANDROID bs = displayWidth /w;
  //ANDROID orientation(PORTRAIT); //locks app in portrait mode
   bs = 600/w;
 
}
void rectt(float x,float y,float w, float h, float r, color c){
 fill(c);
 rect(x,y,w,h,r);
}

//text: x position, y position, text box width, text box height
void textt(String t, float x, float y, float w, float h, color c, float s, int align){
   fill(c); textAlign(align); textSize(s); text(t,x,y,w,h);
}
int nextSpace(int x){ //finds spot in col where the chip is going to go
  for(int y= h-1;y>=0;y--) if(board[y][x] ==0) return y;
  return -1;
}
/*void mouseDragged(){
   if(mouseX<pmouseX){ //shifting left
   background(0);
  text("LEFT", 60, 60);
   for(int i =0;i<w;i++){
     for(int c=0; c<= w; c++){
          while(board[i][c] ==0){
            board[i][c]=board[i][c+1];
            board[i][c+1]=0;
     }
     }
  }
  player = player == 1?2:1;
   } 
}*/
void mousePressed(){
  if(done ==true){
     player =1;  for( int y =0; y<h;y++) for(int x =0; x<w; x++){
     board[y][x] = 0; }
     done = false;
     count =0;
  }
  
   //NOT SHIFITING
   int x = mouseX/bs;
   int y=nextSpace(x);
   if(y>=0){
     board[y][x] = player;
     player = player == 1?2:1; //alternates players in basic connect 4 game
   }
  
}
void drawboard(){
  if( getWinner() ==0){
      for(int j=0; j<h;j++) for(int i =0;i<w;i++){
          fill(#FFFFFF); //BACKGROUND COLOR
          rect(i*bs,j*bs,bs,bs);
          if(board[j][i]>0){ //red if 1, gre
              fill(board[j][i] == 1?255:0, board[j][i]== 2?2255:0, 0);
              //fill(#FF0505); //red piece 
              //ellipse(i*bs,j*bs, bs, bs);//creates circle
              //player = player == 1?2:1; //alternates players
          //    ypos+= dir;
          }
      }
  }
else{
  
 //ANDROID: rectt(0,0,displayWidth, displayHeight,0, color(255,100)); //transparent rectangle
  rectt(0,0,600, 600,0, color(255,100));
 if(count==0 && getWinner() ==1) {score1++; count++;}
 else if(count==0&&getWinner() ==2) {score2++; count++;}
   textt("Winner is player "+getWinner()+"\n    Tap to restart", bs, 700, 500, 50, color(0),100,CENTER);
   textt("Player 1 score: "+score1+"\n", bs, bs*(h+2),900,700,color(0), 90,LEFT);
   textt("Player 2 score: "+score2+"\n", bs, bs*(h+3),900,700,color(0), 90,LEFT);
   done = true;
 

}
}
void draw(){ //draws the board
  if( getWinner() ==0){
      for(int j=0; j<h;j++) for(int i =0;i<w;i++){
          fill(#FFFFFF); //BACKGROUND COLOR
          rect(i*bs,j*bs,bs,bs);
          if(board[j][i]>0){ //red if 1, gre
              fill(board[j][i] == 1?255:0, board[j][i]== 2?2255:0, 0);
              //fill(#FF0505); //red piece 
              ellipse(i*bs,j*bs, bs, bs);//creates circle
          //    ypos+= dir;
          }
      }
  }
else{
  
 //ANDROID: rectt(0,0,displayWidth, displayHeight,0, color(255,100)); //transparent rectangle
  rectt(0,0,600, 600,0, color(255,100));
 if(count==0 && getWinner() ==1) {score1++; count++;}
 else if(count==0&&getWinner() ==2) {score2++; count++;}
   textt("Winner is player "+getWinner()+"\n    Tap to restart", bs, 700, 500, 50, color(0),100,CENTER);
   textt("Player 1 score: "+score1+"\n", bs, bs*(h+2),900,700,color(0), 90,LEFT);
   textt("Player 2 score: "+score2+"\n", bs, bs*(h+3),900,700,color(0), 90,LEFT);
   done = true;
 

}
}
void keyPressed(){
  player = player == 1?2:1; //alternates players
  int kC= keyCode, dy= kC==LEFT?-1:(kC==RIGHT?1:0), dx=kC==DOWN?-1:(kC==UP?1:0);
  int [][]newboard = shift(dy, dx);
  if(newboard!=null){
     board = newboard; 
     drawboard();
    //player = player == 1?2:1; //alternates players
     //if(kC ==RIGHT) player = player == 1?2:1; //alternates players
     
  }
}
//--2048 SHIFTING---------------------------------------------------------------------------------
int [][] shift(int dx, int dy){
 int [][] back= new int [h][w]; 
 //----Make a copy of board-----------
 for(int  j=0;j<h;j++){
   for(int i=0;i<w;i++){
    back[j][i] = board[j][i]; 
   }
 }
 //---------------------------
  boolean moved = false;
  
  if(dx!=0 || dy!=0){
     int d = dx !=0? dx: dy; 
     for(int perp =0; perp<board.length;perp++){ //direction perp. where your mvoing
         for(int tang = (d>0?board.length-2:1); tang !=(d>0 ?-1:board.length); tang-=d){  //if moving right, start at end of array
              int y = dx!= 0? perp:tang, x=dx !=0? tang:perp, ty = y, tx =x;
              if( back[y][x]==0) continue;//if there is a blank space.... continue
              for(int i=(dx!=0?x:y)+d;i !=(d>0? board.length:-1);i+=d){ //slide the block
                   int r = dx!= 0?y:i, c=dx !=0? i:x;
                   if(back[r][c] !=0) break; //if you hit a point of where to stop, stop
                   if(dx!=0) tx =i;
                   else ty=y;
              }
              
              //x and y are the block position. tx and ty is where the block is sliding (target x, target y)
              if((dx!=0&& tx!=x)||(dy!=0&& ty!= y)){ //now we move the block if ti is empty
               back[ty][tx]= back[y][x];
               back[y][x] = 0;
               moved = true;
              }
              if(moved == true){
                board[y][x] = 0;
                 if(player ==1) score1++;
                 if(player ==2) score2++;
              }
         }
       
     }
     
  }
  //player = player == 1?2:1; //alternates players
  return moved? back : null;
}
int p(int y, int x){//makes sure 4 in a row is not off the board
   return (y<0|| x<0|| y>=h || x>= w)?0:board[y][x]; //return 0 if off the board, or location on board
}
int getWinner(){
  //checks for rows
for(int y=0; y<h;y++) for(int x=0;x<w;x++)
  if(p(y,x)!= 0 && p(y,x)==p(y,x+1)&&p(y,x)==p(y,x+2)&&p(y,x)==p(y,x+3)) return p(y,x);
  
  //checks for columns
  for(int y=0; y<h;y++) for(int x=0;x<w;x++)
    if(p(y,x)!= 0 && p(y,x)==p(y+1,x)&&p(y,x)==p(y+2,x)&&p(y,x)==p(y+3,x)) return p(y,x);
  
  //checks for diagonals:
  for( int y =0; y<h;y++) for(int x =0; x<w; x++)for(int d=-1;d<=1;d+=2)
     if(p(y,x) !=0 && p(y,x) == p(y+1*d,x+1)&& p(y,x) == p(y+2*d,x+2) && p(y,x) == p(y+3*d,x+3)) return p(y,x);
     
     //if board is not done:
for( int y =0; y<h;y++) for(int x =0; x<w; x++) if(p(x,y) ==0) return 0;
  
  return -1; //tie
  
}