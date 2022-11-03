


main(){
 List list = [1,1,1,1,2,2,3,3,3,3,8,0,0,0,0,0,0];
  list.sort();
  List inidList = [];
  List occourence = [];
  int num = 1;
 
 
  
  for (int i = 0; i < list.length; i++)
  {
    int y = 0;
    
    for (int j = 0; j < list.length; j++)
    {
      if (list[j] == list[i])
      {
        y++;
        
      }
    }
    if(!inidList.contains(list[i]))
    {
      inidList.add(list[i]);
      occourence.add(y);
      
      
    }
    
   
   
    
   
    
   
    
  } 
  //d2.sort();
  
   print('${inidList} occored ${occourence} times');
  List tt = occourence;
  tt.sort();
  int tti = tt[(num - 1)];
  
  int pos = occourence.indexOf(tti);
  
  int ans = inidList[pos];
  print(tt);
  print(tti);
    print(occourence);
  
  print("${pos} rareste item : ${ans}");
  
 
  
 
}

