rm(list = ls())

# Data Frame(������ ������): ��(row)�� ��(column)�� ����
# �����ͺ��̽��� ���̺� �Ǵ� ������ ���������Ʈ�� ���� ������ ������ 
# �� �÷����� ���� Ÿ���� ���鸸 ������ �� ����.

df1 <- data.frame(id = c(1:3), name = c("aaa","bbb","ccc"), score = c(11,22,33), stringsAsFactors = F)
df1

# ������ �����ӿ��� �ε��� ���
df1[1,1]
df1[1:3, 2]
df1[,2]
df1$name

# ������ �����Ӱ� ����Ʈ�� ������
names <- c("Abc","Def")
ages <- c(30,20,10)

#  ������ �������� ����� ���� ���͵��� ��� ���� ������ ���Ҹ� ������ ��.
# ���� �ٸ� ������ ���Ҹ� ���� ���͵�δ� ������ �������� ���� �� ����.
df_patient <- data.frame(name = names, age = ages, stringsAsFactors = F)
str(df_patient)
df_patient

# ����Ʈ�� ���� �ٸ� ������ ���Ҹ� ���� ���͵�� ������ �� ����.
list_patient <- list( name = names, age = ages )
str(list_patient)
list_patient
list_patient$name

# R ���ǿ��� ����ϴ� ���� �Ǵ� �����͵��� ����
# �����ϴ� ������ Ȯ����: rda, rdata, RData
save(df_patient, list_patient, file = "patient.rda")


# Global Env.�� �ִ� ��� ������ ����
rm(list = ls())

# �����߾��� Rdata ������ �ε�
load("patient.rda")

  
