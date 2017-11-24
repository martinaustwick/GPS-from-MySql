  String path = "../Routes_geojson/";
  String file = "Routes_1_300_GOOD";
  
  PVector xlim, ylim;
  
  Table routes;
  
  float minX = 434994;
  float minY= 4470785;
   float maxX = 446194;
  float maxY= 4479185;
  
  int batch, batchSize;
  
  int sam = 12*3600;
  int increment = 10;
  
  boolean movie = true;
  
  void setup()
  {
      size(800,600);
      
      //file = "Routes_test";
      loadRoutes(path+file+".csv");
      //noLoop();
      //draw();
      batch = 0;
      batchSize = 10;
      background(0);
      //make the agents
      createBikes();
      rectMode(CENTER);
  }
  
  void loadRoutes(String name)
  {
      int loadTableTime = millis();
      routes = loadTable(name, "header"); 
      println("Table loaded in " + (millis()-loadTableTime)+"ms");
  }
  
  void draw()
  {
      fill(0,4);
      noStroke();
      rect(width/2,height/2,width,height);
     
      //drawAll();
      //batch+=batchSize;
      stroke(255,10);
      for(Bike b:bikes)
      {
          b.display();
      }
      drawClock();
      
      sam+=increment;
      
      if(movie)
      {
          saveFrame("images/######.png");
      }
  }