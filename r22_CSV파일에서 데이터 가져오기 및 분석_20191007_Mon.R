# csv 파일에서 데이터 가져오기 및 분석
rm(list = ls())

getwd()
setwd("C:/dev/lab-r")
mydata <- read.csv("mlwr/usedcars.csv", stringsAsFactors = F)


# 데이터 프레임의 구조(structure) 확인
str(mydata)

# 데이터 일부 확인
head(mydata)
tail(mydata)

# 기술 통계량 확인
summary(mydata)
summary(mydata$price)
summary(mydata[c("price","mileage")])

# 최댓값, 최솟값
max(mydata$price)
min(mydata$price)

# 범위(range): 최솟값과 최댓값을 출력
range(mydata$price)

# diff:
diff(range(mydata$price))

#IQR(Inter-Quartile Range) : 3rd Qu. - 1st Qu.
IQR(mydata$price)

# Quartile: 1/4, 1/2, 3/4 위치의 값들
# 0.25 (25%) 위치: 1사분위(1st quartile)
# 0.5 (50%) 위치: 2사분위(2nd quartile), 중앙값(median)
# 0.75 (75%) 위치: 3사분위(3rd quartile)

# Quantile
quantile(mydata$price)
summary(mydata$price)
quantile(mydata$price, probs = c(0.1,0.9))
quantile(mydata$price, probs = seq(0, 1.0, 0.25))
quantile(mydata$price, probs = seq(0, 1.0, 0.1))

# median(): 중앙값(2사분위값, 50% 위치)
median(mydata$price)

# mean(): 평균
mean(mydata$price)

# 평균, 중앙값, 사분위값들, IOR -> 수치형 데이터의 퍼짐 정도를 축정


# diff(): 연속된 두 숫자의 차이
diff(c(100,120))
diff(c(120,100))
diff(c(100,90,120,130,110))

# 수치형 데이터의 분석 - 5숫자 요약
summary(mydata$price)
boxplot(x = mydata$price)

summary(mydata$mileage)
boxplot(mydata$mileage)

install.packages("ggplot2")
library(ggplot2)
ggplot(data=mydata, mapping = aes(x = "", y = price)) + geom_boxplot()
ggplot(data=mydata, mapping = aes(x = "", y = mileage)) + geom_boxplot() + ylab("주행 거리") + ggtitle("주행거리 상자 그림")

# 히스토그램(histogram): 
# 연속된 수치 구간을 일정한 간격으로 나눠서 
# 그 구간에 해당하는 데이터들의 갯수(빈도수)를 막대로 그린 그래프
hist(mydata$price, breaks = seq(0, 25000, 1000))
hist(mydata$mileage)

ggplot(data = mydata, mapping = aes(x=price)) + geom_histogram(bins=10, color = "black", fill = "white")
ggplot(data = mydata, mapping = aes(x=mileage)) + geom_histogram(bins=20, color = "red", fill = "pink")

# 분산(variance), 표준편차(standard deviation)
var(mydata$price)
sd(mydata$price)  
var(mydata$mileage)
sd(mydata$mileage)


# 정규 분포: 평균을 중심으로 양쪽이 대칭인 종 모양의 분포
str(mydata)

# 이산형 데이터 (discrete data) 또는 범주형 데이터의 빈도 수
table(mydata$year)
table(mydata$model)
table(mydata$color)

# 2개 이상의 변수들 간의 상관 관계 -> 산점도(산포도) 그래프 
# 중고차의 주행거리(mileage)가 가격(price)에 영향?
plot(x = mydata$mileage, y=mydata$price,
     main = "주행거리 vs 가격",
     xlab = "주행거리(mile)", ylab = "가격(USD)")
  
ggplot(data = mydata, mapping = aes(x=mileage, y = price, color = model)) + geom_point() + xlab("주행거리(mile)") + ylab("가격(USD)") + ggtitle("주행거리vs가격")


# 이원교차표 (two-way cross table)
# 두개의 명목 변수 간의 관계를 파악 
install.packages("gmodels")
library(gmodels)

# mydata 데이터 프레임에 새로운 변수를 추가
mydata$conserve <- mydata$color %in% c("Black","Gray","Silver","White")
# table(): 빈돗수, 돗수분포표
t <- table(mydata$conserve)
t
# prop.table(): 변수들의 비율을 표로 작성
prop.table(t)

t2 <- table(mydata$model)
t2
prop.table(t2)

# CrossTable (x = 행, y = 열)
CrossTable(x=mydata$model, y=mydata$conserve)



