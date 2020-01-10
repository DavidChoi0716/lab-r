# dplyr 패키지를 사용한 데이터 전처리(가공)
# 패키지, 라이브러리: 여러 기능(함수) 또는 데이터를 모아둔 꾸러미

#install.packages("deplyr") #패키지 설치
search() # 메모리에 로딩된 패키지 이름들을 확인
library(dplyr) # 패키지(라이브러리)를 메모리에 로딩.
search() 

# Global Env.에 있는 변수들을 모두 삭제.
rm(list = ls())

# CSV 파일을 읽어서 데이터 프레임을 생성
exam <- read.csv("data/csv_exam.csv")

#생성된 데이터 프레임의 구조(Structure)를 확인
str(exam)

# 1반(class == 1) 학생들의 모든 정보를 출력
# filter(데이터 프레임, 검색 조건)
filter(exam, class == 1)

# deplyr 패키지의 모든 함수는 첫번째 파라미터가 데이터 프레임.
# 변수 이름들은 데이터 프레임 이름을 생략하고 사용하면 됨.

# 1반, 2반 학생들의 정보를 출력
filter(exam, class == 1 | class ==2)
filter(exam, class %in% 1:2)

filter(exam, class == c(1,2))
exam$class == c(1,2)


# 3반이 아닌 학생들의 정보를 출력
filter(exam, class != 3)

# 수학 점수가 60점 이상인 학생들을 출력
filter(exam, math >= 60)

# 수학 점수가 평균 이상인 학생들을 출력
filter(exam, math >= mean(math))

# deplyr 패키지의 함수들을 호출하는 방법
# 1) function(data_frame, ...)
# 2) data_frame %>% function(...)

filter(exam, class == 1)
# pipe 연산자를 사용한 filter() 함수 호출 > 개좋음
exam %>% filter(class == 1)

# Ctrl+ Shift + M <- %>%  : 파이프 연산자 작성
exam %>% filter (class %in% c(4,5))

# 1반 학생들 중에서 수학 점수가 평균 이상인 학생들을 출력
exam %>% filter (class == 1 & math >= mean(math))
exam %>% filter (class == 1 & math >= mean(math))

#혼자서 해보기
#01
mpg <- as.data.frame(ggplot2::mpg) 
mpg4 <- mpg %>% filter(displ <= 4)
mpg5 <- mpg %>% filter(displ >= 5)

mean(mpg4$hwy)
mean(mpg5$hwy)


#02


# 데이터 프레임에서 변수를 선택하는 함수 - deplyr::select()
# 1) select(data_frame, columns)
# 2) data_frame %>% select(columns)
# exam 데이터 프레임에서 수학 점수만 선택
exam %>% select(math)
# id와 math 변수를 선택
exam %>% select(id, math)
exam %>% select(c(id, math))

#class 변수를 제외한 모든 변수를 선택
exam %>% select(id, math, english, science)
exam %>% select(-class)

# 파이프 연산자( %>% )를 사용한 함수 연쇄 호출(chain call)
# 1반 학생들의 id, math를 출력
# select id, math from exam where class = 1;
# 1) 1반 학생들만 있는 데이터 프레임
class1 <- exam %>%  filter(class == 1)
class1
class1 %>% select(id, math)

exam %>% filter(class == 1) %>% select(id, math)

exam_sub <- exam %>% select(id, class, math)
exam_sub
exam_sub %>% filter(class == 1)

exam %>% select(id, class, math) %>% filter(class == 1)

# math, english, science 를 출력, 앞에 있는 6건만 출력
exam %>% select(math,english,science) %>% head(,n=6)
exam %>% head() %>% select(math,english,science)




#혼자서해보기
#(1)
home <- mpg %>% select(class, cty) %>%  head(home)
home
head(home)
tail(home)

#(2)
car_suv <- home %>% filter(class == "suv")
car_compact <- home %>% filter(class == "compact")

mean(car_suv$cty)
mean(car_compact$cty)


# 정렬: deplyr::arrange(data_frame, 정렬 기준 컬럼들)
exam %>% arrange(math) # 정렬 기본 방식은 오름차순 정렬

# 내림차순 정렬을 할 때는 desc() 함수를 이용.
exam %>% arrange(desc(math))

exam %>% arrange(math) %>% head()
exam %>% arrange(desc(math)) %>% head()

# 2개 이상의 변수로 정렬
# class 순서 -> math 점수 순서
exam %>% arrange(class, math)
exam %>% arrange(class, desc(math))


mpg <- as.data.frame(ggplot2::mpg) 
mpg %>% filter(manufacturer == "audi") %>%  arrange(desc(hwy)) %>% head(n =5)


# 새로운 변수(컬럼) 만들기:
#  data_frame$new_var <- 식;  --> 데이터 프레임이 변경됨
exam2 <- exam
exam2
exam2$total <- exam2$math + exam2$english + exam2$science
exam2

#deplyr::mutate(data_frame, new_var = 식)
#원본 데이터 프레임은 수정되지 않고, 컬럼이 추가된 새로운 데이터 프레임이 리턴(반환)
exam %>% mutate(total = math + english + science)
exam3 <- exam %>% mutate(total = math + english + science)
exam3
exam

# exam 데이터 프레임에서 
# 수학/영어/과학 점수의 합계를 total,
# 세 과목 점수의 평균을 average
# 변수를 추가한 결과를 출력
exam %>% mutate(total = math + english + science, avg = round(total/ 3, 2))

# ceiling: 올림한 정수 -> 정수 반환
# floor: 내림한 정수 -> 정수 반환
# trunc: 소숫점 자름 -> 정수 반환
# round: 반올림 -> 소숫점 이하 자릿수를 지정

# 과학 점수가 60점 이상이면 "pass", 60점 미만이면 "fail"
# 값을 갖는 컬럼(변수) test를 추가
exam %>%  mutate(test = ifelse(science >= 60, "pass", "fail"))

# 세 과목이 모두 50점 이상이고, 세 과목 평균이 60점 이상이면
# "pass", 그렇지 않으면 "fail"인 값으로 변수(컬럼) 추가

exam %>% mutate(avg = (math + english + science) / 3, 
                test = ifelse(math >= 50 & english >= 50 & science >= 50 & avg >= 60,"pass","fail"))

summary(exam) # 기술 통계량을 출력
#deplyr::summarise(), deplyr::summarize()
#벡터를 스칼라로 만들어 줌. - 통계 함수들을 적용하기 위해서 
exam %>% summarise(m_math = mean(math))
mean(exam$math)

exam %>% summarise(mean = mean(math), sd = sd(math))
mean(exam$math) #평균
sd(exam$math) #표준편차(standard deviation)


# 반별로 수학 점수의 평균
class1 <- filter(class == 1)
mean(class1$math)

exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math), 
            mean_english = mean(english)) %>% 
  arrange(mean_english)



mpg %>% group_by(manufacturer, drv) %>% 
        summarise(mean = mean(cty))  %>% 
        head( n = 10 )


mpg %>% group_by(drv, manufacturer) %>% 
  summarise(mean = mean(cty))  %>% 
  head( n = 10 ) 

mpg %>% group_by



# deplyr::n(): summarise, filter, mutate 함수 안에서 사용
# 갯수를 리턴하는 함수
# Oracle에서 count 함수와 비슷한 역할
# select count(*) from emp;

library("ggplot2")
search()

library(dplyr)
search()

mpg %>% summarise(count = n())

View(mpg)

# 제조사별 자동차 모델 갯수
mpg %>% group_by(manufacturer) %>% summarise(count = n())

# 자동차 종류(class)별 자동차 모델 갯수
mpg %>%  group_by(class) %>% summarise(count =n())

#4) 06-06
mpg %>%  filter(class == "compact") %>%  group_by(manufacturer) %>% summarise(count = n()) %>%  arrange(desc(count))














