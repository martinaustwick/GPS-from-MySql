ArrayList<Integer> graphPoints = new ArrayList<Integer>(600);

int [] weekdayPoints;
int [] weekendPoints;

void drawGraph()
{
    fill(0);
    stroke(255);
    //noStroke();
    rect(20, height-maxY-20, width-40, maxY);
    
    int maxY = 50;
    int maxBikes = 150;
    //println(bikesActive);
    graphPoints.add(bikesActive);
    
    stroke(255,1);
    line(20, height-20, width-20, height-20);

    for(int i = sam0/3600; i<24; i++)
    {
        float xl = map(i*3600, sam0, 24*3600, 20, width-20);
        line(xl, height-20, xl, height-20-maxY);
    }
    
    for(int g = 0; g<graphPoints.size(); g++)
    {
        int sam1 = sam0 +(g*increment);
        float x = map(sam1, sam0, 24*3600, 20, width-20);
        float y = map(graphPoints.get(g), 0, maxBikes, height-20, height-20-maxY);
        line(x,y,x, height-20);
        //point(x,y);
    }
    
    
    stroke(255);
    float x = map(sam, sam0, 24*3600, 20, width-20);
    float y = map(bikesActive, 0, maxBikes, height-20, height-20-maxY);
    line(x,y,x, height-20);
    
}

int prevX = 0;

void colorGraph()
{
    fill(0);
    //stroke(255);
    noStroke();
    
    int xoff = 30;
    int yoff = 20;
    
    
    //int maxY = 80*1620/720;
    
    int maxY = 80*1080/720;
    int maxBikes = 300;
    //println(bikesActive);
    
    rect(width/2, height-(0.5*(maxY+40)), width, maxY+40);
    int tindex =  int(map(sam, sam0, (24*3600-1), xoff, width-xoff));
    //graphPoints.add(bikesActive);
    weekdayPoints[tindex]=weekdayActive/5;
    weekendPoints[tindex]=weekendActive/2;
    //println("weekday "+ weekdayActive+" weekend " +weekendActive);
    
    stroke(255,50);
    line(xoff, height-20, width-(xoff), height-20);

    for(int i = sam0/3600; i<25; i++)
    {
        float xl = map(i*3600, sam0, 24*3600, xoff, width-(xoff));
        line(xl, height-20, xl, height-20-maxY);
        fill(255);
        text(i,xl-4,height-5);
    }
    
    
    text(maxBikes, 5, height-20-maxY+5);
    text(maxBikes/2, 5, 5+height-20-(0.5*maxY));
    text(0, 5, 5+height-20);
    
    stroke(255,50);
    noFill();
    line(xoff, height-20-maxY, width-xoff, height-20-maxY);
    line(xoff, height-20-maxY*0.5, width-xoff, height-20-maxY*0.5);
    
    for(int g = xoff; g<width-xoff; g++)
    {
        //int sam1 = sam0 +(g*increment);
        //float x = map(sam1, sam0, 24*3600, xoff, width-xoff);
        //float y = map(graphPoints.get(g), 0, maxBikes, height-20, height-20-maxY);
        int x = g;
        if(weekdayPoints[g]>0)
        {
          float y1 = map(weekdayPoints[g], 0, maxBikes, 0, maxY);
          //line(x, height - y1 -20,x, height-20);
          
          
          
          float y2 = map(weekendPoints[g], 0, maxBikes, 0, maxY);
          //line(x,height-y1-20,x, height - (y1+y2)-20);
          //line(x, height - y2 -20,x, height-20);
          //if(y1>y2) stroke(0, 128, 255);
          //else stroke(255,127,0);
          //line(x, height - y1 -20, x, height - y2 -20);
          
          //stroke(0, 128, 255);
          stroke(217,78,151);
          point(x, height - y1 -20);
          //stroke(255,127,0);
          stroke(250,205,0);
          point(x, height - y2 -20);
        }
    }
    
    //stroke(0,128,255);
    //float x = map(sam, sam0, 24*3600, 20, width);
    //float y1 = map(weekdayActive, 0, maxBikes, height-20, height-20-maxY);
    //line(x,y1,x, height-20);
    //stroke(255,128,0);
    //float y2 = map(weekendActive, 0, maxBikes, height-20, height-20-maxY);
    //line(x,y2,x, y1);
    
}