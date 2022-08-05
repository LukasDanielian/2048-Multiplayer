//IMPORTS
import processing.net.*;

//VARIABLES
public ArrayList<Tile> tiles;
public ArrayList<Tile> otherPlayerTiles;
public Client client = new Client(this, "127.0.0.1", 1234);//TYPE PLAYER ONE IP ADDRESS
public boolean gameOver;
public boolean win;
public boolean start;
public boolean sendStatus;
public int winAmount;

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
  start = false;
  sendStatus = true;
  winAmount = 0;
}

//RENDERS EVERYTHING
public void draw()
{
  background(100);
  recieveData();
  //SENDS BOARD DATA
  String toSend = "";
  for (int i = 0; i < tiles.size(); i++)
  {
    toSend += tiles.get(i).toString() + "/";
  }
  sendData("Board", new String[]{toSend});

  //STARTING SCREEN
  if (!start)
  {
    textSize(75);
    fill(255);
    text("Waiting For Player One To Select Win Amount:", width/2, height/2);
  }
  //MAIN GAME
  else if (!gameOver && !win && start)
  {
    makeBoard();
    renderTiles();
    checkLoss();
    checkWin();
    renderOtherPlayerBoard();
    textSize(25);
    fill(0);
    text("Win Amount: " + winAmount, width/2, height * .05);
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
