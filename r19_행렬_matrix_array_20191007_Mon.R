# matrix(행렬): 같은 타입의 값들을 저장하는 2차원 배열
rm(list=ls())

m1 <- matrix(c(1:20), 5, 4)
m1
  
m2 <- matrix(c(1:20), 5, 4, byrow=T)
m2

# byrow: 행렬에 데이터를 저장할 때 행부터 저장할 지를 결정
# byrow의 기본값은 false. 즉, 데이터를 같은 열에 우선 저장.

# 행렬(matrix)는 인덱스가 2개임 : m[row, col]
m1
m1[1,2]
m1[1:5,2]
m1[2,1:4]
m1[1:2, 1:2]
m1[1,c(T,F,T,F)]

rnames <- c("Row1","Row2")
cnames <- c("Col1","Col2","Col3")
m3 <- matrix(c(1:6), 2, 3, dimnames=list(rnames,cnames))
m3

m3[2,3]
m3["Row2","Col3"] # 행/열의 이름이 있는 경우 인덱스 대신 이름 사용 가능

#  Array: 3차원 이상의 배열
# 인덱스를 3개 이상 갖음.
# 같은 타입의 데이터들을 여러 개 저장.
a1 <- array(data = c(1:24), dim = c(2,3,4))
a1
a1[1,1,1]
a1[1,1,2]

# projection(사상)
a1[,,1]
a1[1,,]

dname1 = c("x1","x2")
dname2 = c("y1","y2","y3")
dname3 = c("z1","z2","z3","z4")
a2 <- array(data = c(1:24), dim = c(2,3,4), dimnames = list(dname1, dname2, dname3))
a2











  