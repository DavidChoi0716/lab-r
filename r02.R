# 데이터 프레임(Data Frame)
# Global Env.(전역 환경)에 저장된 변수들 리스트 - ls()
ls()

#Global Env.에 저장된 변수를 삭제 - rm()
rm("average")
rm(list = ls())

# 영어 점수를 저장하는 벡터(배열)
english <- c(90, 70, 80, 65)

# 수학 점수를 저장하는 벡터
math <- c(50, 40, 70, 55)
 
# 영어 점수, 수학 점수로 이루어진 표(테이블) - 데이터 프레임
scores <- base::data.frame(english, math)


scores # 데이터 프레임의 모든 데이터 출력
scores$english # 데이터 프레임$변수(컬럼) 이름
scores$math # 데이터 프레임$변수(컬럼) 이름
mean(scores$math)


scores2 <-data.frame(c(1,1,2,3),c(10,20,30,40),c(90,80,70,60))

scores2
scores2$c.1..1..2..3.


scores3 <-data.frame(calss = c(1,1,2,3), eng = c(10,20,30,40), math = c(90,80,70,60))

scores3 



# CSV 파일을 읽어서 데이터 프레임 만들기
# CSV (Comma-Separated Values) :
#   데이터들을 쉼표((,)로 구분해서 저장한 파일 형식
#   일반적으로는 구분자로 쉼표를 사용하지만, 
#   때로는 쉼표로 콜론(:) 또는 탭(\t) 등으로 데이터를 구분하는 경우도 있음
getwd() #get working directory: 현재 작업 디렉토리 이름을 반환
setwd("C:/dev/lab-r") # set working directory: 현재 작업 디렉토리를 변경
exam_csv <- read.csv("data/csv_exam.csv")

# 상대 경로(relative path):
#   파일의 위치를 현재 작업 디렉토리에서부터 시작하는 표기법

# 절대 경로(absolute path)
#   파일의 위치를 최상위 디렉토리(root directory)부터 전부 표기하는 방법

# (예) 현재 작업 디렉토리가 C:/dev/lab-r인 경우에서
#   상대경로 - data/csv_exam.csv
#   절대경로 - C:/dev/lab-r/data/csv_exam.csv

#상대 경로에서 .은 현재 디렉토리를 의미, ..은 상위 디렉토리를 의미
# data/test.csv와 ./data/test.csv은 같은 의미
# ./data/test.csv
# ../r01.R (C:/dev/r01.R)






