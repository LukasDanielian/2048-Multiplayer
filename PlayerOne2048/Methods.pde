//MAKES BACKGROUND GRID
void makeBoard()
{
  int[] cols = {#FF0000,#0000FF};
  for (int i = 0; i < 901; i+= 900)
  {
    for (int row = 0; row < height; row += 200)
    {
      for (int col = i; col < i + 800; col+= 200)
      {
        noFill();
        stroke(cols[(int)map(i,0,900,0,1)]);
        strokeWeight(5);
        rect(col, row, 200, 200);
      }
    }
  }
}

//RENDERS TILES ON BOARD
public void renderTiles()
{
  for (int i = 0; i < tiles.size(); i++)
  {
    tiles.get(i).render(0);
  }
}

//ADDS ANOTHER TILE IF POSSIBLE
public void addTile()
{
  if (tiles.size() < 16)
  {
    tiles.add(new Tile());
  }
}

//MOVES ALL TILES
public void move(int upDown, int leftRight)
{
  //MOVES ALL UP AND DOWN
  for (int loop = 0; loop < 3; loop++)
  {
    for (int i = 0; i < tiles.size(); i++)
    {
      Tile temp = tiles.get(i);
      checkMovement(temp, upDown, leftRight);
      checkCombine(temp.row, temp.col, i);
    }
  }
}

//MOVES A TILE AS FAR AS POSSIBLE
public void checkMovement(Tile temp, int upDown, int leftRight)
{
  while (isEmpty(temp.row + upDown, temp.col + leftRight) && inBounds(temp.row + upDown, temp.col + leftRight))
  {
    temp.row += upDown;
    temp.col += leftRight;
  }
  if (inBounds(temp.row + upDown, temp.col + leftRight) && getTile(temp.row + upDown, temp.col + leftRight).num == temp.num)
  {
    temp.row += upDown;
    temp.col += leftRight;
  }
}

//CHECKS IF TILES COLIDE THEN COMBINES THEM
public void checkCombine(float r, float c, int loc)
{
  for (int i = 0; i < tiles.size(); i++)
  {
    Tile temp = tiles.get(i);

    if (i != loc && temp.row == r && temp.col == c)
    {
      if (i > loc)
      {
        tiles.remove(i);
        tiles.remove(loc);
      } else
      {
        tiles.remove(loc);
        tiles.remove(i);
      }
      tiles.add(new Tile(temp.row, temp.col, temp.num * 2));
      break;
    }
  }
}

//RETURNS THE TILE ON A GIVEN SPOT
public Tile getTile(int r, int c)
{
  for (int i = 0; i < tiles.size(); i++)
  {
    Tile temp = tiles.get(i);
    if (temp.row == r && temp.col == c)
    {
      return temp;
    }
  }
  return null;
}

//CHECKS IF GAME IS OVER
public void checkLoss()
{
  if (tiles.size() == 16)
  {
    int[] VERT_DISP = {-1, 1, 0, 0};
    int[] HORZ_DISP = {0, 0, -1, 1};

    for (int i = 0; i < tiles.size(); i++)
    {
      Tile temp = tiles.get(i);

      for (int j = 0; j < 4; j++)
      {
        if (inBounds(temp.row + VERT_DISP[j], temp.col + HORZ_DISP[j]) && temp.num == getTile(temp.row + VERT_DISP[j], temp.col + HORZ_DISP[j]).num)
        {
          return;
        }
      }
    }
    gameOver = true;
  }
}

//CHECKS IF GAME IS WON
public void checkWin()
{
  for (int i = 0; i < tiles.size(); i++)
  {
    if (tiles.get(i).num == winAmount)
    {
      win = true;
    }
  }
}

//MAKES BUTTONS
void makeButtons()
{
  int[] nums = {256,512,1024,2048};
  for(int i = 0; i < 4; i++)
  {
    buttons.add(new Button(width/4 * i, height/2,nums[i]));
  }
}

//RENDERS ALL BUTTONS
void renderButtons()
{
  fill(255);
  textSize(75);
  text("Select Winning Amount:", width/2,height * .25);
  for(int i = 0; i < buttons.size(); i++)
  {
    buttons.get(i).render();
  }
}
