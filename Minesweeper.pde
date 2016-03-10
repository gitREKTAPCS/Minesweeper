import de.bezier.guido.*;
final static int NUM_ROWS = 20;
final static int NUM_COLS = 20;
final static int NUM_BOMBS = 60;
private int bombCount = NUM_BOMBS;
private boolean lose = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

public void setup ()
{
  size(400, 500);
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
  while (bombs.size()<NUM_BOMBS) {
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);

    if (!bombs.contains(buttons[row][col])) {
      bombs.add(buttons[row][col]);
    }
  }
}

public void draw ()
{
        background(200);
         fill(0);
        text("Usable bombs left: " + bombCount, 200, 430);
        if (lose) {
            displayLosingMessage();
        }  
        else if (isWon()) {
            displayWinningMessage();
        }
    
         
}
public boolean isWon() {
    int numMarked = 0;
    for (MSButton[] array : buttons) {
        for (MSButton b : array)
            if (b.isMarked() && bombs.contains(b))
                numMarked++;
    }
    if (numMarked == NUM_BOMBS)
        return true;
    return false;
}
public void displayLosingMessage()
{
    fill(0);
    text("Better Luck Next Time...", 200, 450);
    // println("lose");
    for(int i = 0; i < NUM_ROWS; i++)
        for(int j = 0; j < NUM_COLS; j++)
            buttons[i][j].mousePressed();
}
public void displayWinningMessage()
{
    fill(0);
    text("You Won!", 200, 450);
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
    
    if (mouseButton == LEFT && !isClicked()) {
      clicked = true;
    }
    if (mouseButton == RIGHT) {
        marked = !marked;
        bombCount--;
    } else if (bombs.contains(this) && clicked) {
        lose=true;
    } else if (countBombs(r, c) > 0) {
       setLabel(""+countBombs(r,c));
    } else {
            for (int row = -1; row < 2; row++) {
                for (int col = -1; col < 2; col++) {
                    if (isValid(row+r,col+c) && !buttons[row+r][col+c].isClicked()) {
                        buttons[row+r][col+c].mousePressed();
                    }
                }
            }
        }
}

  public void draw() {
        if (marked)
            fill(0);
        else if (clicked && bombs.contains(this)) 
            fill(255,0,0);
        else if (clicked)
            fill(200);
        else 
            fill(100);

        rect(x, y, width, height);
        fill(0);
        textSize(18);
        text(label,x+width/2,y+height/2);
        
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
        for (int r = -1; r < 2; r++) {
            for (int c = -1; c < 2; c++) {
                if (isValid(row+r,col+c) && bombs.contains(buttons[row+r][col+c])) {
                    numBombs++;
                }
            }
        }
        return numBombs;
    }
}
