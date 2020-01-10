#R의 데이터 구조
#vector(벡터): 같은 타입의 값 여러개를 저장할 수 있는
#1차원 배열. 인덱스 한 개.
#scalar(스칼라): 한 개의 값만 갖는 벡터

# 벡터를 생성하는 함수
# c(): combine
a <- c(1,2,10,20)
a[1]

# seq(): sequence
b <- seq(1, 10, 2)
b
  
# vector는 다른 타입의 값들을 저장할 수는 없음.
c <- c(1,"one")
c

# R에서는 유연성이 높은 타입으로 자동 타입 변환이 됨.
# 유연성: 문자 > 숫자 > 논리
d <- c(1,2,T,F)
d

e <- c("one",1,T,F)
e

f <- c(T,F)
f

#벡터 생성
subject_name <- c("korean","english","math")
#벡터에서 특정 위치(인덱스)에 있는 원소 확인
subject_name[1]
subject_name[2]
subject_name[3]
subject_name[1:2]
subject_name[1:3]
subject_name[c(1,3)]
subject_name[c(T,T,F)]


# factor(팩터): 범주형(nominal), 순위형(ordinal) 변수들을 저장하는
# 특별한 종류의 벡터
gender1 <- c("male","female","male") # 문자열 벡터

gender2 # 2개 레벨(level)을 갖는 팩터gender2 <- factor(c("male","female","male"))

# ordinal factor
symptoms <- factor(c("severe","mild","moderate"), levels = c("mild","moderate","severe"), ordered=T)
symptoms
symptoms[1] # 팩터 - 인덱스 사용 가능
symptoms > "moderate" # ordinal factor 인 경우 크기 비교가 가능
symptoms >= "moderate"
gender2 > "female" # nominal factor는 크키 비교가 불가능

# 연산자(+,-,*,/,>,<,==,!=,...)들은 벡터의 각 원소에 하나씩 적용
x <- c(1,2,3)
x + 1
x == 2
x != 2














