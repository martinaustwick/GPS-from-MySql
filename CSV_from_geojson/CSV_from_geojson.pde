JSONObject rue;
String path = "../Routes_geojson/";
String file = "Routes_1_300";


void setup()
{
    //file = "Routes_test"; 
    file = "Oneweek";

    //loadGeoJSON(path + file + ".geojson");
    //saveToCSV(path + file +".csv");
    
    println("Loading csv to Table");
    int time = millis();
    Table paths = loadTable(path + file +".csv");
    println(path + file +".csv loaded in " + float(millis()-time)/1000 + "ms");
    
}

void loadGeoJSON(String filename)
{
    
    //String [] t = loadStrings("../Routes_geojson/fakey.txt");
    //println(t);
    int start = millis();
    println("GeoJSON " +  filename + " Loading");
    rue = loadJSONObject(filename);
    println("GEOJSON Loaded in " + float(millis()-start)/1000 + "s");
    println(rue.getString("name"));
    
    
}

void saveToCSV(String savename)
{
    Table table = new Table();
  
    table.addColumn("routeID");
    table.addColumn("dateTime");
    table.addColumn("date");
    table.addColumn("time");
    table.addColumn("sam");
    table.addColumn("duration");
    
    table.addColumn("OneWeek");
    table.addColumn("Weekday");
    
    table.addColumn("points");
    
    //saveTable(table, savename);
    int startTime = millis();
    
    PrintWriter output = createWriter(savename);
    //table.write(output);
    String [] titles = table.getColumnTitles();
    for(int si = 0; si<titles.length; si++)
    {
        output.print("\"");
        output.print(titles[si]);
        output.print("\"");
        if(si<titles.length-1) output.print(",");
        else output.println("");
    }
    
    JSONArray rues = rue.getJSONArray("features");
    println("No of features " + rues.size());
    for(int i = 0; i<rues.size(); i++)
    {
       int rowtime = millis();
       //println(i);
       JSONObject entry = rues.getJSONObject(i);
       JSONObject properties = entry.getJSONObject("properties");
       int id = properties.getInt("routeID");
       //println(properties.getInt("travel_tim"));
       //println(id);
       String dateTime = properties.getString("datetimeMA");
       //println(dateTime);
        JSONObject geom = entry.getJSONObject("geometry");
        String pointy = "";
        
        
        
        //Q. why don't I use try/catch more? covers a multitude of data sins
        //A. it's a sloppy fix and leads to more braces
        try{
        JSONArray points = geom.getJSONArray("coordinates").getJSONArray(0);
        //println(points.size());
          for(int pi = 0; pi<points.size(); pi++)
          {
              //if(pi==0) pointy+="\"\"";
              pointy += "[";
              JSONArray pointor = points.getJSONArray(pi);
              //println(pointor.get(0).getClass());
              Double x = pointor.getDouble(0);
              Double y = pointor.getDouble(1);
              
              pointy +=x;
              pointy +=",";
              pointy +=y;
              pointy += "]";
              if(pi==(points.size()-1)) pointy+="";
              else pointy += ",";
              
          }  
          
          //use a printwriter
          Table tempTable = new Table();
          
          tempTable.addColumn("routeID");
          tempTable.addColumn("dateTime");
          tempTable.addColumn("date");
          tempTable.addColumn("time");
          tempTable.addColumn("sam");
          tempTable.addColumn("duration");
          
          tempTable.addColumn("OneWeek");
          tempTable.addColumn("Weekday");
          
          tempTable.addColumn("points");
          
          TableRow newRow = tempTable.addRow();
          newRow.setInt("routeID", id);
          newRow.setString("dateTime", dateTime);
          newRow.setString("date", properties.getString("Date"));
          newRow.setString("time", properties.getString("Time"));
          
          newRow.setInt("OneWeek", properties.getInt("OneWeek"));
          newRow.setInt("Weekday", properties.getInt("Weekday"));
          
          String [] times = properties.getString("Time").split(":");
          int sam = (3600*int(times[0])) +(60*int(times[1]))+int(times[2]);
          newRow.setInt("sam", sam);
          
          newRow.setString("points", pointy);
          newRow.setInt("duration",properties.getInt("travel_tim"));
          
          //newRow.write(output);
          
          for(int k = 0; k<tempTable.getColumnCount();k++)
          {
              output.print("\"");
              output.print(newRow.getString(k));
              output.print("\"");
              if(k<tempTable.getColumnCount()-1) output.print(",");
              else output.println("");
          }
                    
          if(i%1000==0) println("Elapsed time: " + (millis()-startTime)/1000 + "s;" + i + "/" + rues.size() + "/" + (i*(100.0/rues.size())) + "%; rowtime: "+ (millis()-rowtime) +"ms");
        }
        
        catch(Exception e){
            println(" error at OBJECTID = " + id + " index " + i + "/" + rues.size());
            //println(e);
            //println(geom);
        }
      
      
      //println(millis()-time);
      //if(i%(1000)==0)
      //{
      //    //println("SAVE");
      //    time=millis();
      //    saveTable(table, savename);
      //    //println(millis()-time);
      //    println(i + " SAVED in " + (millis()-time) + "ms");
      //}
       
    }
    //output.write("hi");
    output.flush(); // Writes the remaining data to the file
    output.close();
   //saveTable(table, savename);
    println("csv saved");
}