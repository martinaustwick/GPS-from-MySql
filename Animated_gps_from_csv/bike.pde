class Bike
{
    PVector p;
    ArrayList<PVector> points;
    int currentIndex = 0;
    int previousIndex = 0;
    int duration, samStart; 
    
    Bike(){}
    
    void display()
    {
        if(sam>samStart && sam<(samStart+duration))
        {
            findIndex();
            
            for(int drawi = previousIndex; drawi<=currentIndex; drawi++)
            {
              if(drawi<points.size()) p =  points.get(drawi);
              point(p.x,p.y);
            }
            //currentIndex++;
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
    bikes = new ArrayList<Bike>();
    //routes.getRowCount()
    for(int it=0 ; it<routes.getRowCount();it++)
    {
        TableRow tr = routes.getRow(it);
        
        //date filter coming up
        if(tr.getString("date").equals("2017-04-02"))
        {
            Bike b = new Bike();
            b.points = new ArrayList<PVector>();
            String [] coordS = split(tr.getString("points"),"],[");
            
            int startTime = tr.getInt("sam")+int(random(3600));
            b.samStart = startTime;
            b.duration = tr.getInt("duration");
            
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
    
    println(bikes.size());
    
}