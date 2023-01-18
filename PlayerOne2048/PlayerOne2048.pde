//IMPORTS
import processing.net.*;

//VARIABLES
public ArrayList<Tile> tiles;
public ArrayList<Tile> otherPlayerTiles;
public ArrayList<Button> buttons;
public Server server = new Server(this, 1234);
public boolean gameOver;
public boolean win;
public boolean sendStatus;
public boolean start;
public int winAmount;

public void setup()
{
  //SETTINGS
  //size(1700, 800);
  fullScreen();
  textAlign(CENTER, CENTER);
  frameRate(144);

  //VARIABLE DECLARATOIN
  tiles = new ArrayList<Tile>();
  otherPlayerTiles = new ArrayList<Tile>();
  buttons = new ArrayList<Button>();
  gameOver = false;
  win = false;
  sendStatus = true;
  start = false;
  winAmount = 0;

  makeButtons();
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
  if(start)
  {
    sendData("Start", new String[]{"" + winAmount});
  }
  sendData("Sync", new String[]{""});
  
  //START SCREEN
  if (!start)
  {
    renderButtons();
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
      //if (sendStatus)
      //{
        sendData("YouWin", new String[]{""});
        sendStatus = false;
      //}
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
