boolean isValidTarget(float x, float max)
{
   return x >= windowSafezone && max-windowSafezone >= x;
}

void setMouseProjection()
{   
    float slope = (y2 - pY) / (x2 - pX);   
    float projX = (windowSafezone + slope * pX - pY) / slope; 
    float projY = slope * windowSafezone - slope*pX + pY;
    float testX = (height + slope * pX - pY) / slope;
    float testY = slope * width - slope*pX + pY;

    if(y2 - pY > 0 && isValidTarget(testX, width))   // jos
    {
        finalX = testX; 
        finalY = height-windowSafezone;
    } 
    
    if(x2 - pX > 0 && isValidTarget(testY, height))  // dreapta 
    {
        finalX = width-windowSafezone;
        finalY = testY;
    }
    
    if(y2 - pY < 0 && isValidTarget(projX, width))   // sus
    {
        finalX = projX; 
        finalY = windowSafezone;
    }  
    
    if(x2 - pX < 0 && isValidTarget(projY, height))  // stanga
    {
        finalX = windowSafezone;
        finalY = projY;
    }  

    //println(pX+" "+pY+" | "+x2+" "+y2+" | "+slope+" | "+projX +" "+projY +" | "+testX+" "+testY+ " | ");
}

boolean isCollinear(float px1, float py1, float midx, float midy, float px2, float py2)
{
     if( (min(px1, px2) <= midx && midx <= max(px1, px2)) && (min(py1, py2) <= midy && midy <= max(py1, py2)) )
         return true;
     return false;
}

float[] computeCollision()
{   
    float rezX, rezY, finX = -1, finY = -1;
    float distPlayerToTarget = 0, closestCollision = width * 2;
    
    for(int i = 0;i < lines.size();i++)
    {
        float x3 = lines.get(i).x3, y3 = lines.get(i).y3, x4 = lines.get(i).x4, y4 = lines.get(i).y4;
        
        rezX = ((pX * y2 - pY * x2) * (x3 - x4) - (pX - x2) * (x3 * y4 - y3 * x4)) /
                         ((pX - x2) * (y3 - y4) - (pY - y2) * (x3 - x4));
                                    
        rezY = ((pX * y2 - pY * x2) * (y3 - y4) - (pY - y2) * (x3 * y4 - y3 * x4)) / 
                         ((pX - x2) * (y3 - y4) - (pY - y2) * (x3 - x4));
        
        if (isCollinear(x3, y3, rezX, rezY, x4, y4))
        {           
              distPlayerToTarget = dist(pX, pY, rezX, rezY);
              if(distPlayerToTarget < closestCollision && isCollinear(pX, pY, rezX, rezY, finalX, finalY))
              { 
                  finX = rezX; 
                  finY = rezY; 
                  closestCollision = distPlayerToTarget; 
              }
        }
    }
        
    return new float[] {finX, finY};
}
