leggo <- read.csv(file="E:/Andrea/R/netflix_titles_nov_2019.csv", header=TRUE, sep=",")

Data = leggo

Data
install.packages('dplyr')
library(dplyr)

iris = as_tibble(Data)
iris

  as_tibble(Data %>% select(release_year,title))

countfilm = Data %>% select(release_year,title)

count(countfilm, "2019")

?aggregate

years = unique(sort(countfilm$release_year))
years

df = data.frame()

for(i in years)
{
  w = countfilm$release_year==toString(i)
  lis = list(i,length(which(w)))
  df = rbind(df,lis,stringsAsFactors=FALSE)
  
}
names(df)= c("Anno","numero di film")
plot(df)
as_tibble(df)

library(ggplot2)
ggplot(df, aes(x=df$Anno,y=df$`numero film`, group=1))+geom_point()+geom_line()
df
as_tibble(Data)


