#변수 선언과 사용
#변수 이름 <-값
#변수 이름 = 값
x <- 11 # Ctrl+Enter: 해당 커서가 위치하는 R 문장을 샐행
y = 22


# R에서는   변수의 데이터 타입을 명시하지 않음
name <- '오쌤'
name <- 100


# R의 변수는 여러개의 값을 하나의 변수에 저장할 수 있음.
num_array <- 1:100 # num_array 변수에 1 ~ 10까지의 숫자들을 저장.
num_array # 배열의 원소 전체를 출력
num_array[1] #배열에서 인덱스 1번 원소를 출력 
num_array[9] #배열에서 인덱스 2번 원소를 출력 


# R에서 여러개의 값을 하나의 변수에 저장하는 방법
# 1) start : end
#    start ~ end까지 1씩 증가하는 숫자들의 배열
# 2) seq (start, end, by)
#    start: 시작값, end: 끝나는 값, by: 증분(기본값은 1)
num_array = seq(1,100,3)
num_array

num_array = seq(10, 1,-1)
num_array


#3) c(...) - combine의 약자
num_array <- c(1,10,100,1234)
num_array

names <-c("강다혜","김수인", "김영광")
names
names [2]

#배열의 인덱스: 배열이름 [인덱스]
# R에서 배열의 인덱스는 1부터 시작, 연속적인 양의 정수
num_array <- c(1:100)
num_array 
num_array[1]
num_array[2]
num_array[1:5] #: 연산자를 배열의 인덱스 자리에 사용할 수 있음.
num_array[5:7]

num_array[c(1,5,10)] # c() 함수를 인덱스에 사용할 수도 있음.
num_array[seq(1, 10, 2)] #seq() 함수도 인ㄷ게스에 사용할 수 있음.


#숫자들의 연산
x <- 1 
y <- 1.5
x + y
x - y
x * y
x / y

num_array <- c(10,20,30,40,50)
num_array
num_array + 1 # 벡터 + 스칼라
num_array + 2 # 벡터 * 스칼라

# 스칼라(scala): 1개의 값을 저장하는 변수
# 벡터(vector): 2개 이상의 값을 저장하는 변수
# 벡터와 스칼라를 사칙연산(+, -, *, /)를 하면,
# 벡터의 모든 원소에 스칼라 값을 사칙연산하게 됨.

# 벡터와 벡터의 사칙연산은 같은 인덱스에 있는 원소들끼리
# 사칙연산을 하게 됨.
numbers1 <- c(11, 22, 33)
numbers2 <- c(10, 20, 30)
numbers1 + numbers2


numbers3 <- c(10, 20)
numbers4 <- c(1, 2, 3)
numbers3 + numbers4



# 문자열 1개를 저장하는 변수
name <- "홍길동"
name
# 문자열 여러개를 저장하는 변수
names <- c("aaa","bbb","ccc")
names
names[2]
names[1:2]




# 문자열을 +,-,/ 연산을 할 수 없다.
names * 3
names + 1


# 함수: 값(argument)을 파라미터(parameter)에 전달하면, 
# 연산 또는 기능을 수행한 후
# 결과를 되돌려 주는 (return) sw코드
scores <- c(99, 100, 87, 50, 95)
average <- mean(scores) #벡터(여러개의 값들)의 평균
average
max(scores) # 벡터에서 최댓값을 찾는 함수
min(scores) # 벡터에서 최솟값을 찾는 함수


# R 함수의 필수/옵션 파라미터
# 필수 파라미터 : 파라미터의 기본값이 지정되지 않아서, 
# 함수를 호출할 때 반드시 값을 전달해야만 하는 파라미터
# 옵션 파라미터: 파라미터의 기본값이 지정되어 있어서,
# 함수를 호출할 때 값을 전달해도 되고, 생략해도 되는 파라미터
# seq(from = 1, to = 1, by = 1)
# seq() 함수는 모든 파라미터가 기본값을 가지고 있음(옵션 파라미터)
seq1 <- seq()
seq1


# 함수를 호출할 때 파라미터 이름을 명시하지 안으면,
# 함수 정의의 파라미터 순서대로 값들이 전달 됨.
seq2 <- seq(1,10,3)
seq2

# R에서는 함수를 호출할 때 파라미터 이름을 명시하면,
# 함수 정의의 파라미터 순서와 상관없이 함수를 호출할 수 있음.
seq3 <- seq.int(from =1, by =4, to =10, length.out )
seq3

#패키지(package):
#함수들과 데이터들을 묶어서 배포하는 꾸러미
#install.packages("패키지이름") - 패키지 설치
install.packages("ggplot2")

x <- c("a","b","a","c")

#패키지가 가지고 있는 함수 또는 데이터를 사용할 때는
#패키지이름::함수/데이터 형식으로 사용하면 됨.
ggplot2::qplot(x)
qplot(x)

#패키지 이름을 명시하지 않으면 함수를 찾지 못하기 때문에 에러 발생

# library(패키지이름): 패키지 이름을 검색 경로에 추가해서
# 패키지가 가지고 있는 함수 또는 데이터들을 
# 패키지 이름을 명시하지 않아도 사용할 수 있게끔 해주는 함수.
library(ggplot2)
qplot(x)

search() # 검색 경로(메모리)에 로드된 패키지, 환경 정보 등을 확인


#detach(): 검색 경로(메모리)에 로드된 패키지를 검색 경로에서 삭제
detach("package:ggplot2")
search()






