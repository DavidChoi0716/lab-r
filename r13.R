# 복지 패널 데이터 분석

# 필요한 라이브러리 로드
library(dplyr)
library(ggplot2)
search()

# 저장해둔 R 데이터 파일을 로드 -> 변수 자동 생성
load("data/welfare.rda")
# 데이터 프레임 확인 
str(welfare)
welfare %>% 
  select(code_job, job) %>% 
  head(n = 10)

table(is.na(welfare$job))

# 직업별 평균 소득 분석
income_by_job <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

income_by_job

# 평균 소득 상위 10개 직종
top10 <- income_by_job %>% 
  arrange(desc(mean_income)) %>% 
  head(n = 10)

top10

# 평균 소득 하위 10개 직종
bottom10 <- income_by_job %>% 
  arrange(mean_income) %>% 
  head(n = 10)

bottom10

# 직종별 평균 급여 상/하위 10개를 그래프
ggplot(data = top10,
       mapping = aes(x = reorder(job, mean_income), 
                     y = mean_income)) +
  geom_col() +
  coord_flip() +
  xlab("job")

ggplot(data = bottom10,
       mapping = aes(x = reorder(job, mean_income), 
                     y = mean_income)) +
  geom_col() +
  coord_flip() +
  xlab("job")


# 직종별 인구수가 30명 이상인 직종에 대해서
# 평균 소득 상위 10개 직종을 찾고, 그래프 작성.
job_population <-
  welfare %>% 
    filter(!is.na(job) & !is.na(income)) %>%  # job, income NA는 제외
    group_by(job) %>%  # job별로 그룹 
    summarise(count = n(), mean_income = mean(income)) %>%  # job별 인구수 
    filter(count >= 30) %>%  # job별 인구수 30 이상인 것만 선택 
    arrange(desc(mean_income))  # job별 평균 소득으로 내림차순 정렬

job_population
job_population_top10 <- job_population %>% head(n = 10)
ggplot(data = job_population_top10,
       mapping = aes(x = reorder(job, mean_income), 
                     y = mean_income)) +
  geom_col() +
  coord_flip()


t10 <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  filter(n() >= 30) %>% 
  summarise(mean = mean(income)) %>% 
  arrange(desc(mean)) %>% 
  head(10)
t10


# 지역별 연령대 비율
# 지역(1 ~ 7 권역) 변수 확인 - NA 없음 
table(welfare$code_region)
# 연령대(ageg, age_range)
table(welfare$ageg)
table(welfare$age_range)

# 지역 코드 - 해당 지역 이름 데이터 프레임
regions <- data.frame(
  code_region = c(1:7),
  region = c("서울",
             "수도권/인천/경기",
             "부산/경남/울산",
             "대구/경북",
             "대전/충남",
             "강원/충북",
             "광주/전남/전북/제주")
)
regions

# 두개의 데이터 프레임을 조인해서 region(지역 이름) 변수를 추가
welfare <- left_join(welfare, regions, by = "code_region")
table(welfare$region)

# 지역별, 연령대별 인구수
region_ageg <- welfare %>% 
  group_by(region, ageg) %>% 
  summarise(count = n()) %>% 
  mutate(total = sum(count), pct = (count / total) * 100)

region_ageg

ggplot(data = region_ageg,
       mapping = aes(x = region, y = pct, fill = ageg)) +
  geom_col() + 
  coord_flip()


region_agerange <- welfare %>% 
  group_by(region, age_range) %>% 
  summarise(count = n()) %>% 
  mutate(total = sum(count), pct = (count / total) * 100)

region_agerange

ggplot(data = region_agerange,
       mapping = aes(x = region, y = pct, fill = age_range)) +
  geom_col() +
  coord_flip()

save(welfare, file = "data/welfare2.rda")



