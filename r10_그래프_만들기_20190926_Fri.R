# 1.산점도
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()
# 축 설정 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6)

# 2.평균 막대 그래프
# 1 단계.평균표 만들기
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))
# 2 단계.그래프 생성하기, 크기순 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()
# 3.빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar()
# 4.선 그래프
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()
# 5.상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()


# ggplot2 패키지를 사용한 그래프
# grammar of graph(그래프 그리기 문법)
# install.packages("ggplot2")
library(ggplot2)
search()

rm(list = ls())


# ggplot2 패키지의 mpg 데이터 프레임 확인
str(ggplot2::mpg)
str(mpg)


# 자동차 배기량(displ) > x축과 시내주행 연비(cty) >y축 사이의 관계
summary(mpg$displ)
summary(mpg$cty)
# 1) 그래프를 그릴 데이터(데이터 프레임), 좌표축 설정
g <- ggplot(mpg,aes(displ,cty))

# 2) 그래프의 종류 선택
g <- g + geom_point() #좌표축 
g

# 3) 옵션 추가
g <- g + xlim(3,6)
g

ggplot(mpg,aes(displ,cty)) + geom_point() + ylim(10,30)

# 혼자서 해보기

# Question1.
ggplot(mpg,aes(cty,hwy)) + geom_point()

# Question2.
ggplot(midwest,aes(poptotal,popasian)) + 
  geom_point() + 
  xlim(0,50000) +
  ylim(0,250)

str(mpg)  
table(mpg$cyl)
ggplot(mpg, aes(cyl,cty)) +
    geom_point()
# 별 의미없는 결과가 도출 그럼 어떻게 하지?

# 색, 모양으로 추가 정보를 표현할 수 있음.
ggplot(mpg, aes(displ,cty,color=cyl)) +
  geom_point()

ggplot(mpg, aes(displ,cty,color=as.factor(cyl))) +
  geom_point()

ggplot(mpg, aes(displ,cty,color=as.factor(cyl), shape=as.factor(drv))) +
  geom_point()

# 4개의 변수를 표현 가능
# 시각화의 중요성