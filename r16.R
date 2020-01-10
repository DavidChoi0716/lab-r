# 지도 위에 통계 값들 표시하기

# ggplot2::map_data() 함수가 지도 데이터를 처리하기 위해 필요한 패키지
install.packages("maps")
# ggplot2::coord_map() 함수가 사용하는 패키지
install.packages("mapproj")
install.packages("ggplot2")

library(ggplot2)

asia_map <- map_data(map = "world",
                     region = c("North Korea", "South Korea",
                                "Japan", "China", "India"))
str(asia_map)
head(asia_map)
tail(asia_map)
# longitude(경도): 영국의 그리니치 천문대를 기준으로 동/서 방향 좌표
# latitude(위도): 적도를 기준으로 남/북 방향 좌표
# group: 함께 연결할 위도/경도 점들의 그룹(나라, 주, 도시, ...)
# order: 위도/경도 점들을 연결할 순서
# region: 지역 이름

# ggplot2 패키지를 사용할 때
# data 파라미터는 위도/경도 정보를 가지고 있는 지도 데이터를 전달
# x축 매핑 파라미터 = 경도(long)
# y축 매핑 파라미터 = 위도(lat)
# 그래프의 종류: 다각형 그래프(polygon)
ggplot(data = asia_map,
       mapping = aes(x = long, y = lat, group = group, fill = region)) +
  geom_polygon() +
  coord_map("polyconic")


# 대한민국 지도
korea_map <- map_data(map = "world",
                      region = c("South Korea", "North Korea"))
head(korea_map)
tail(korea_map)

ggplot(data = korea_map,
       mapping = aes(x = long, y = lat, group = group, fill = region)) +
  geom_polygon(color = "black") +
  coord_map()


# 미국 지도
us_state <- map_data(map = "state")
str(us_state)
head(us_state)
tail(us_state)

ggplot(data = us_state,
       mapping = aes(x = long, y = lat, group = group, fill = region)) +
  geom_polygon(color = "black") +
  coord_map()


# 미국 주별 범죄율 그래프 
library(dplyr)  # 데이터 전처리
search()

# 데이터 프레임 확인
# USArrests: R에서 제공하는 학습용 데이터 프레임
str(USArrests)
head(USArrests)
tail(USArrests)
# USArrests 데이터 프레임에는 미국 주(state)의 이름들이
# 각 행의 이름으로 설정되어 있음.
# us_map 데이터 프레임과 join하기 위해서는 주 이름들이 
# 데이터 프레임의 변수로 있어야 함.
library(tibble)
us_crime <- rownames_to_column(USArrests, var = "state")
str(us_crime)
head(us_crime)

# 미국 주 이름을 표시하는 
# us_state의 region 변수는 소문자로만 되어 있고,
# us_crime의 state 변수는 첫글자가 대문자로 되어 있음.
us_crime$state <- tolower(us_crime$state)
head(us_crime)

# 지도/범죄를 합친 데이터 프레임(join)
state_crime <- left_join(us_state, us_crime, 
                         by = c("region" = "state"))
str(state_crime)
head(state_crime)

# 주별 살인 범죄율
ggplot(data = state_crime,
       mapping = aes(x = long, y = lat, group = group, fill = Murder)) +
  geom_polygon(color = "black") +
  coord_map() +
  scale_fill_continuous(low = "white", high = "darkred")

# choropleth map(단계 구분도)
# 지도 위에 통계 값들을 색깔로 구분해서 표현하는 방법.
# 인구, 질병, 범죄, ...
# ggiraphExtra 패키지: 단계 구분도를 쉽게 그릴 수 있는 패키지.
install.packages("ggiraphExtra")
library(ggiraphExtra)

ggChoropleth(data = us_crime,
             mapping = aes(fill = Murder, 
                           map_id = state), 
             map = us_state)
# ggChoropleth() 함수의 변수들
# data = 통계값이 들어있는 데이터 프레임(미국 주별 범죄율)
# map = 지도(위도, 경도, 지역, 그룹, ...) 정보 데이터 프레임
# mapping
# 1) map_id = data와 map을 join할 수 있는 통계 데이터 프레임의 변수 이름
#    map의 region과 일치되는 data의 변수
# 2) fill = 지도의 각 그룹을 색깔로 채울 변수

ggChoropleth(data = us_crime, map = us_state,
             mapping = aes(fill = Murder, map_id = state),
             interactive = T)



# 문자 인코딩, 변환 관련 기능 패키지
install.packages("stringi")  # ICU(International Component of Unicode)
# 개발자 도구 패키지
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")

# install.packages(): R 공식 페이지(패키지 저장소)에서 다운로드
# devtools::install_github(): github.com 저장소에서 다운로드 

library(kormaps2014)
library(ggplot2)
library(dplyr)
library(ggiraphExtra)
search()

# kormaps2014 패키지에 있는 인구 조사 데이터 프레임
# str(korpop1) 
# 데이터 프레임의 컬럼 이름들이 한글이어서 결과가 제대로 보이지 않음
str(changeCode(korpop1))
# kormaps2014::changeCode(): 
# 데이터 프레임의 컬럼(변수) 이름이 한글로 되어 있는 것을 처리해줌.

head(changeCode(korpop1))  # 거주지역, 인구, 주거형태, ...

# 한글로 되어 있는 컬럼들은 에러가 발생할 수 있어서 영어로 변경
korpop1 <- rename(korpop1,
                  name = 행정구역별_읍면동,
                  pop = 총인구_명)
head(changeCode(korpop1))

ggChoropleth(data = korpop1, map = kormap1,
             mapping = aes(fill = pop, map_id = code, tooltip = name),
             interactive = T)

head(changeCode(tbc))  # 결핵 환자 숫자 데이터 프레임
ggChoropleth(data = tbc, map = kormap1,
             mapping = aes(fill = NewPts, map_id = code, 
                           tooltip = name),
             interactive = T)

str(tbc)
head(changeCode(tbc))
tail(changeCode(tbc))

tbc2015 <- tbc %>% filter(year == 2015)
ggChoropleth(data = tbc2015, map = kormap1,
             mapping = aes(fill = NewPts, map_id = code, 
                           tooltip = name),
             interactive = T)




