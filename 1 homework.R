'''
作業題目

練習進行 iris 資料集合的統計分析：

試圖撰寫函數 SummarizeData(data.frame)： 
- 輸入：名為 data.frame 的資料框架，該函數將計算計算 data.frame 的統計量 0    
- 輸出：名為 `output` 的資料框架，`output`  columns 的值依序為 `data.frame` 每個 column 的平均數（`mean`）、變異數（`var`）、最大值（`max`）、最小值（`min`），每個 row 是 `data.frame` 的一個 column 
利用這個函數，計算 iris 資料集合前四個 columns 的各項統計量。

定義第 i 朵花與第 j 朵花的差異程度為兩朵花資料的歐式距離 (Euclidean distance)，其中 xik 代表第 i 朵花在 iris資料集合中第 k 個變數的數值。試著用 for 迴圈建立一個 150 x 150 的矩陣 A，其中 Aij=d(i,j)。
'''


#問題1:(自訂函數與 for 迴圈)
SummarizeData <- function(x){

  output <- data.frame(x_mean = mean(x),
            x_var = var(x),
            x_max = max(x),
            x_min = min(x))
  return(output)
}
SummarizeData(iris[,1])
SummarizeData(iris[,2])
SummarizeData(iris[,3])
SummarizeData(iris[,4])

#問題2:(巢狀 for 迴圈)
A -> matrix(0,nrow=150,ncol=150)
for (i in 1:150) {
    for (j in 1:150){
        for (k in 1:4){
            A[i,j] <- A[i,j]+(iris[i,k] - iris[j, k])^2
        }
    }
}
sqrt(A)
