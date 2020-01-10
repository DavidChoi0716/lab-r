rm(list = ls())

# word cloud
# 필요한 패키지 설치
# R에서 Java를 사용한 패키지를 이용할 수 있도록 해주는 패키지
install.packages("rJava") 
# KoNLP 패키지(한국어 분석)가 사용하는 패키지
install.packages("memoise")
# KoNLP(Korean Natural Languague Processing): 한국어 자연어 처리
install.packages("KoNLP")
# 문자열을 처리하는 여러가지 함수들을 가지고 있는 패키지 
install.packages("stringr")

# wordcloud 작성 패키지
install.packages("wordcloud")

# 설치한 패키지들을 검색 경로(메모리)에 로드
library(KoNLP)
library(stringr)
library(wordcloud)
search()

# 한국어 분석에 사용할 사전을 로드 
useSejongDic()

# 텍스트 파일(*.txt)에서 한줄씩 문자열들을 읽음
txt <- readLines("data/hiphop.txt")
str(txt)
txt[1:10]
txt[1001:1010]

# 특수문자(", ?, !, ...)들은 제외
# 정규 표현식(regular expression): 문자열의 패턴
txt <- str_replace_all(txt, "\\W", " ")
txt[1:10]

# 각 문장에서 명사들만 추출 
nouns <- extractNoun(txt)
str(nouns)
head(nouns)
tail(nouns)

# 명사들로 이루어진 리스트를 돗수분포표 형태로 변환
word_count <- table(unlist(nouns))
word_count

# 돗수분포표(테이블)을 데이터 프레임으로 변환
# 문자열을 범주형 변수로 취급하지 않음.
df <- as.data.frame(word_count, stringsAsFactors = F)
head(df)
tail(df)

# 데이터 프레임을 분석하기 쉽게 변수 이름을 변경
df <- rename(df, word = Var1, freq = Freq)
tail(df)
str(df)

#  word의 길이는 2글자 이상인 것만 선택 
df <- filter(df, nchar(word) >= 2)
str(df)
tail(df)

# 가장 많이 사용된 명사 20개
top20 <- df %>% 
  arrange(desc(freq)) %>% 
  head(n = 20)
top20

# wordcloud 작성
# 팔레트 설정
# Dark2 색상 목록에서 8개의 색상을 선택
pal <- brewer.pal(8, "Dark2")

# wordcloud는 생성할 때마다 랜덤하게 만들어 지는데,
# 실행할 때마다 항상 같은 결과를 주기 위해서,
set.seed(1234)

# wordcloud 작성
wordcloud(words = df$word,   # 단어
          freq = df$freq,    # 단어의 빈돗수
          min.freq = 2,      # 단어의 최소 빈돗수
          max.words = 200,   # word cloud에 보여줄 단어의 최대 갯수
          random.order = F,  # 단어들을 무작위 배치?
          rot.per = 0.2,     # 회전 단어 비율
          scale = c(4, 0.3), # 단어 크기 비율
          colors = pal)

