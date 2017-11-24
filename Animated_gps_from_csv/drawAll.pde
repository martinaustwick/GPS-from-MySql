void drawAll()
{
    stroke(255,3);
    //strokeWeight(1);
    //routes.getRowCount()
    for(int it=batch ; it<batch+batchSize;it++)
    {
        if(it%10==0) println(it);
        TableRow tr = routes.getRow(it);
        //println(tr.getString("points"));
        String [] coordS = split(tr.getString("points"),"],[");
        for(String s: coordS)
        {
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
            //println("x "+ x);
            //println(y);
            point(x,y);
            
        }
    }
}