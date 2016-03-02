import de.bezier.guido.*;
final static int NUM_ROWS = 20;
final static int NUM_COLS = 20;
final static int NUM_BOMBS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

public void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make(this);
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    
    for(int row = 0; row < buttons.length; row++){
        for(int col = 0; col < buttons[row].length; col++){
            buttons[row][col] = new MSButton(row,col);
        }
    }
    
    setBombs();
}
public void setBombs()
{
   while(bombs.size()<40){
        int row = (int)(Math.random()*20);
        int col = (int)(Math.random()*20);
  
        if(!bombs.contains(buttons[row][col])){
            bombs.add(buttons[row][col]);

        }

    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
        background(0);
        fill(255,0,0);
        stroke(10);
        textAlign(CENTER,CENTER);
        textSize(80);
        text("YOU LOSE", width/2,height/2);
        textSize(20);
        
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
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
        if(mouseButton == LEFT) {
            clicked = true;
        }
        if(mouseButton == RIGHT) {
            marked = !marked;
        }
         else if (bombs.contains(this)) {
             displayLosingMessage();
         }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }

    public void setLabel(String newLabel)
    {
        label = newLabel;
    }

    public boolean isValid(int r, int c)
    {
        if(r < 20 || r >= 0 || c < 20 || c >= 0){
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(this.isValid(r,c)){
        
            if(bombs.contains(buttons[row][col-1])){
               numBombs++;
            }
            if(bombs.contains(buttons[row][col+1])){
               numBombs++;
            }
            if(bombs.contains(buttons[row+1][col-1])){
               numBombs++;
            }
            if(bombs.contains(buttons[row+1][col])){
               numBombs++;
            }
            if(bombs.contains(buttons[row+1][col+1])){
               numBombs++;
            }
            if(bombs.contains(buttons[row-1][col-1])){
               numBombs++;
            }
            if(bombs.contains(buttons[row-1][col])){
               numBombs++;
            }
            if(bombs.contains(buttons[row-1][col+1])){
               numBombs++;
            }
        }
    return numBombs;
}
}



