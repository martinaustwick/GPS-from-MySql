

PImage transparentise(PImage p, float alpha, float brightenTheCorners)
{
  PImage pout = createImage(p.width, p.height, ARGB);
  pout.loadPixels();
  
  colorMode(HSB);
  p.loadPixels();
  for (int i = 0; i<p.pixels.length; i++)
  {
    pout.pixels[i] = color(hue(p.pixels[i]), 0, brightenTheCorners*brightness(p.pixels[i]), alpha);
  }
  pout.updatePixels();
  colorMode(RGB);
  return pout;
}