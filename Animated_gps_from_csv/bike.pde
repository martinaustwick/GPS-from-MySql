class Bike
{
    PVector p;
    ArrayList<PVector> points;
    int currentIndex = 0;
    int previousIndex = 0;
    int weekday;
    int duration, samStart; 
    
    Bike(){}
    
    void display()
    {
        //stroke(255*(1-weekday), 128, 255*weekday, 20);
        if(weekday==1) stroke(217,78,151,20);
        else stroke(250,205,0,20);
        
        if(sam>samStart && sam<(samStart+duration))
        {
            bikesActive++;
            if(weekday==1) weekdayActive++;
            else weekendActive++;
          
            
            findIndex();
            if(sam>sam0)
            {
              for(int drawi = previousIndex; drawi<=currentIndex; drawi++)
              {
                if(drawi<points.size()) p =  points.get(drawi);
                point(p.x,p.y);
              }
            }
        }
    }
    
    void findIndex()
    {
        
        for(int i = currentIndex; i<points.size(); i++)
        {
            if(sam<points.get(i).z)
            {
                previousIndex = currentIndex;
                currentIndex = i-1;
                i = points.size();
                
            }
        }
    }
}

ArrayList<Bike> bikes;

void createBikes()
{
    println("creating bikes");
    int bikeTime = millis();
    bikes = new ArrayList<Bike>();
    //routes.getRowCount()
    totalWeekday = 0;
    totalWeekend = 0;
    
    for(int it=0 ; it<routes.getRowCount();it++)
    {
        TableRow tr = routes.getRow(it);
        
        //date filter coming up
        //if(tr.getString("date").equals("2017-04-02") || 1==1)
        if(tr.getInt("OneWeek")>-1  && it<100000)
        {
            Bike b = new Bike();
            b.points = new ArrayList<PVector>();
            String [] coordS = split(tr.getString("points"),"],[");
            
            int startTime = tr.getInt("sam")+int(random(3600));
            b.samStart = startTime;
            b.duration = tr.getInt("duration");
            b.weekday = tr.getInt("Weekday");
            
            totalWeekday += b.weekday;
            totalWeekend += (1-b.weekday);
            
            //distance in pixels
            float totalDist = 0;
            //println(startTime);
            for(int si = 0;si<coordS.length;si++)
            {
                String s = coordS[si];
                String [] sa = split(s, "[");
                //println(sa.length);
                if(sa.length<2) 
                {
                  sa = split(s, "]");
                  s = sa[0];
                  
                }
                else
                {
                    s = sa[1];
                }
                //println(s);
                
                String [] pointS = split(s,",");
                float inx = float(pointS[0]);
                float iny = float(pointS[1]);
                
                float x = map(inx, minX, maxX, 0, width);
                float y = map(iny, minY, maxY, height, 0);
                PVector p = new PVector(x,y);
                
                float distance = 0;
                if(si>0) distance = PVector.dist(p, b.points.get(si-1));
                p.z = distance;
                totalDist+=distance;
                //println(x + " " + y);
                
                //b.points.add(new PVector(x,y,float(startTime)));
                b.points.add(p);
                //startTime+=5;
                
            }
            
            float tOverR = tr.getFloat("duration")/totalDist;
            //println("Speed  " +speed);
            
            for(int si = 0; si<b.points.size();si++)
            {
                
                if(si==0) b.points.get(si).z=startTime;
                else
                {
                    b.points.get(si).z = b.points.get(si-1).z+(b.points.get(si).z*tOverR);
                    //println(si + " " + (b.points.get(si).z-b.points.get(si-1).z) + " " + startTime + " " + (startTime+tr.getFloat("duration")));
                }
            }
            bikes.add(b);
        }
    }
    
    println(bikes.size() + " bikes created in " + (millis()-bikeTime) + "ms ");
    println(totalWeekday + "("+ (100*totalWeekday/bikes.size()) +  "%) weekday and " + totalWeekend + "(" + (100*totalWeekend/bikes.size()) + "%) weekend; checksum " + (totalWeekday + totalWeekend));

}