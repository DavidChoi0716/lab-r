#데이터 가공(전처리)

# CSV 파일을 읽어서 데이터 프레임을 생성
exam <- read.csv("data/csv_exam.csv")

# 데이터 프레임을 출력
exam
exam[1,1] #데이터프레임[행번호, 열번호]
exam[1,5] # 1번 학생(row=1)의 과학 점수(column=5)

# 행 번호 또는 열 번호를 생략하면 행or열을 전체 출력을 해 줌.
exam[1,] # 컬럼 인덱스를 생략하면 해당 행의 모든 컬럼을 출력
exam[,1] # 컬럼 인덱스를 생략하면 해당 컬럼의 모든 행을 출력

# 모든 학생의 영어 점수를 출력
exam$english
exam[,4] # select english 
# 5번 학생의 모든 정보를 출력
exam[5,] # select * from exam where id = 5

# 여러개의 행 or 열을 한번에 추출하는 방법
exam[1:4, ]
exam[, 3:5]
exam[seq(1,20,4),]
exam[c(1,10,20),]


# 논리값(TRUE/FALSE)으로 데이터 추출
exam$class == 1
exam[exam$class == 1, ]
# & (and), | (or)
exam[(exam$class == 1) & (exam$math == 50), ]
# %in% 연산자
exam[exam$class %in% c(3,4),]

# 수학 점수가 50점 이상인 학생들의 id, class, math를 출력
# select id,class, math from exam where math >= 50;
exam[exam$math >= 50, c(1,2,3)]

# 컬럼 이름이 있는 경우는 컬럼 이름으로도 데이터 추출
# 과학 점수가 60점 이상인 학생들의 id, class, science를 출력
exam[exam$science >= 60, c("id","class","science")]

# 영어점수가 평균 이상인 학생들의 id, class, english를 출력
exam[exam$english >= mean(exam$english), c("id","class","english")]

# ggplot2::mpg 데이터 프레임 사용
mpg <- as.data.frame(ggplot2::mpg)


# mpg 데이터 프레임에서 cty, hwy 출력. 1~6번 행만 출력
mpg[1:6, c("cty", "hwy")]

# mpg 데이터 프레임에서 
# 시내주행 연비가 평균 이상이고,
# 고속도로 연비도 평균 이상인 
# 자동차들의 model, cty, hwy를 출력
mpg[mpg$cty >= mean(mpg$cty) & mpg$hwy >= mean(mpg$hwy), c("model","cty","hwy")]

#전체 학생들의 수학 점수 평균
mean(exam$math)
# exam 데이터 프레임에서 1반 학생들의 수학 점수 평균
class1 <- exam [exam$class == 1, ] # 1반 학생들로만 이루어진 DF
mean(class1$math) #1반 학생들의 수학 점수 평균

# filter 함수의 결과를 변수에 저장 -> 데이터 프레임
# 1반 학생들로만 이루어진 데이터 프레임
class1 <- exam %>%  filter (class ==1)
str(class1)

# 1반 학생들의 각 과목 평균 점수
mean(class1$math)
mean(class1$english)
mean(class1$science)

class2 <- exam %>%  filter (class ==2)
str(class2)

# 2반 학생들의 각 과목 평균 점수
mean(class2$math)
mean(class2$english)
mean(class2$science)

search()
