#데이터합치기
#1) 가로로 합치기  - 컬럼을 이어 붙이는 방법
#   관계형 데이터 베이스(Oracle)처럼 여러 테이블에 나눠져 있는 데이터들을 join해서 하나의 데이터 프레임으로 만드는 방법.
#2) 세로로 합치기  - 행을 이어 붙이는 방법
#   어떤 데이터가 행의 갯수가 너무 많아서 여러개의 파일로 쪼개져 있을 경우, 다시 하나의 데이터 프레임으로 합치는 것.

#1) 데이터 프레임을 가로로 합치기 

# join 
# 중간고사 성적
midterm <- data.frame(id = c(1,2,3), mid = c(99,88,100))
midterm

# 기말고사 성적
finalterm <- data.frame(id = c(1,2,3), finalterm = c(95,95,50))
finalterm

# 두 개의 데이터 프레임을 join해서 하나의 데이터 프레임으로 생성
total_score <- left_join(midterm, finalterm)
total_score <- left_join(midterm, finalterm, by ="id")
total_score

total_score <- right_join(midterm, finalterm)
total_score <- right_join(midterm, finalterm, by ="id")
total_score



# join의 종류들
df1 <- data.frame( id = c(1,2,3,4), var1 = c(11,22,33,44))
df1

df2 <- data.frame( id = c(1,2,3,5), var2 = c(50,60,70,80))
df2

#inner join:
inner_join( df1, df2, by = "id" )

#left join:
left_join( df1, df2, by = "id" )

#right join:
right_join( df1, df2, by = "id" )

#full join:
full_join( df1, df2, by = "id" )

#NA(Not Available): 값이 없음

# CSV 파일을 읽어서 데이터 프레임 생성
exam <- read.csv("data/csv_exam.csv")

# 각 반 선생님 이름을 저장하고 있는 데이터 프레임
teachers <- data.frame( class = c(1:5), teachers = c("가","나","다","라","마"))
teachers

# exam과 teachers를 합쳐서 하나의 데이터 프레임을 생성
left_join ( exam, teachers, by = "class" )
right_join ( exam, teachers, by = "class" )
inner_join( exam, teachers, by = "class" )
full_join( exam, teachers, by = "class" )


#2) 데이터 프레임을 세로로 합치기 
group1 <- data.frame(id = c(1,2,3), data = c(10,20,30))
group2 <- data.frame(id = c(4,5,6,7,8), data = seq(40, 80, 10))
group1
group2

group_all <- bind_rows(group1, group2)
group_all

#bind_cols
#bind_rows

g1 <- data.frame(id = c(1:5), var1=seq(10,50,10), var2= seq(11,15))
g2 <- data.frame(id = c(6:10), var2= c(55,66,77,88,99), var3 = c(12,34,56,78,90))
g1
g2

bind_rows(g1,g2)

# 혼자서 해보기

fuel <- data.frame ( fl = c("c","d","e","p","r"),
                     fl_type = c("CNG","diesel","ethanol E85","premium", "regular"),
                     fl_price = c(2.35, 2.38, 2.11,2.76,2.22))

fuel

mpg <- as.data.frame(ggplot2::mpg)
mpg <- left_join (mpg, fuel, by ="fl") # mpg 데이터에 저장하는 부분 주의할 것.

mpg %>% select(model,fl,fl_price) %>%  head(5)


# 1.조건에 맞는 데이터만 추출하기(filter)
exam %>% filter(english >= 80)

#여러 조건 동시 충족(filter 그리고 &)
exam %>% filter(class ==1 & math >= 50)

# 여러 조건 중 하나 이상 충족 (filter 그리고 | or %in%)
exam %>% filter( math >= 90 | english >= 90)
exam %>% filter( class %in% c(1,3,5) )

# 2.필요한 변수만 추출하기 (select)
exam %>% select(math)
exam %>% select(class, math, english)

# 3. 함수 조합하기, 일부만 출력하기
exam %>%  select(id,math) %>% head(10)

# 4.순서대로 정렬하기(arrange)
exam %>% arrange(math)
exam %>% arrange(desc(math))

search()

# 문제 1. popadults 는 해당 지역의 성인 인구, poptotal 은 전체 인구를 나타냅니다.
# midwest 데이터에'전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.
midwest <- as.data.frame(ggplot2::midwest)
midwest <- midwest %>% mutate(ratio_child = ((poptotal-popadults)/poptotal)*100)
midwest
View(midwest)

# 문제 2. 미성년 인구 백분율이 가장 높은 상위 5개 county(지역)의 미성년 인구 백분율을 출력하세요.
# midwest 데이터 프레임에서 ,미성년 인구 백분을을 내림차순으로 배열하고, county와 ratio_child 컬럼을 셀렉하고, 상위 다섯개 행을 헤드로 출력
midwest %>% arrange(desc(ratio_child)) %>%  select(county,ratio_child) %>%  head(5)

# 문제 3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가
# 각 등급에 몇개의 지역이 있는지
midwest <- midwest %>% mutate(grade = ifelse(ratio_child >= 40, "large",ifelse(ratio_child >=30, "middle", "small")))
table(midwest$grade)


# 문제 4. popasian은 해당 지역의 아시아인 인구.
# 전체인구 대비 아시아인 인구 백분율 변수를 추가

midwest %>%  mutate(ratio_popasian_percent = (popasian/poptotal)*100)
midwest

# 하위 10개 지역의 state(주), county(지역명), 아시아인 인구 백분율을 출력하세요
midwest %>%  arrange(desc(ratio_popasian)) %>%  select(state, county, ratio_popasian) %>% head(10)

str(midwest)



