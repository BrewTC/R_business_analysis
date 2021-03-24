install.packages("tidyverse")

library("tidyverse")

iris2 <- as_tibble(iris)
iris2

# 用變數/欄 (column) 來建立 tibble 物件
tibble(x = 1:5, y = 1, z = x ^ 2 + y)

# 用個體/列 (row) 來建立 tibble 物件，可以使用 tribble
tribble(
  ~x, ~y,  ~z,
  "a", 2,  3.6,
  "b", 1,  8.5
)

# 在已經建立好的 tibble 物件中建立新的 row 與 column，可以利用 add_row 與 add_column 函數
df <- tibble(x = 1:3, y = 3:1)

# add_row
add_row(df, x = 4, y = 0)

# You can specify where to add the new rows
add_row(df, x = 4, y = 0, .before = 2)

add_row(df, x = 4:5, y = 0:-1)

add_row(df, x = 4)

add_column(df, z = -1:1, w = 0)

# 如果想將兩個不同的資料集合合併在一起，可以使用 dplyr 套件中的 bind_rows 與 bind_cols 函數
library(dplyr)

bind_rows(iris2[1:5, ], iris2[6:10, ])

bind_cols(iris2[, 1:2], iris2[, 3:4])

# 在 tidyverse 架構下，資料輸入與輸出的函數都存在於套件 readr 中，此處只介紹讀取上述類型的檔案
library(readr)
# read_csv()：分隔符號為 , 的檔案
read_csv("file1.csv")

# read_csv2()：分隔符號為 ; 的檔案（有些國家的小數點以 , 表示，就會出現這類檔案
read_csv2("file2.csv")

# read_delim()：可以自行選擇分隔符號
read_delim("file3.txt", delim = "|")

# read_tsv()：分隔符號為 tab 的檔案
read_tsv("file4.tsv")

# 輸出 csv 檔案
# 語法為： write_csv(tibble 物件, 檔案名稱, ...)
write_delim(read_delim("file3.txt", delim = "|"),
            "file3_write.txt", delim = "|")

# 輸入 EXCEL 檔案
# tidyverse 架構下要讀取 EXCEL 檔案，會使用 readxl 套件
library(readxl)
# 用excel_sheets列出工作表名稱
excel_sheets("datasets.xlsx")
# 讀取xls和xlsx文件並從擴展名中檢測格式
read_excel("datasets.xlsx")

# 可以選擇特定的活頁簿 (worksheets) 輸入（如果不指定活頁簿，會輸入檔案中的第一個活頁簿）
read_excel("datasets.xlsx", sheet = "chickwts")

read_excel("datasets.xlsx", sheet = 4)

# 以下有一些用來選取輸入範圍的範例

# 只輸出前三row
read_excel("datasets.xlsx", n_max = 3)

read_excel("datasets.xlsx", range = "C1:E4")

read_excel("datasets.xlsx", range = cell_rows(1:4))

read_excel("datasets.xlsx", range = cell_cols("B:D"))
# range = "sheet名稱!(範圍)"
read_excel("datasets.xlsx", range = "mtcars!B1:D5")
# 也可以將特定值設為 NA 值
read_excel("datasets.xlsx", na = "setosa")

# 輸出 EXCEL 檔案
# 不建議在R裡面輸出EXCEL 檔案(很容易出錯)

# 常見的非 Tidy 資料
# 通常 non-tidy data 有四種可能性，針對這四種可能性，tidyr 套件有四個常見的函數可以幫助你將不符合 tidy 原則的資料集合整理成 tidy data。
library(tidyr)
pew <- read_delim(
  "http://stat405.had.co.nz/data/pew.txt",
  delim = "\t"
)
print(pew)

# 如果 Column 其實是值而不是變數 - 使用 Gather

# 最重要的函數輸入有四個部分：
# data：待處理的資料
# key：新變數的欄位名稱
# value：新變數變數值的儲存欄位名稱
# …：要被蒐集起來變成新變數的 columns

# gather(data,
#        key = "key",
#        value = "value",
#        ...,
#        na.rm = FALSE,
#        convert = FALSE,
#        factor_key = FALSE)

# 更改column名字
pew.colnames <- colnames(pew)

# 蒐集所有的值合併為一個新的
# %>%這個符號叫做 pipe 運算元，它的作用是將左側的運算結果傳遞至右側函數的第一個參數
pew.new <- pew %>%
  gather(key = "income",
     value = "cases",
     pew.colnames[2:ncol(pew)])

print(pew.new)

# 把變數當成值 - 使用 spread
table2
# 可以用 spread 指令把這些變數分開。spread 其實就是 gather 的相反
# spread(data,
#        key,
#        value,
#        fill = NA,
#        convert = FALSE,
#        drop = TRUE,
#        sep = NULL)

# 比較重要的參數有：
# key：要被拆開成 variables 的 column
# sep：如果是 NULL，回直接將 key 的值當成新 columns 的名稱，如果輸入其他分隔符號，會回傳：“paste0(key_name,sep,key_value)”


table2 %>%
  spread(key = type,
     value = count)

table2 %>%
  spread(key = type,
     value = count,
     sep = '_')

# 多個變數儲存在同一個 column 中 - 使用 separate
tb <- read_csv("tb.csv")
print(tb)
# 我們可以發現這個資料集合有兩個問題：

# 1. 把值存在 column：m_0-4 代表男性 0 - 4 歲的個體數
# 2. 兩個變數存在同一個值：m_0-4 存了兩個變數

# 第一個問題我們知道可以用 gather 來解決，。
tb.colnames <- colnames(tb)
tb.new <- tb %>%
  gather(
    tb.colnames[4:ncol(tb)],
    key = "type",
    value = "cases")

tb.new

# 然而，type column 中存了兩個變數的數值，該怎麼辦呢？我們可以用 separate 指令來分開
tb.new %>%
  separate(
    col = type,
    into = c("gender", "age"),
    sep = "_",
    convert = TRUE)

# 一個變數被分存在不同 columns 中 - 使用 unite 函數
# 有時候我們也會遇到把同一個變數儲存在不同 columns 的情況，如：日期被分開成年、月、日，反而造成建模或繪圖的困擾。這時該怎麼組合這些 columns 為同一個變數呢？

# 舉例來說，假設我們不小心把 age 分成下界跟上界兩個 columns 儲存。
tb <- read_csv("tb_new.csv")

print(tb)

tb %>%
  unite(col = "age",
        c("age_lb", "age_ub"),
        sep = "-")

#作業
# 從公開資料源下載了「元大寶來台灣卓越50證券投資信託基金」(俗稱 0050) 成分股從 2011 年到 2015 年的股價資料，如下所示。其中每個 column 的意義：
# security_id：每檔股票的證券代碼與名稱，如：1101 台泥 代表證券代碼為 1101，公司名稱為台泥。
# type：open 代表開盤價，close 代表收盤價。
# 2015/12/31：2015年12月31日當日的交易價格。

# 問題 1 (Tidy 原則)
# 這個資料集合顯然不符合 tidy 原則，你認為這個資料集合有下列哪些問題呢？
# (A)Column 其實是值而不是變數 
# (B)把變數當成值 
# (C)多個變數儲存在同一個 column 中 

# 問題 2 (實際操作：gather 函數)
# 請你利用課堂教授過的 gather 函數，將資料整理成以下四個 columns 的格式（只顯示前 6 個 row），如範例資料所示。請問該資料的程式碼應該如何撰寫？
stock.data <- read_csv("TWSE_Stock Data_2012-2017.csv")
# print(stock.data)
stock.data.colnames <- colnames(stock.data)


stock.data <- stock.data %>%
  gather(
    key = "date",
    value = "price",
    stock.data.colnames[3:ncol(stock.data)]
  )
head(stock.data)

# 問題 3 (實際操作：spread 函數)
# 請你利用課堂教授過的 spread 函數，將資料整理成包含以下四個 columns 的格式：
# securty_id / date / open：該證券在該日期的開盤價 / close：該證券在該日期的收盤價
# 如範例資料所示。請問該資料的程式碼應該如何撰寫？
stock.data <- stock.data %>%
  spread(
    key = "type",
    value = "price"
  )
head(stock.data)

# 問題 4 (實際操作：seperate 函數)
# 上一個問題完成後的資料集合，date 的資料裡面是 yyyy/mm/dd 的形式，我們希望將資料的年、月、日分開為三個 columns，如範例資料所示。請問該資料的程式碼應該如何撰寫？
stock.data <- stock.data %>%
  separate(
    col = "date", 
    into = c("year","month","day"),
    sep = "/",
    convert = TRUE
  )
head(stock.data)

# 串聯式的寫法
stock.data <- read_csv("TWSE_Stock Data_2012-2017.csv")
# print(stock.data)

stock.data.colnames <- colnames(stock.data)

stock.data <- stock.data %>%
  # Get the date column
  gather(
    key = "date",
    value = "price",
    stock.data.colnames[3:ncol(stock.data)]
  )%>%
  # Create open and close columns
  spread(
    key = "type",
    value = "price"
  )%>%
  # Seperate date into year, month, and day columns
  separate(
    col = "date", 
    into = c("year","month","day"),
    sep = "/",
    convert = TRUE
  )
head(stock.data)
