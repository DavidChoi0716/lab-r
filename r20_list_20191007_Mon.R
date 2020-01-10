rm(list = ls())

# List(리스트): 객체들의 집합
# 다른 타입의 값들을 여러개 저장할 수 있는 데이터 구조
list1 <- list(name = c("홍길동","허균"), age = c(16,55), height = c(179.9, 150.5))
list1
list1$name
list1$name[1]

list2 <- list(x = c(1:3),       # vector
              y = matrix(c(1:4), 2, 2), # matrix
              z = list1) # list

list2
list2$x
list2$y
list2$z

list2$x[3]
list2$y[1,2]
list2$z$name

# 리스트의 각 원소(항목)은 인덱스로 접근할 수도 있음.
# 리스트에서 인덱스를 사용할 때는 [[]]를 사용함.
list2[[1]]
list2$x
list2[[1]][2]
list2$x[2]
