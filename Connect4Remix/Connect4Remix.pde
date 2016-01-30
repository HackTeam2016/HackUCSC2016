

int w =7, h=9, player =1, bs, dir = 5, ypos=20;
boolean done = false;
float spring = .05;
float gravity = 0.3;
float friction = -0.6;
int[][] board = new int[h][w];
//---stuff for score keeping --------------
int score1 =0;
int score2 =0;
int count =0;
//----------------------------------------
//---Defining specific text and rectangles------
void rectt(float x,float y,float w, float h, float r, color c){
 fill(c);
 rect(x,y,w,h,r);
}

//text: x position, y position, text box width, text box height
void textt(String t, float x, float y, float w, float h, color c, float s, int align){
   fill(c); textAlign(align); textSize(s); text(t,x,y,w,h);
}
//-------------------------------------------------
void setup(){
  background(#FFFFFF);
  size(displayWidth,displayHeight); ellipseMode(CORNER);
  bs = displayWidth /w;
  orientation(PORTRAIT); //locks app in portrait mode
 
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
     count =0; //resets count
  }
  
   //NOT SHIFITING
   int x = mouseX/bs;
   int y=nextSpace(x);
   if(y>=0){
     board[y][x] = player;
     player = player == 1?2:1; //alternates players
   }
  
}
void draw(){ //draws the board
  if( getWinner() ==0){
      for(int j=0; j<h;j++) for(int i =0;i<w;i++){
          fill(#FFFFFF); //BACKGROUND COLOR
          rect(i*bs,j*bs,bs,bs);
          if(board[j][i]>0){ //red if 1, gre
              fill(board[j][i] == 1?255:0, board[j][i]== 2?2255:0, 0);
              ellipse(i*bs,j*bs, bs, bs);//creates circle at desired location
          }
      }
  }
else{
  rectt(0,0,displayWidth, displayHeight,0, color(255,100)); //transparent rectangle
   done = true;
   //----SCORE STUFF ---------------------------------------------------------
  if(count==0 && getWinner() ==1) {score1++; count++;}
 else if(count==0&&getWinner() ==2) {score2++; count++;}
   textt("Winner is player "+getWinner()+"\n    Tap to restart", bs, 700, 500, 50, color(0),100,CENTER);
   textt("Player 1 score: "+score1+"\n", bs, bs*(h+2),900,700,color(0), 90,LEFT);
   textt("Player 2 score: "+score2+"\n", bs, bs*(h+3),900,700,color(0), 90,LEFT);
//------------------------------------------------------------------------------
}
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