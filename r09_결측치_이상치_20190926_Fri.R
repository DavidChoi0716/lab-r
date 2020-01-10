# 1.결측치(missing value, NA) = 누락된 값,비어있는 값 정제하기

# 함수의 결측치 제외 기능 이용하기
mean(df$score, na.rm = T)
exam %>% summarise(mean_math = mean(math, na.rm = T))

rm(list = ls())

#결측치(NA)가 있는 데이터 프레임 생성
df <- data.frame(gender = c("M","F",NA,"M","F"), score = c(5,4,3,NA,6))

#데이터 프레임의 구조(structure)
str(df)

#기술 통계량
summary(df)

#summary(ggplot2::mpg)
#is.na():NA는 T, NA가 아니면 F를 리턴하는 함수
#조건을 만들때 filter 함수 안에서 많이 사용

is.na(df) # 데이터 프레임의 각 원소의 NA여부를 출력
is.na(df$gender)
is.na(df$score)

search()
df %>% filter(!is.na(gender))
df %>% filter(!is.na(score))
df %>% filter(!is.na(gender) & !is.na(score)) 

# df 데이터 프레임에서 성별 score의 평균을 출력해 보자.
df %>% group_by(gender) %>%  summarise(mean = mean(score)) #에러
df %>% filter(!is.na(gender) & !is.na(score)) %>% group_by(gender) %>%  summarise(mean = mean(score)) #에러없음

df
mean(df$score, na.rm = T)

df %>% group_by(gender) %>%  summarise(mean = mean(score,na.rm = T)) 

# 결측치 확인
# 분석을 시작하기 전에 na가 몇 개 있는지 파악할 때 사용.
#table(): 도수분포표 
table(is.na(df$gender))
table(is.na(df$score))
table(is.na(df))

# 결측치를 대체할 때 (imputation)
# 1) 0으로 대체
df$score <- ifelse(is.na(df$score), 0, df$score)
df
df %>% group_by(gender) %>%  summarise(mean = mean(score))

# 2) 평균값으로 대체
df[4,2] <- NA #df[4, "score"] <- NA
df

# 3) 최빈값으로 대체


# NA를 제외한 평균값
avg <- mean(df$score, na.rm = T)
avg
df$score <- ifelse(is.na(df$score), avg, df$score)
df
df %>% group_by(gender) %>% summarise(mean = mean(score))

#omit 함수 
#함부로 사용하지 말 것
na.omit(df)

# 함수의 결측치 제외 기능 이용하기 - na.rm = T


mpg <- as.data.frame(ggplot2::mpg) 
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA 

select(mpg, hwy)

mpg

#Question1.
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

#Question2.
mpg %>% filter(!is.na(hwy)) %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy)) # 내림차순 어떻게 정렬?(desc)








# 2. 이상치,극단치(Outlier) = 논리적으로 들어갈 수 없는 값. 있어서는 안 될 값
movie_rating <- data.frame(rating = c(5,4,3,4,5,3,10))
movie_rating
mean(movie_rating$rating)

# 영화 별점은 1~5점까지만 가능하다고 한다며, 10점은 있어서는 안 될 값.
movie_rating$rating<- ifelse(movie_rating$rating %in% c(1:5), movie_rating$rating, NA)
movie_rating
mean(movie_rating$rating, na.rm = TRUE)


# Outlier
mpg <- as.data.frame(ggplot2::mpg)
summary(mpg$hwy)  #기술 통계량
boxplot(mpg$hwy) # The Easiest Way To Find Out Outlier
boxplot(mpg$hwy)$stats

#stats[1,1]: 아랫쪽 수염의 위치
#stats[1,5]: 위쪽 수염의 위치
#boxplot에서 수염을 벗어난 데이터들을 outlier라고 하고,
#outlier들을 NA로 처리하고 통계 처리
mean(mpg$hwy) #23.44017 - outlier가 포함된 값

#outlier를 NA로 바꿔줌
mpg$hwy <- ifelse(mpg$hwy <12 | mpg$hwy > 37, NA, mpg$hwy)
#NA의 갯수를 확인
table(is.na(mpg$hwy))
mean(mpg$hwy, na.rm=T) # 23.18615 - outlier가 제외된 값

# 이상치 확인
table(outlier$sex)
# 결측 처리
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
# boxplot 으로 극단치 기준 찾기
boxplot(mpg$hwy)$stats
# 극단치 결측 처리
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)


