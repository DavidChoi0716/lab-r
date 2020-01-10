#Global Env.(메모리)에 있는 변수들 삭제
rm(list=ls())

search()

library("ggplot2")

#1
ggplot2::midwest

midwest

View(midwest)

head(midwest)
tail(midwest)

dim(midwest)

str(midwest)

summary(midwest)

#2
midwest<- as.data.frame(ggplot2::midwest)

midwest <- data.frame(total = poptotal, asian = popasian)


rename(midwest, total = poptotal, asian = popasian)

midwest2 <- rename(midwest, total = poptotal, asian = popasian)

View(midwest2)

#3
midwest2$ratio<- midwest2$asian/midwest2$total
hist(midwest2$ratio)



#4
mean(midwest2$ratio)
midwest2$group <- ifelse(midwest$ratio > 0.004872462, "large", "small")


#5
table(midwest2$group)


library(ggplot2)
qplot(midwest$group)