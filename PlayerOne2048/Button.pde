//REPRESENTS ONE BUTTON
class Button
{
  float x, y, w, h;
  int num;
  public Button(float x, float y, int num)
  {
    this.x = x;
    this.y = y;
    w = width/4;
    h = 300;
    this.num = num;
  }

  //RENDERS ONE BUTTON
  void render()
  {
    fill(0);
    stroke(255);
    strokeWeight(5);
    rect(x, y, w, h, 50);

    fill(255);
    textSize(25);
    text("" + num, x + w/2, y + h/2);
  }

  //CHECKS IF CLICKED
  boolean isClicked()
  {
    if (!start)
    {
      if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h/2)
      {
        return true;
      }
    }
    return false;
  }
}
