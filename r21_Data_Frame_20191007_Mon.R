rm(list = ls())

# Data Frame(데이터 프레임): 행(row)과 열(column)을 갖는
# 데이터베이스의 테이블 또는 엑셀의 스프레드시트와 같은 형식의 데이터 
# 각 컬럼에는 같은 타입의 값들만 저장할 수 있음.

df1 <- data.frame(id = c(1:3), name = c("aaa","bbb","ccc"), score = c(11,22,33), stringsAsFactors = F)
df1

# 데이터 프레임에서 인덱스 사용
df1[1,1]
df1[1:3, 2]
df1[,2]
df1$name

# 데이터 프레임과 리스트의 차이점
names <- c("Abc","Def")
ages <- c(30,20,10)

#  데이터 프레임을 만들기 위한 벡터들은 모두 같은 갯수의 원소를 가져야 함.
# 서로 다른 갯수의 원소를 갖는 벡터들로는 데이터 프레임을 만들 수 없음.
df_patient <- data.frame(name = names, age = ages, stringsAsFactors = F)
str(df_patient)
df_patient

# 리스트는 서로 다른 갯수의 원소를 갖는 벡터들로 생성할 수 있음.
list_patient <- list( name = names, age = ages )
str(list_patient)
list_patient
list_patient$name

# R 세션에서 사용하던 변수 또는 데이터들을 저장
# 저장하는 파일의 확장자: rda, rdata, RData
save(df_patient, list_patient, file = "patient.rda")


# Global Env.에 있는 모든 변수들 삭제
rm(list = ls())

# 저장했었던 Rdata 파일을 로딩
load("patient.rda")

  

