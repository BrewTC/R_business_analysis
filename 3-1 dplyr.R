#tidyverse裡面就有包含dplyr
library(tidyverse)

library(dplyr)

# 資料篩選與排序
# dplyr 套件提供了兩個方便進行資料篩選的函數：
# Row 的篩選：filter 函數
# Column 的篩選：select 函數
mtcars.tb <- as_tibble(mtcars)
print(mtcars.tb)

# 利用 filter 函數篩選出需要的 row
# 想要篩選出一加侖汽油的可以跑超過 20 km 且馬力超過 100 匹馬力(hp)的汽車，可以使用 filter 函數：
mtcars.tb %>%
  filter(mpg > 20, hp > 100)

# 利用 select 函數篩選出需要的 column
# 如果我們只需要看「一加侖汽油可跑距離」、「馬力」、與「前進檔數」三個變數，可以使用 select 函數：
mtcars.tb %>%
  select(mpg, hp, gear)

# 我們可以篩選出一加侖汽油的可以跑超過 20 km 且馬力超過 100 匹馬力汽車的「前進檔數」：
mtcars.tb %>%
  filter(
    mpg > 20,
    hp > 100) %>%
  select(gear)

# 利用 arrange 函數進行資料排序(預設為升冪排列)
# 假設我們想要根據某一個 columns 將資料集合的 rows 做排序，可以使用 arrange 函數，同時也可以按照多個 columns 的順序進行排序，會按照 columns 的先後順序進行排序。原始設定是升冪排列，如果想要改成降冪排列的話可以使用 desc(column_name) 指令。

mtcars.tb %>%
  arrange(
    cyl,
    disp
  )

# arrange(desc( ))為降冪排列
mtcars.tb %>%
  arrange(
    desc(disp)
  )

# 使用 mutate 建立新的變數
# 在 tidy 架構下，我們喜歡使用 mutate 函數，將原資料集合的變數做運算與得到新變數。
# mutate 函數會將新的變數儲存在原資料集合的最後一個 column。
mtcars.tb %>%
  mutate(
    cyl2 = cyl * 2,
    cyl4 = cyl2 * 2
  )

# You can also use mutate() to remove variables and
# modify existing variables
#可以取代舊的欄位變成新的欄位
mtcars.tb %>%
  mutate(
    mpg = NULL,
    disp = disp * 0.0163871 # convert to litres
  )

# 如果你只希望保留新建立的變數，可以利用 transmute 函數。
mtcars.tb %>%
  transmute(displ_l = disp / 61.0237)

# 根據組別加總與統整資料
# 如果你有學過 SQL，對於 group_by 這樣的函數絕對不會陌生。
# 假設我們想針對車子的汽缸數量做分組，可以利用以下指令：
mtcars.tb %>%
  group_by(cyl)

# 看起來好像沒發生什麼特別的事情，但如果我們利用 R 的 debug 函數 brower() 去看看 group_by 的執行狀況，就知道發生了什麼事情了！
# 可以在 R Studio 的 console 區執行以下程式碼。
mtcars.tb %>%
  group_by(cyl) %>%
  do(browser())

# 如果我們想要看分組後的資料總結，可以使用 summarise 函數：
mtcars.tb %>%
  group_by(cyl) %>%
  summarise(
    number = n(),
    avg_hp = mean(hp),
    sd_hp = sd(hp),
    max_hp = max(hp),
    min_hp = min(hp)
  ) %>%
  arrange(desc(avg_hp))

# group_by 也可以用來分組篩選資料，比如說找出每組最大馬力的三輛車資料。
mtcars.tb %>%
  group_by(cyl) %>%
  filter(rank(desc(hp)) < 4) %>%
  arrange(desc(cyl), desc(hp))
