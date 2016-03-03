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
  while (bombs.size()<60) {
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
  background(0);
  fill(255, 0, 0);
  stroke(10);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("YOU LOSE", width/2, height/2);
  textSize(20);
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c].mousePressed();
    }
  }
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
    clicked = true;
    if (mouseButton == LEFT) {
      clicked = true;
    }
    if (mouseButton == RIGHT) {
      marked = !marked;
    } else if (bombs.contains(this)) {
      lose=true;
    } else if (this.countBombs(r, c) > 0) {
      this.setLabel(Integer.toString(this.countBombs(r, c)));
    } else {
      if (this.isValid(r, c)) {
        buttons[r][c-1].mousePressed();
        buttons[r][c+1].mousePressed();
        buttons[r+1][c-1].mousePressed();
        buttons[r+1][c].mousePressed();
        buttons[r+1][c-1].mousePressed();
        buttons[r-1][c-1].mousePressed();
        buttons[r-1][c].mousePressed();
        buttons[r-1][c+1].mousePressed();
      }
    }
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }

  public void setLabel(String newLabel)
  {
    label = newLabel;
    textSize(15);
    text(label, x/2, y/2);
  }

  public boolean isValid(int r, int c)
  {
    if (r < NUM_ROWS || r >= 0 || c < NUM_COLS || c >= 0) {
      return true;
    }
    return false;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;

      if (buttons[row][col-1].isValid(row,col-1) && bombs.contains(buttons[row][col-1])) {
        numBombs++;
      }
      if (buttons[row][col+1].isValid(row,col+1) && bombs.contains(buttons[row][col+1])) {
        numBombs++;
      }
      if (buttons[row+1][col-1].isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1])) {
        numBombs++;
      }
      if (buttons[row+1][col].isValid(row+1,col) && bombs.contains(buttons[row+1][col])) {
        numBombs++;
      }
      if (buttons[row+1][col+1].isValid(row,col+1) && bombs.contains(buttons[row+1][col+1])) {
        numBombs++;
      }
      if (buttons[row-1][col-1].isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1])) {
        numBombs++;
      }
      if (buttons[row-1][col].isValid(row-1,col) && bombs.contains(buttons[row-1][col])) {
        numBombs++;
      }
      if (buttons[row-1][col-1].isValid(row,col+1) && bombs.contains(buttons[row-1][col+1])) {
        numBombs++;
      }
    return numBombs;
  }
}
