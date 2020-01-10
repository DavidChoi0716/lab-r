rm(list = ls())

exam <- read.csv("data/csv_exam.csv")
str(exam)
head(exam)
tail(exam)

exam_by_class <- exam %>% 
  group_by(class) %>% 
  summarise(math = mean(math), 
            english = mean(english), 
            science = mean(science))
exam_by_class

ggplot(data = exam_by_class,
       mapping = aes(x = class, y = math)) +
  geom_col()

ggplot(data = exam_by_class) +
  geom_col(mapping = aes(x = class, y = math, fill = "red"), 
           position = "dodge") +
  geom_col(mapping = aes(x = class, y = english, fill = "blue"), 
           position = "dodge")

install.packages("tidyr")
library(tidyr)
# tidyr::gather() 함수 - 엑셀의 pivoting 기능
# 데이터 프레임에서 행과 열의 위치를 바꿔줌
df <- exam_by_class %>% 
  gather(key = "subject", value = "mean", -class)
df

ggplot(data = df,
       mapping = aes(x = class, y = mean, fill = subject)) +
  geom_col(position = "dodge")


exam_by_class %>% gather("var", "value", science)

exam_by_class %>% gather("var", "value", english, science)

