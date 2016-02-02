Gestures g;      // create a gesture object
import android.view.MotionEvent;
/*
* This is a game called Connect Remix. This game is an android app
* that takes a twist on the familiar game Connect 4.
* The game combines aspects of 2048 with Connect 4, alowing players
* the ability to shift all the coins left, right, and up. 
* 
* IMPORTANT:
*        1. shift up- when you shift up, coins do go up, but then
*           the board is shifted clockwise, to flip the board over
*           to continue the Connect 4 style Gameplay
*        2. ALPHA BUILD - This build is not meant for regular use
*           This game is a 2 player game, no AI has been made yet
*        3. Coins that are the same color do not "combine" as they
*            would in 2048... Maybe in a future build
*         4. If you are good with AI, please message me!
*
* @author: Ramzey Ghanaim
* @verion: 0.0.1
*
*/
int w =7, h=7, player =1, bs, dir = 5, ypos=20, curx, cury;
boolean done = false;
int[][] board = new int[h][w];
int score1 =0;
int score2 =0;
int count =0;
int dx=0;
int dy=0;
boolean swype = false;
void setup(){
  background(#9D9D9D);
  //size(600,600); ellipseMode(CORNER);
  size(displayWidth,displayHeight); ellipseMode(CORNER);
  bs = displayWidth /w;
 orientation(PORTRAIT); //locks app in portrait mode
  // bs = 600/w;
 g=new Gestures(500,500,this); 
 g.setSwipeUp("swipeUp");    // attach the function called swipeUp to the gesture of swiping upwards
  g.setSwipeDown("swipeDown");    // attach the function called swipeDown to the gesture of swiping downwards
  g.setSwipeLeft("swipeLeft");  // attach the function called swipeLeft to the gesture of swiping left
  g.setSwipeRight("swipeRight");  // attach the function called swipeRight to the gesture of swiping right
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


void drawboard(){
  if( getWinner() ==0){
      for(int j=0; j<h;j++) for(int i =0;i<w;i++){
          fill(#9D9D9D); //BACKGROUND COLOR
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
  
   rectt(0,0,displayWidth, displayHeight,0, color(255,100)); //transparent rectangle
  //rectt(0,0,600, 600,0, color(255,100));
 if(count==0 && getWinner() ==1) {score1++; count++;}
 else if(count==0&&getWinner() ==2) {score2++; count++;}
   textt("Winner is player "+getWinner()+"\n    Tap to restart", bs, 700, 500, 50, color(0),100,CENTER);
   textt("Player 1 score: "+score1+"\n", bs, bs*(h+2),900,700,color(0), 90,LEFT);
   textt("Player 2 score: "+score2+"\n", bs, bs*(h+3),900,700,color(0), 90,LEFT);
   done = true;
 

}
}
void draw(){ //draws the board
  if( getWinner() ==0 ){
    if(swype ==false){
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
    }//swype if
  }
else{
  swype = false;
 rectt(0,0,displayWidth, displayHeight,0, color(255,100)); //transparent rectangle
  //rectt(0,0,600, 600,0, color(255,100));
 if(count==0 && getWinner() ==1) {score1++; count++;}
 else if(count==0&&getWinner() ==2) {score2++; count++;}
   textt("Winner is player "+getWinner()+"\n    Tap to restart", bs, 700, 500, 50, color(0),100,CENTER);
   textt("Player 1 score: "+score1+"\n", bs, bs*(h+2),900,700,color(0), 90,LEFT);
   textt("Player 2 score: "+score2+"\n", bs, bs*(h+3),900,700,color(0), 90,LEFT);
   done = true;
 

}
}
void keyPressed(int key){
   // keyCode = key;
  int kC= keyCode, dy= kC==LEFT?-1:(kC==RIGHT?1:0), dx=kC==DOWN?-1:(kC==UP?1:0);
  int [][]newboard = shift(dy, dx);
  if(newboard!=null){
     board = newboard; 
     drawboard();
     player = player == 1?2:1; //alternates players
    //player = player == 1?2:1; //alternates players
     //if(kC ==RIGHT) player = player == 1?2:1; //alternates players
     
  }
}
//--2048 SHIFTING---------------------------------------------------------------------------------
int [][] shift(int dx, int dy){
 int [][] back= new int [h][w]; 
 //----Make a copy of board-----------
 for(int  j=0;j<board.length;j++){
   for(int i=0;i<w;i++){
    back[j][i] = board[j][i]; 
   }
 }
 //---------------------------
  boolean moved = false;
  
  if(dx!=0 || dy!=0){
    println("non zero dx, dy");
     int d = dx !=0 ? dx: dy; 
     for(int perp =0; perp<board.length;perp++){ //direction perp. where your mvoing
         for(int tang = (d>0 ? board.length-2:1); tang !=(d > 0 ? -1:board.length); tang -=d){  //if moving right, start at end of array, otherwise, beginning
              int y = dx != 0 ? perp : tang, x=dx !=0? tang:perp, ty = y, tx =x;
              if( back[y][x]==0) continue;//if there is a blank space.... continue
              for(int i=(dx!=0 ? x : y)+d; i!=(d>0? board.length : -1);i+=d){ //slide the block
                   int r = dx!= 0 ? y:i, c=dx !=0? i:x; //row and col depend on which direction we are moving in
                   if(back[r][c] !=0) break; //if you hit a point of where to stop, stop
                   if(dx!=0) tx =i;
                   else ty=i;
              }
              
              //x and y are the block position. tx and ty is where the block is sliding (target x, target y)
              if((dx!=0&& tx!=x)||(dy!=0&& ty!= y)){ //now we move the block if ti is empty
               back[ty][tx]= back[y][x];
               back[y][x] = 0;
               moved = true;
              }
              if(moved == true){
                board[y][x] = 0;
                 
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
//----ANDROID SWIPING STUFF ---------------------------------------------------------------------------------------------------------------
// android touch event. 
public boolean surfaceTouchEvent(MotionEvent event) {
 // check what that was  triggered  
  switch(event.getAction()) {
  case MotionEvent.ACTION_DOWN:    // ACTION_DOWN means we put our finger down on the screen 
    g.setStartPos(new PVector(event.getX(), event.getY()));    // set our start position
    break;
  case MotionEvent.ACTION_UP:    // ACTION_UP means we pulled our finger away from the screen  
    g.setEndPos(new PVector(event.getX(), event.getY()));    // set our end position of the gesture and calculate if it was a valid one
    break;
  }
  return super.surfaceTouchEvent(event);
}
// function that is called when we are swiping upwards
void swipeUp() {
 // player = player == 1?2:1; //alternates players
 board[cury][curx] =0;
  dx = -1;
  int [][]newboard = shift(dy, dx);
  if(newboard!=null){
     board = newboard; 
    
     drawboard();
      board = rotate(board);
      drawboard();
      board = rotate(board);
      drawboard();

  }
  dx=0; 
  println("Swype up");
  //rotate board
  
}
//swyping down should never need to occur
void swipeDown() {
  /*board[cury][curx] =0;
  dx = 1;
  int [][]newboard = shift(dy, dx);
  if(newboard!=null){
     board = newboard; 
     drawboard();

  }
  dx=0; 
  println("a swipe down");
  */
 
}
void swipeLeft() {
  board[cury][curx] =0;
  //player = player == 1?2:1; //alternates players
  dy = -1;
  int [][]newboard = shift(dy, dx);
  if(newboard!=null){
    println("gothere");
     board = newboard; 
     drawboard();
  }
  dy=0;
  swype = false;
  println("a swipe left");
 
}
void swipeRight() {
  board[cury][curx] =0;
  dy=1;
  int [][] newboard = shift(dy,dx);
  if(newboard!= null){
       board = newboard;
       drawboard();
  }
  dy=0;
  println("a swipe right");
}
void mousePressed(){
  if(done ==true){
     player =1;  for( int y =0; y<h;y++) for(int x =0; x<w; x++){
     board[y][x] = 0; }
     
     count =0;
  }
  if(done != true && pmouseX-mouseX==0){
   //NOT SHIFITING
   int x = mouseX/bs;
   int y=nextSpace(x);
   curx = x;
   cury=y;
   if(y>=0){
     board[y][x] = player;
     player = player == 1?2:1; //alternates players in basic connect 4 game
   }
  }
  done = false;
}
static int[][] rotate(int[][] mat) {
    final int M = mat.length;
    final int N = mat[0].length;
    int[][] ret = new int[N][M];
    for (int r = 0; r < M; r++) {
        for (int c = 0; c < N; c++) {
            ret[c][M-1-r] = mat[r][c];
        }
    }
    return ret;
}