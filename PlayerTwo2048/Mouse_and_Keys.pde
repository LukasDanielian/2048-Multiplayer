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
