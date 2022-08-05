//IMPORTS
import processing.net.*;

//VARIABLES
public ArrayList<Tile> tiles;
public ArrayList<Tile> otherPlayerTiles;
public Server server = new Server(this, 1234);
public boolean gameOver;
public boolean win;
public boolean sendStatus;

public void setup()
{
  //SETTINGS
  size(1700, 800);
  textAlign(CENTER, CENTER);
  frameRate(144);

  //VARIABLE DECLARATOIN
  tiles = new ArrayList<Tile>();
  otherPlayerTiles = new ArrayList<Tile>();
  gameOver = false;
  win = false;
  sendStatus = true;
}

//RENDERS EVERYTHING
public void draw()
{
  background(100);

  //MAIN GAME
  if (!gameOver && !win)
  {
    recieveData();
    makeBoard();
    renderTiles();
    checkLoss();
    checkWin();
    renderOtherPlayerBoard();

    //SENDS BOARD DATA
    String toSend = "";
    for (int i = 0; i < tiles.size(); i++)
    {
      toSend += tiles.get(i).toString() + "/";
    }
    sendData("Board", new String[]{toSend});
  }
  //GAME OVER SCREEN
  else
  {
    textSize(100);
    fill(255);
    //LOSS
    if (gameOver)
    {
      text("You Lose\nClick To Restart", width/2, height/2);
      if (sendStatus)
      {
        sendData("YouWin", new String[]{""});
        sendStatus = false;
      }
    }
    //WIN
    if (win)
    {
      text("You Win\nClick To Restart", width/2, height/2);
      if (sendStatus)
      {
        sendData("YouLose", new String[]{""});
        sendStatus = false;
      }
    }
    //RESTART
    if (mousePressed)
    {
      setup();
    }
  }
}

//MOVES TILES IN CORRECT DIRECTION AND ADDS NEW TILE
public void keyPressed()
{
  int leftRight = 0;
  int upDown = 0;

  //UP
  if (keyCode == UP)
  {
    upDown = -1;
  }
  //DOWN
  else if (keyCode == DOWN)
  {
    upDown = 1;
  }
  //LEFT
  else if (keyCode == LEFT)
  {
    leftRight = -1;
  }
  //RIGHT
  else if (keyCode == RIGHT)
  {
    leftRight = 1;
  }
  //WRONG KEY
  else
  {
    return;
  }

  move(upDown, leftRight);
  addTile();
}
