rm(list = ls())

# 인터랙티브 그래프(interactive graph)
install.packages("plotly")
library(dplyr)
library(ggplot2)
library(plotly)
search()

# ggplot2에서 학습용으로 제공하는 mpg 데이터 프레임
str(mpg)

# 배기량(displ), 구동방식(drv)과 고속도로연비(hwy)와의 관계
g <- ggplot(data = mpg,
       mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point()

# plotly::ggplotly(ggplot객체)
ggplotly(g)


# 구동방식별 boxplot
g <- ggplot(data = mpg, mapping = aes(x = drv, y = hwy)) + 
  geom_boxplot()
ggplotly(g)


str(diamonds)
# 다이아몬드 돗수분포표 - 빈도 막대 그래프
g <- ggplot(data = diamonds,
            mapping = aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")
ggplotly(g)


str(economics)
# 시간(date)에 따른 개인저축률(psavert)의 변화 - 선그래프 
g <- ggplot(data = economics,
            mapping = aes(x = date, y = psavert)) + 
  geom_line()
ggplotly(g)


# 시계열 데이터에 대한 더 많은 기능을 가지고 있는 패키지
install.packages("dygraphs")
library(xts)
library(dygraphs)

# 시계열 그래프를 그려주는 dygraphs 패키지에서 사용하는데이터 타입.
eco_psavert <- xts(x = economics$psavert, order.by = economics$date)
str(eco_psavert)
head(eco_psavert)
dygraph(eco_psavert) %>% dyRangeSelector()


# 실업률 변수 추가
economics <- ggplot2::economics
economics$unemprt <- (economics$unemploy / economics$pop) * 100
head(economics$unemprt)
# 시계열 그래프를 그리기 위해서 
eco_unemprt <- xts(x = economics$unemprt, order.by = economics$date)
str(eco_unemprt)
head(eco_unemprt)
dygraph(eco_unemprt)

# dygraph에서 시계열 그래프를 2개 이상 그리려면,
data <- cbind(eco_psavert, eco_unemprt)
str(data)
head(data)

dygraph(data) %>% dyRangeSelector()
