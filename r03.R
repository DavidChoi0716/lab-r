# csv, 엑셀 파일에서 데이터 프레임 만들기

# 현재 작업 디렉토리(폴더) 확인
getwd()
# 현재 작업 디렉토리를 변경
setwd("C:/dev/lab-r")

# ./data/csv_exam.csv 파일을 읽어서 데이터 프레임 생성
exam_csv <- read.csv("data/csv_exam.csv")
# 데이터 프레임의 내용 확인
exam_csv
# 수학 점수들의 합계
sum(exam_csv$math)
# 영어 점수들의 평균
mean(exam_csv$english)
# 각 학생들의 수학/영어/과학 점수 합계
total <- exam_csv$math + exam_csv$english + exam_csv$science
total

v1 <- c(10, 20, 30)
v2 <- c(1, 2, 3)
v1 + v2



# 헤더가 없는 csv 파일에서 데이터 프레임을 생성
exam_csv2 <- read.csv("data/exam_nohead.csv", 
                      header = FALSE)
exam_csv2 

# Windows 메모장에서 UTF(BOM) 인코딩으로 저장한 파일인 경우
exam_csv2 <- read.csv("data/exam_nohead.csv", 
                      header = FALSE,
                      fileEncoding = "UTF-8-BOM")
exam_csv2

#헤더(컬럼/변수 이름)이 있고, 구분자가 콜론(:)인 csv 파일 읽기
exam_csv3 <- read.csv("data/csv_exam2.csv",
                      header = TRUE,
                      sep = ":",
                      fileEncoidng = "UTF-8-BOM")
exam_csv3





# MS 엑셀 파일(xls, xlsx)을 읽어서 데이터 프레임을 생성
# readxl 패키지를 설치
# install.packages("readxl")
# readxl::read_excel() 함수 호출
# 설치한 패키지를 검색 경로에 추가한 후 사용
library(readxl)
# 패키지가 검색 경로에 추가됐는지 확인 
search()


exam_xlsx <- read_excel("data/excel_exam.xlsx")
exam_xlsx
# 수학 점수 출력
exam_xlsx$math
# 영어 점수 출력
exam_xlsx$english
# 과학 점수 출력
exam_xlsx$science



#엑셀 파일에서 첫번째 행이 컬럼(변수) 이름이 아닌 경우
exam_xlsx_nohead <- read_excel ("data/excel_exam_novar.xlsx",
                                col_names = FALSE)


exam_xlsx_nohead

#엑셀 파일에 컬럼 이름이 없는 경우
#직접 컬럼 이름을 만들어 줄 수도 있다.
exam_xlsx_nohead <- read_excel ("data/excel_exam_novar.xlsx",
                                col_names = c("id","cl","m","e","s"))

exam_xlsx_nohead


#엑셀 파일에서 특정 sheet에 있는 데이터를 읽는 경우
exam_xlsx_sheet <- read_excel("data/excel_exam_sheet.xlsx",
                              sheet = 3)

exam_xlsx_sheet
