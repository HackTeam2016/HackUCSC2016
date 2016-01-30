

int w =7, h=9, player =1, bs;
int[][] board = new int[h][w];
void setup(){
  background(#FFFFFF);
  size(displayWidth,displayHeight); ellipseMode(CORNER);
  bs = displayWidth /w;
 
}
int nextSpace(int x){ //finds spot in col where the chip is going to go
  for(int y= h-1;y>=0;y--) if(board[y][x] ==0) return y;
  return -1;
}
void mousePressed(){
  if(mouseX<pmouseY){ //shifting left
   for(int i =0;i<w;i++){
     for(int c=0; c<= w; c++){
          while(board[i][c] ==0){
            board[i][c]=board[i][c+1];
            board[i][c+1]=0;
     }
     }
  }
  player = player == 1?2:1;
     return;
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
              //fill(#FF0505); //red piece 
              ellipse(i*bs,j*bs, bs, bs);//crates circle
          }
      }
  }
else{
  textSize(225);
 background(0); 
 fill(255); text("Winner is player "+getWinner()+". Tap to restart", displayWidth/2, displayHeight/2);
 if(keyPressed){
   player =1;
   for( int y =0; y<h;y++) for(int x =0; x<w; x++){
      board[y][x] = 0;
   }
 }
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