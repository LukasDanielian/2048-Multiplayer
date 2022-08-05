//REPRESENTS ONE TILE
public class Tile
{
  int row,col,size,num;
  
  public Tile()
  {
    row = (int)random(0,4);
    col = (int)random(0,4);    
    while(!isEmpty(row,col))
    {
      row = (int)random(0,4);
      col = (int)random(0,4);
    }
    
    size = 200;
    num = (int)map((int)random(0,2),0,1,2,4);
  }
  
  public Tile(int row, int col, int num)
  {
    this.row = row;
    this.col = col;
    this.num = num;
    size = 200;
  }
  
  //RENDERS ONE TILE
  void render(int loc)
  {
    //RECTANGLE
    fill(map(num,2,512,255,0));
    stroke(0);
    strokeWeight(5);
    rect(col * size + loc,row * size, size ,size, 50);
    
    //TEXT
    textSize(50);
    fill(255,0,0);
    noStroke();
    text("" + num,(col*size) + 100 + loc, (row * size) + 100);
  }
  
  //RETURNS INFO ON TILE
  String toString()
  {
    return row + ":" + col + ":" + num + ":";
  }
}

//CHECKS IF TILE IS IN BOUNDS
boolean inBounds(float row, float col)
{
  if(row <= 3 && row >= 0 && col<= 3 && col >= 0)
  {
    return true;
  }
  return false;
}

//CHECKS IF EMPTY LOCATION
boolean isEmpty(float r, float c)
{
  for(int i = 0; i < tiles.size(); i++)
  {
    Tile temp = tiles.get(i);
    if(temp.row == r && temp.col == c)
    {
      return false;
    }
  }
  return true;
}
