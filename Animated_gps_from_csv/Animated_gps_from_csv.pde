  String path = "../Routes_geojson/";
  String file = "Routes_1_300_GOOD";
  
  PImage bgImage;
  
  //PVector xlim, ylim;
  
  Table routes;
  
  //float minX = 434994;
  //float minY= 4470785;
  // float maxX = 446194;
  //float maxY= 4479185;
  
  float minX = 434994;
  float minY= 4470785-1680;
   float maxX = 446194;
  float maxY= 4479185;
  
  int batch, batchSize;
  
  int sam0 = 6*3600;
  int samEnd; 
  int sam;
  int increment = 12;
  
  boolean movie = true;
  
  int bikesActive, weekendActive, weekdayActive;
  
  int totalWeekday, totalWeekend;
  
  void setup()
  {
      //size(800,720);
      //size(1800, 1620);
      size(1200, 1080);
      
      //size(
      //println(800*1620/720 + " " + 600*1620/720 + " " + 80*1620/720);
      println(800*1080/720 + " " + 600*1080/720 + " " + 80*1080/720);
      smooth(2);
      //println(0.1*(maxY-minY));
      
      weekdayPoints = new int [width];
      weekendPoints = new int [width];
      //println(weekdayPoints.size());
      
      //file = "Routes_test";
      file = "Oneweek";
      
      bgImage = loadImage("map.jpg");
      //bgImage.resize(800,600);
      //bgImage.resize(1800,1350);
      bgImage.resize(1200,900);
      
      background(0);
      image(bgImage,0,0);
      
      bgImage = transparentise(bgImage,10,1);
      
      
      loadRoutes(path+file+".csv");
      //noLoop();
      //draw();
      batch = 0;
      batchSize = 10;
      
      //make the agents
      createBikes();
      rectMode(CENTER);
      
      sam = sam0;
      strokeWeight(4);
  }
  
  void loadRoutes(String name)
  {
      int loadTableTime = millis();
      routes = loadTable(name, "header"); 
      println("Table loaded in " + (millis()-loadTableTime)+"ms");
  }
  
  void draw()
  {
      fill(0,10);
      noStroke();
      rect(width/2,height/2,width,height);
      if(sam<23*3600)image(bgImage,0,0);
      //drawAll();
      //batch+=batchSize;
      //stroke(255,15);
      
      bikesActive = 0;
      weekdayActive = 0;
      weekendActive = 0;
      for(Bike b:bikes)
      {
          b.display();
      }
      
      //println(weekdayActive + " " + weekendActive);
      
      //drawGraph();
      colorGraph();
      
      drawClock();
      
      sam+=increment;
      
      if(movie && sam<(24*3600))
      {
          saveFrame("images/######.png");
      }
  }