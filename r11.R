# ggplot2를 사용한 여러가지 그래프
search()
library(dplyr)  # 데이터를 가공/정제하는 패키지
library(ggplot2)  # 그래프를 그리기 위한 패키지

# ggplot2::mpg 데이터 프레임
str(mpg)
# 자동차 구동방식(drv)별로 연비 차이?
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty))
df_mpg

# 그래프
ggplot(data = df_mpg, mapping = aes(x = drv, y = mean_cty)) +
  geom_col()

# x축의 데이터 순서를 y축의 값에 따라서 정렬하면 
# 막대 그래프를 크기 순서로 보여줄 수 있음.
# reorder(정렬할 데이터, 정렬기준)
ggplot(data = df_mpg,
       mapping = aes(x = reorder(drv, -mean_cty), y = mean_cty)) +
  geom_col()

# 구동방식별 고속도로 연비 차이?
df_mpg2 <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg2

ggplot(data = df_mpg2,
       mapping = aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) +
  geom_col() +
  xlab("구동방식") +
  ylab("고속도로 평균 연비(mpg)")
  
ggplot(data = mpg, mapping = aes(x = hwy)) +
  geom_bar()

# 돗수분포표: table()
t <- table(mpg$class)
t
t["compact"]
t["suv"]
ggplot(data = mpg, mapping = aes(x = class)) +
  geom_bar()
ggplot(data = mpg, 
       mapping = aes(x = reorder(class, -table(class)[class]))) +
  geom_bar()


# geom_bar(): 변수의 빈돗수를 막대 그래프로 그려주는 함수
# geom_bar()에서 x축에 사용될 수 있는 변수
# 1) 범주형 변수 (예: mpg의 class)
# 2) 연속 변수(숫자) -> 구간을 나눠서 구간 안에 포함된 갯수(빈돗수)
#    (예: mpg의 cty, hwy)
# geom_bar()를 사용할 때는 x축 변수만 mapping시키면 됨

# geom_col(): 어떤 변수의 크기를 막대그래프로 그려주는 함수
# 예: 성별에 따른 급여, 제조사별 평균 연비
# geom_col()을 사용할 때는 x축 변수, y축 변수를 모두 mapping시켜야 함.

df <- as.data.frame(table(mpg$class))
df
ggplot(data = df,
       mapping = aes(x = reorder(Var1, -Freq), y = Freq)) +
  geom_col()


# 선 그래프
# ggplot2::economics 데이터 프레임
str(economics)
head(economics)
tail(economics)

# 시간에 따른 실업자수(unemploy)의 변화
ggplot(data = economics,
       mapping = aes(x = date, y = unemploy)) +
  geom_line()

# 시간에 따른 인구(pop) 변화
ggplot(data = economics,
       mapping = aes(x = date, y = pop)) +
  geom_line()

# ggplot2::economics 데이터 프레임을 복사
df <- as.data.frame(economics)
# df 데이터 프레임에 인구대비 실업자 비율 변수(unemp_ratio)를 추가
# df$unemp_ratio <- (df$unemploy / df$pop) * 100
# head(df$unemp_ratio)
df <- df %>% mutate(unemp_ratio = (unemploy / pop) * 100)
head(df$unemp_ratio)

# 시간에 따른 실업자 비율을 그래프로 작성
ggplot(data = df, mapping = aes(x = date, y = unemp_ratio)) +
  geom_line()

# 시간에 따른 개인 저축률(psavert)을 그래프로 작성
ggplot(data = df, mapping = aes(x = date, y = psavert)) +
  geom_line()

# 두 개 이상의 선 그래프를 하나의 차트에
# 시간(date)에 따른 실업률과 저축률을 하나의 차트에
ggplot(data = df, mapping = aes(x = date)) +  # 공통 데이터/축 설정
  geom_line(mapping = aes(y = unemp_ratio), color = "darkred") + # 그래프 종류, 데이터 설정
  geom_line(mapping = aes(y = psavert), color = "darkblue")

str(df)

# 실업률(unemp_ratio)과 평균 실업 기간(uempmed)과의 관계가 있을까?
ggplot(data = df, mapping = aes(x = date)) +
  geom_line(mapping = aes(y = unemp_ratio), color = "darkred") +
  geom_line(mapping = aes(y = uempmed), color = "darkblue")


# boxplot: 기술 통계량들을 한눈에 알아볼 수 있는 그래프
# 최솟값, 1사분위값, 중앙값, 3사분위값, 최댓값
# boxplot$stats의 결과값은 아래의 1) ~ 5)
# 1) 아랫쪽 수염: 이상치가 아닌 데이터의 최솟값
# 2) 사각형의 아래쪽: 데이터들을 정렬했을 때 25%에 해당하는 값(1Qu.)
# 3) 사각형 안의 선: 데이터들을 정렬했을 때 50%에 해당하는 값(중앙값, 2Qu.)
# 4) 사각형의 위쪽: 데이터들을 정렬했을 때 75%에 해당하는 값(3Qu.)
# 5) 위쪽 수염: 이상치가 아닌 데이터의 최댓값
# 6) 이상치: 사각형 +/- (1.5 * IQR)을 벗어난 값
# IQR(Inter-Quartile Range) = 3Qu. - 1Qu.

boxplot(mpg$cty)
boxplot(mpg$cty)$stats
summary(mpg$cty)

ggplot(data = mpg, mapping = aes(y = cty)) +
  geom_boxplot()

# cyl별 cty의 boxplot
table(mpg$cyl)
df4 <- mpg %>% filter(cyl == 4)  # filter(mpg, cyl == 4)
boxplot(df4$cty)

df6 <- mpg %>% filter(cyl == 6)
boxplot(df6$cty)

ggplot(data = mpg,
       mapping = aes(x = as.factor(cyl), y = cty)) +
  geom_boxplot()

# drv(구동방식)별 cty의 boxplot
table(mpg$drv)
ggplot(data = mpg,
       mapping = aes(x = drv, y = cty)) + 
  geom_boxplot()


df <- mpg %>% filter(class %in% c("compact", "subcompact", "suv"))
ggplot(data = df, 
       mapping = aes(x = class, y = cty)) +
  geom_boxplot()

mpg %>% 
  filter(class %in% c("compact", "subcompact", "suv")) %>% 
  ggplot(mapping = aes(x = class, y = cty)) + 
  geom_boxplot()


install.packages("ggthemes")
library(ggthemes)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  theme_wsj()












