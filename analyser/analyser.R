#analyser
library(ggplot2)

#ok
run <- function() {
  file =  read.csv(file="E:/Andrea/GitHub/R-project/AB_NYC_2019.csv", header=TRUE, sep=",")
  
  file

  datas = file
  summary(datas)  

  prices= datas$price
  prices
  plot(prices)
  
  ggplot(datas,aes(x=datas$id,y= datas$price, colour=datas$price)) + geom_point()+facet_wrap(~ datas$neighbourhood_group) 
  #+facet_wrap(~ Data$inquinante)+ geom_smooth(method="lm")
  
  datas$host_id=NULL
  datas$host_name=NULL
  
  dictionary_rooms = unique(datas$room_type)
  
  lisroom = data.frame()
  dictionary_rooms
  
  
  df = data.frame()
  for(i in c(1:length(dictionary_rooms)))
  {
    
    test = dictionary_rooms[i] == datas$room_type
    n = length(datas$room_type[test])
    lis = list(dictionary_rooms[i],n)
    df = rbind(df,lis,stringsAsFactors=FALSE)

  }
  names(df)= c("Type", "Number")
  
 df 
 
 ggplot(df,aes(x=Type,y=Number)) + geom_bar(aes(fill = Type), position = "dodge", stat="identity")
 # i = datas$room_type == dictionary_rooms[1]
 
 
  
 # print(complete.cases(datas))
#  test2 = datas[-complete.cases(datas)]
#  test2
#  test = datas[complete.cases(datas),]
 # test
}

run()