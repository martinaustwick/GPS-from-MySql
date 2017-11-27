void drawClock()
{
    
  pushMatrix();
      int fontSize =10;
      int doffset = 0;
      noStroke();
      
      int h = sam/3600;
      int m = int(sam-(h*3600))/60;
      int s = int(sam)%60;
      fill(0);
      rectMode(CENTER);
      
      translate(width-(3*fontSize), 3*fontSize);
      
      rect(0, -(0.5*fontSize)-5, 6*fontSize, fontSize+10);
      fill(255);
      textSize(fontSize);
      text(nf((h+doffset)%24, 2, 0) + ":" + nf(m, 2, 0) + ":" + nf(s, 2, 0), -(2.2*fontSize), -10);
  popMatrix();
  
}