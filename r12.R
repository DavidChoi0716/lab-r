# 복지 패널 데이터

rm(list = ls())

# 통계 전용 프로그램 SPSS에서 만들어진 sav 파일을 읽어서 
# 데이터 프레임을 생성하려면 foreign 패키지가 필요
install.packages("foreign")

# 분석에 필요한 패키지들을 검색 경로(메모리)에 로드
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)
search()

# SPSS에서 사용하는 sav 파일을 R에서 사용할 수 있는 
# data.frame 타입으로 변환
raw_welfare <- read.spss(file = "data/Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)

# 원본 데이터 프레임을 복사
welfare <- raw_welfare

# 데이터 프레임 구조 확인 
str(welfare)
table(welfare$h10_g3)  # 성별
table(welfare$h10_g4)  # 태어난 연도
table(welfare$h10_g10)  # 혼인상태
table(welfare$h10_reg7)  # 지역

# 변수 이름들을 분석하기 쉽게 변경
# rename(데이터프레임, 바꿀 이름 = 원래 변수 이름)
# h10_g3: 성별 => gender
# h10_g4: 태어난 연도 => birth
# h10_g10: 혼인 여부 => marriage
# h10_g11: 종교 => religion
# h10_eco9: 직종코드 => code_job
# p1002_8aq1: 월 급여 => income
# h10_reg7: 7개 권역(지역, 서울/수도권/경남/...) => code_region
welfare <- welfare %>% 
  rename(gender = h10_g3,
         birth = h10_g4,
         marriage = h10_g10,
         religion = h10_g11,
         code_job = h10_eco9,
         income = p1002_8aq1,
         code_region = h10_reg7)

# 성별에 따른 월급 차이?
# 성별(gender)
table(welfare$gender)  # 성별 돗수분포표
# 성별 변수에는 이상치가 없다.
# 만약에 이상치가 있는 경우에는 이상치를 NA로 처리
welfare$gender <- ifelse(welfare$gender %in% c(1, 2),
                         welfare$gender, NA)

# 성별은 질적 변수(qualitative variable):
# 1, 2라는 숫자(의 크기)가 중요한 게 아니라, 남/여 구분이 중요
# gender 변수를 factor로 만듦.
welfare$gender <- factor(welfare$gender,
                         levels = c(1, 2),
                         labels = c("남자", "여자"))
table(welfare$gender)
summary(welfare$gender)
class(welfare$gender)

# 성별 인구수
ggplot(data = welfare, mapping = aes(x = gender, fill = gender)) +
  geom_bar()

# 월 급여(income)
class(welfare$income)  
# income 변수의 데이터 타입은 숫자 -> 양적 변수(quantative variable)
# income 변수의 요약 정보
summary(welfare$income)
# income 변수의 값이 9999인 경우는 한달 급여를 응답하지 않은 경우임 
# -> 이상치 처리를 해야 함
# summary() 함수를 사용해서 이상치가 없음을 확인함.
welfare$income <- ifelse(welfare$income > 0 & welfare$income < 9999,
                         welfare$income, NA)
summary(welfare$income)

# 급여의 분포
ggplot(data = welfare, mapping = aes(x = income)) +
  geom_bar(binwidth = 50) + 
  xlim(0, 1000)

# 성별 평균 한달 급여
welfare %>% 
  group_by(gender) %>% 
  summarise(income_by_gender = mean(income, na.rm = T))

income_by_gender <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(gender) %>% 
  summarise(mean = mean(income))
income_by_gender

ggplot(data = income_by_gender,
       mapping = aes(x = gender, y = mean, fill = gender)) +
  geom_col()


# 나이(연령)에 따른 급여?
# 태어난 연도 돗수분포표
table(welfare$birth)
# NA 여부 확인
table(is.na(welfare$birth))

# welfare 데이터 프레임에 age(나이) 변수 추가
# 나이 계산은 통계 데이터 조사 시점(2015)을 기준
welfare$age <- 2015 - welfare$birth
table(welfare$age)
summary(welfare$age)

# 연령 분포(나이 돗수분포표를 막대 그래프로)
ggplot(data = welfare, mapping = aes(x = age)) +
  geom_bar()

income_by_age <- welfare %>% 
  filter(!is.na(income)) %>%   # income이 na는 제외
  group_by(age) %>%   # 연령별
  summarise(mean = mean(income))  # 평균 급여 계산
income_by_age
head(income_by_age)
tail(income_by_age)

ggplot(data = income_by_age, mapping = aes(x = age, y = mean)) +
  geom_col()

ggplot(data = income_by_age, mapping = aes(x = age, y = mean)) +
  geom_line()


# 연령별 성별 평균 급여 그래프.
income_by_age_gender <-
  welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, gender) %>% 
  summarise(mean = mean(income))
head(income_by_age_gender)
tail(income_by_age_gender)

ggplot(data = income_by_age_gender, 
       mapping = aes(x = age, y = mean, color = gender)) +
  geom_line()

  
# 연령대(ageg: age gap)별 평균 급여
# 연령대를 30세 미만(young), 60세 미만(middle), 60세 이상(old) 구간으로 나눔.
welfare <- welfare %>% 
  mutate(ageg = ifelse(age < 30, "young", 
                       ifelse(age < 60, "middle", "old")))

# ageg 변수를 질적 변수(순서형 변수, ordinal)로 만듦.
welfare$ageg <- factor(welfare$ageg,
                       levels = c("young", "middle", "old"),
                       ordered = T)

table(welfare$ageg)
ggplot(data = welfare, mapping = aes(x = ageg)) +
  geom_bar()


# 연령대별 평균 급여 테이블 
income_by_ageg <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean = mean(income))

income_by_ageg

ggplot(data = income_by_ageg, mapping = aes(x = ageg, y = mean)) +
  geom_col()


# 연령대별, 성별 평균 급여
income_by_ageg_gender <-
  welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, gender) %>% 
  summarise(mean = mean(income))

income_by_ageg_gender

ggplot(data = income_by_ageg_gender,
       mapping = aes(x = ageg, y = mean, fill = gender)) +
  geom_col()

ggplot(data = income_by_ageg_gender,
       mapping = aes(x = ageg, y = mean, fill = gender)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("darkgreen", "darkred"))


# welfare 데이터 프레임에 age_ranage 변수를 추가
# age < 20 이면 "age10", age < 30 이면 "age20", age < 40 이면  "age30", ...
# age < 80 이면 "age70", 그 이외에는  "age80"
welfare <- welfare %>% 
  mutate(age_range = ifelse(age < 20, "age10",
                ifelse(age < 30, "age20",
                       ifelse(age < 40, "age30",
                              ifelse(age < 50, "age40",
                                     ifelse(age < 60, "age50",
                                            ifelse(age < 70, "age60",
                                                   ifelse(age < 80, "age70", "age80"))))))))

# age_range별 인구수 - 테이블, 그래프
table(welfare$age_range)
ggplot(data = welfare, mapping = aes(x = age_range)) +
  geom_bar()

# age_range별 평균 급여 - 테이블, 그래프 
income_by_agerange <-
  welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age_range) %>% 
  summarise(mean = mean(income))

income_by_agerange

ggplot(data = income_by_agerange,
       mapping = aes(x = age_range, y = mean)) +
  geom_col()

# age_range별, 성별 평균 급여 - 테이블, 그래프 
income_by_agerange_gender <-
  welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age_range, gender) %>% 
  summarise(mean = mean(income))

income_by_agerange_gender

library(ggthemes)
ggplot(data = income_by_agerange_gender, 
       mapping = aes(x = age_range, y = mean, fill = gender)) + 
  geom_col(position = "dodge") +
  theme_wsj() +
  scale_fill_manual(values = c("darkgreen", "pink"))


# 직업별 급여의 차이
class(welfare$code_job)
head(welfare$code_job)
tail(welfare$code_job)
summary(welfare$code_job)

# 엑셀 파일에 정리된 code_job, job을 새로운 데이터 프레임으로 생성 
df_jobs <- read_excel("data/Koweps_Codebook.xlsx", sheet = 2)
head(df_jobs)
tail(df_jobs)
str(df_jobs)


# welfare, df_jobs 데이터 프레임을 join
welfare <- left_join(welfare, df_jobs, by = "code_job")

welfare %>% 
  select(code_job, job) %>% 
  head(n = 10)

welfare %>% 
  select(code_job, job) %>% 
  tail(n = 10)

table(welfare$code_job)

job_top10 <-
  welfare %>% 
    filter(!is.na(code_job)) %>% 
    group_by(job) %>% 
    summarise(count = n()) %>% 
    arrange(desc(count)) %>% 
    head(n = 10)

job_top10

ggplot(data = job_top10,
       mapping = aes(x = reorder(job, count), y = count)) +
  geom_col() +
  coord_flip() + 
  xlab("직종")

# 남자들이 가장 많이 종사하는 직종 10개를 찾아서 그래프
table(welfare$gender)

job_male_top10 <- welfare %>% 
  filter(!is.na(code_job) & gender == "남자") %>% 
  group_by(job) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count)) %>% 
  head(n = 10)

job_male_top10

ggplot(data = job_male_top10,
       mapping = aes(x = reorder(job, count), y = count)) +
  geom_col() +
  coord_flip() +
  xlab("직종") + ylab("인구수")

# 여자들이 가장 많이 종사하는 직종 10개를 찾아서 그래프 
job_female_top10 <- welfare %>% 
  filter(!is.na(code_job) & gender == "여자") %>% 
  group_by(job) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count)) %>% 
  head(n = 10)

job_female_top10

ggplot(data = job_female_top10,
       mapping = aes(x = reorder(job, count), y = count)) +
  geom_col() +
  coord_flip()


# 데이터 가공을 해왔던 welfare 데이터 프레임을 
# R에서 사용하는 데이터 파일 형식(rda)으로 저장 
save(welfare, file = "data/welfare.rda")

rm(welfare)
load("data/welfare.rda")
str(welfare)
