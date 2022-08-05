//SENDS DATA TO CLIENT
public void sendData(String type, String[] info)
{
  client.write(type + "|" + join(info, "|") + "\n");
}

//READS DATA FROM PLAYER ONE
public void recieveData()
{
  if (client != null && client.available() > 0)
  {
    String recieved = client.readString();

    //UPDATES INFO BASED ON DATA RECIEVED
    if (recieved != null)
    {
      recieved = recieved.substring(0, recieved.indexOf("\n"));
      String[] args = split(recieved, "|");
      
      //OTHER PLAYERS TILE INFORMATION
      if (args[0].equals("Board") && args[1] != "")
      {
        String[] otherPlayerAL = split(args[1], "/");
        otherPlayerTiles.clear();
        for (int i = 0; i < otherPlayerAL.length; i++)
        {
          if (otherPlayerAL[i] != "")
          {
            String[] arrayData = split(otherPlayerAL[i], ":");
            otherPlayerTiles.add(new Tile(int(arrayData[0]), int(arrayData[1]), int(arrayData[2])));
          }
        }
      }
      
      //THIS PLAYER WIN
      if(args[0].equals("YouWin"))
      {
        win = true;
      }
      
      //THIS PLAYER LOST
      if(args[0].equals("YouLose"))
      {
        gameOver = true;
      }
    }
  }
}

//RENDER OTHER PLALYERS TILES
public void renderOtherPlayerBoard()
{
  for (int i = 0; i < otherPlayerTiles.size(); i++)
  {
    otherPlayerTiles.get(i).render(0);
  }
}
