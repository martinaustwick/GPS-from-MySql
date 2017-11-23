JSONObject rue;
String path = "../Routes_geojson/";
String file = "Routes_1_300";

void setup()
{
    loadGeoJSON(path + file + ".geojson");
    saveToCSV(path + file +".csv");
    
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
    //JSONArray rues = rue.getJSONArray("features");
    //for(int i = 0; i<rues.size(); i++)
    //{
    //    JSONObject entry = rues.getJSONObject(i);
    //    JSONObject properties = entry.getJSONObject("properties");
    //    int id = properties.getInt("OBJECTID");
    //    println(id);
    //    String dateTime = properties.getString("datetimeMA");
    //    println(dateTime);
    //    JSONObject geom = entry.getJSONObject("geometry");
    //    JSONArray points = geom.getJSONArray("coordinates");
    //    //println(points);
        
    //}
    
}

void saveToCSV(String savename)
{
    Table table = new Table();
  
    table.addColumn("id");
    table.addColumn("dateTime");
    table.addColumn("points");
    
    JSONArray rues = rue.getJSONArray("features");
    println("No of features " + rues.size());
    for(int i = 0; i<rues.size(); i++)
    {
       //println(i);
       JSONObject entry = rues.getJSONObject(i);
       JSONObject properties = entry.getJSONObject("properties");
       int id = properties.getInt("OBJECTID");
       //println(id);
       String dateTime = properties.getString("datetimeMA");
       //println(dateTime);
        JSONObject geom = entry.getJSONObject("geometry");
        String pointy = "";
        
        
        /*
            This (admittedly risky) line of code deletes a line of geojson as soon as its
            objects are ready for use by the for loop below. Hopefully it will free up some system space.
        */
        rues.remove(i);
        i--;
        System.gc();
        
        //Q. why don't I use try/catch more? covers a multitude of data sins
        //A. it's a sloppy fix and leads to more braces
        try{
        JSONArray points = geom.getJSONArray("coordinates").getJSONArray(0);
        //println(points.size());
          for(int pi = 0; pi<points.size(); pi++)
          {
              pointy += "[";
              JSONArray pointor = points.getJSONArray(pi);
              //println(pointor.get(0).getClass());
              Double x = pointor.getDouble(0);
              Double y = pointor.getDouble(1);
              
              pointy +=x;
              pointy +=",";
              pointy +=y;
              pointy += "],";
              
          }      
        }
        
        catch(Exception e){
            println(" error at OBJECTID = " + id);
            //println(geom);
        }
      
      TableRow newRow = table.addRow();
      newRow.setInt("id", id);
      newRow.setString("dateTime", dateTime);
      newRow.setString("points", pointy);
      
      //being overly cautious here
       saveTable(table, savename);
    }
    
   
    println("csv saved");
}