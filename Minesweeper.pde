import de.bezier.guido.*;
final static int NUM_ROWS = 20;
final static int NUM_COLS = 20;
private boolean lose = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

public void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make(this);

  //your code to declare and initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];

  for (int row = 0; row < buttons.length; row++) {
    for (int col = 0; col < buttons[row].length; col++) {
      buttons[row][col] = new MSButton(row, col);
    }
  }

  setBombs();
}
public void setBombs()
{
  while (bombs.size()<30) {
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);

    if (!bombs.contains(buttons[row][col])) {
      bombs.add(buttons[row][col]);
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon()) {
    displayWinningMessage();
  }
  if (lose) {
    displayLosingMessage();
  }
}
public boolean isWon()
{
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if (!bombs.contains(buttons[r][c]) && !buttons[r][c].isClicked()) {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
 fill(255);
    text("Better Luck Next Time...", 200, 450);
    
}

  public void displayWinningMessage()
{
  background(0);
  fill(255, 0, 0);
  stroke(10);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("YOU WIN", width/2, height/2);
  textSize(20);
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed() {
    
    if (mouseButton == LEFT) {
      clicked = true;
    }
    if (mouseButton == RIGHT) {
        marked = !marked;
    } else if (bombs.contains(this)) {
        lose=true;
    } else if (countBombs(r, c) > 0) {
       setLabel(Integer.toString(countBombs(r, c)));
    } else {
        for(int row=-1; row<2; row++){
            for(int col=-1; col<2; col++){
                if(isValid(row+r,col+c) && !buttons[row+r][col+c].isClicked()){
                    buttons[row+r][col+c].mousePressed();
                }
            }
        }
      // if (isValid(r,c-1) && !buttons[r][c-1].isClicked()) {
      //   buttons[r][c-1].mousePressed();
      // }
      // if (isValid(r,c+1) && !buttons[r][c+1].isClicked()) {
      //   buttons[r][c+1].mousePressed();
      // }
      // if (isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked()) {
      //   buttons[r+1][c-1].mousePressed();
      // }
      // if (isValid(r+1,c) && !buttons[r+1][c].isClicked()) {
      //   buttons[r+1][c].mousePressed();
      // }
      // if (isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked()) {
      //   buttons[r+1][c+1].mousePressed();
      // }
      // if (isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked()) {
      //   buttons[r-1][c-1].mousePressed();
      // }
      // if (isValid(r-1,c) && !buttons[r-1][c].isClicked()) {
      //   buttons[r-1][c].mousePressed();
      // }
      // if (isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked()) {
      //   buttons[r-1][c+1].mousePressed();
      // }
      // }
    }
}

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this)) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    textSize(15);
    text(label, x+width/2, y+height/2);
  }

  public void setLabel(String newLabel)
  {
    label = newLabel;
    
  }

  public boolean isValid(int r, int c)
  {
    if (r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0) {
      return true;
    }
    return false;
  }

  public int countBombs(int row, int col)
  {
    int numBombs = 0;

      if (isValid(row,col-1) && bombs.contains(buttons[row][col-1])) {
        numBombs++;
      }
      if (isValid(row,col+1) && bombs.contains(buttons[row][col+1])) {
        numBombs++;
      }
      if (isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1])) {
        numBombs++;
      }
      if (isValid(row+1,col) && bombs.contains(buttons[row+1][col])) {
        numBombs++;
      }
      if (isValid(row,col+1) && bombs.contains(buttons[row][col+1])) {
        numBombs++;
      }
      if (isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1])) {
        numBombs++;
      }
      if (isValid(row-1,col) && bombs.contains(buttons[row-1][col])) {
        numBombs++;
      }
      if (isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1])) {
        numBombs++;
      }
      // for(int j=-1; j<2; j++){
      //   for(int i=-1; i<2; i++){
      //       if(isValid(j,i) && bombs.contains(buttons[j][i])){
      //           numBombs++;
      //       }
      //   }
      // }
    return numBombs;
  }
}

