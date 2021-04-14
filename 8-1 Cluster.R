library(tidyverse)
library(knitr)

setwd("C:/Users/Matt/Downloads/集群分析")

SalesData <- read.csv('Restaurant_Sales.csv')
> 
  > kable( SalesData[1:10,], row.names = F, caption = '原始資料')

kable( SalesData[1:10,], row.names = F, caption = '原始資料')

#探索性資料分析

#各店的銷售分配
#店1和店4的營收較高，變異也較大；店2和店3雖然營收較低，但較為集中
SalesData$Store_Name <- as.factor(SalesData$Store_Name)

ggplot(data = SalesData) + geom_boxplot(aes( x= Store_Name, y= Sales, colour = Store_Name)) + 
  labs( x = 'Store',
        y = 'Sales',
        title = 'Sales Distribution by Store')

#各區域的銷售分配
#區域A和區域B的營收分佈有較大的差異
ggplot(data = SalesData) + geom_boxplot(aes( x = Region, y = Sales,colour = Region)) + 
  labs( x = 'Region',
        y = 'Sales',
        title = 'Sales Distribution by Region')

#各門市類型的銷售分配
#百貨門市(AA)和獨立門市(BB)相比，營收較高
ggplot(data = SalesData) + geom_boxplot(aes( x = Type, y = Sales, colour = Type)) + 
  labs( x = 'Type',
        y = 'Sales',
        title = 'Sales Distribution by Type')

#各店間的平假日銷售分配
#四間店平日和假日的銷售分佈不盡相同
ggplot(data = SalesData) + geom_boxplot(aes( x = Weekday, y = Sales, colour = Weekday)) + 
  
  facet_wrap(~ Store_Name) +
  
  labs( x = 'Weekday',
        y = 'Sales',
        title = 'Sales Distribution by Weekday') 

#各店間的月份銷售分配
#四間店在各月份的銷售分佈也不盡相同
SalesData$Month <- factor(SalesData$Month, levels = c('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'))

SalesDatabyMonth <- SalesData %>% 
  group_by( Store_Name,Month) %>%
  summarise( SalesMean = mean(Sales))

ggplot(data = SalesDatabyMonth,aes( x = Month, y = SalesMean)) + geom_point() + geom_line() +
  
  facet_wrap(~ Store_Name) +
  
  labs( x = 'Month',
        y = 'Sales',
        title = 'Sales Distribution by Month') 

#迴歸分析
#迴歸分析主要會用到的函數是lm()，意思是Linear Model。主要使用到的參數有兩個：
#formula: Y ~ X1 + X2，Y是反應變數，X1和X2是解釋變數。
#data: 要分析的資料集合名稱。
#這個類型的物件裡面包含很多內容，用來描述模型的細節。如果要呼叫摘要，一樣使用summary()。


#依區域分開建模
#由於我們發現區域(Region)之間的營業額有較明顯的差異，但在其他變數中營業額的分布各有不同，因此我們先依照區域切分資料，探討其他變數的影響。

DataA <- SalesData %>%
  filter( Region %in% 'A')
DataB <- SalesData %>%
  filter( Region %in% 'B')

#驗證假說一：門市類型的差異
Model.A.Type <- lm( Sales ~ Type, data = DataA)
Model.B.Type <- lm( Sales ~ Type, data = DataB)

#對於這兩個區域而言，門市類型的差異有非常顯著的影響，R-squared分別是0.72和0.46，具有相當不錯的解釋能力。
summary(Model.A.Type)
summary(Model.B.Type)

#驗證假說二：假日的差異
Model.A.Week <- lm( Sales ~ Weekday, data = DataA)
Model.B.Week <- lm( Sales ~ Weekday, data = DataB)
#平日假日對於區域A而言雖有顯著的差異，但對整體營收變化的解釋力較弱；對於區域B而言，並沒有顯著的差異及影響。
summary(Model.A.Week)
summary(Model.B.Week)

#驗證假說三：月份的差異
#區域A間的區域B間的月份間皆有顯著的差異，但各月份的影響程度不一；對於區域B而言，月份對整體營收的變化有較好的解釋能力。
Model.A.Month <- lm( Sales ~ Month, data = DataA)
Model.B.Month <- lm( Sales ~ Month, data = DataB)
summary(Model.A.Month)
summary(Model.B.Month)

#納入上述顯著變數並檢視目前模型的解釋能力
Model.A <- lm( Sales ~ Type + Weekday + Month, data = DataA)
Model.B <- lm( Sales ~ Type + Month, data = DataB)
#綜合考慮以上變數，其實已經能夠對營收的變化做還算完整的解釋
summary(Model.A)
summary(Model.B)

#用視覺化圖表來檢視目前的成果
#店1的營收
#我們可以發現目前的模型仍無法掌握到比較極端的高點或低點
ggplot( data = DataA[1:365,]) + geom_point( aes(x = c(1:365),
y = Sales)) + 
  geom_line( aes( x = c(1:365),
                  y = Model.A$fitted.values[1:365],
                  colour = 'red')) +
  labs( x = 'Day1 to Day365',
        y = 'Sales',
        title = 'Store1 Sales: Actual vs Predicted')

#由於店2考慮的因素較少，同樣也存在沒辦法掌握到較極端點的問題

ggplot( data = DataB[1:365,]) + geom_point( aes(x = c(1:365),
                                                y = Sales)) + 
  geom_line( aes( x = c(1:365),
                  y = Model.B$fitted.values[1:365],
                  colour = 'red'))  +
  labs( x = 'Day1 to Day365',
        y = 'Sales',
        title = 'Store2 Sales: Actual vs Predicted')



#加入新資訊
#在重新搜集資料後，新增了三個欄位：Holiday、Store1_Event、Store2_Event，分別是是否為國定假日、分店一所屬的百貨特別活動和分店二所屬的百貨特別活動。

SalesDataRenew <- read.csv('Restaurant_Sales_Renew.csv')

kable( SalesDataRenew[1:10,], row.names = F, caption = '新增資料')

#檢視新變數對營收的影響
Model.Holiday <- lm( Sales ~ Holiday, data = SalesDataRenew)

Event <- ifelse( SalesDataRenew$Store1_Event %in% 1 | SalesDataRenew$Store2_Event %in% 1, 1, 0)
Model.Event <- lm( SalesDataRenew$Sales ~ Event)
#新的變數對於整體營收皆有顯著的影響，因此我們決定納入之後的建模
summary(Model.Holiday)
summary(Model.Event)
#將全部資料進行建模
#這邊我們先跳出之前的假設，嘗試將區域的差異納入模型中，試著討論模型能否學習到區域間的差異，進而產生更好的解釋能力

Model.All <- lm( Sales ~ ., data = SalesDataRenew[,-1])
summary(Model.All)
#整體的R-squared上升了，但月份間的差異變得較不顯著

#用視覺化檢視目前的成果
#店1的營收
#在店1的營收解釋上，此模型在納入新的變數後，表現的確能更抓到營收較高的那幾天
ggplot( data = SalesDataRenew[1:365,]) + geom_point( aes(x = c(1:365),
                                                         y = Sales)) + 
  geom_line( aes( x = c(1:365),
                  y = Model.All$fitted.values[1:365],
                  colour = 'red')) +
  labs( x = 'Day1 to Day365',
        y = 'Sales',
        title = 'Store1 Sales: Actual vs Predicted')

#店2的營收 但在店2的營收中，雖然也因為百貨活動抓到了較高的幾天，由於店2屬於百貨門市的類型，模型對它的營收估計較高，所以整體而言明顯高估
ggplot( data = SalesDataRenew[366:730,]) + geom_point( aes(x = c(1:365),
                                                           y = Sales)) + 
  geom_line( aes( x = c(1:365),
                  y = Model.All$fitted.values[366:730],
                  colour = 'red')) +
  labs( x = 'Day1 to Day365',
        y = 'Sales',
        title = 'Store2 Sales: Actual vs Predicted')

#四間店
#區域和門市類型的差異影響了模型的解釋與判斷，因此將四間店的資料納入同一個模型並非最好的做法
ggplot( data = SalesDataRenew) + geom_point( aes(x = c(1:1460),
                                                 y = Sales)) + 
  geom_line( aes( x = c(1:1460),
                  y = Model.All$fitted.values,
                  colour = 'red')) +
  labs( x = 'Day',
        y = 'Sales',
        title = 'Store Sales: Actual vs Predicted')

#Beta Coefficients
Beta <- cbind(
  names(Model.All$coefficients),
  Model.All$coefficients
) %>% 
  as.data.frame() 

colnames(Beta) <- c('Name', 'Value')
Beta$Value <- Beta$Value %>% as.character() %>% as.numeric()

Beta <- Beta %>%
  arrange(desc(Value))

ggplot( data = Beta) + 
  geom_bar(aes( x = factor(Name, levels = as.character(Beta$Name)), 
                y = Value, 
                fill = Name),stat = 'identity') + 
  
  labs( x = 'Variable',
        y = 'Beta Coefficient',
        title = 'Beta Coefficient of Model.All') + coord_flip() + theme_bw()


#用更新資料分區域預測
#這邊納入了一個新觀念：交互作用(interaction)，在前面的建模過程中，我們觀察到不同門市類型的平假日表現可能有所不同，因此我們用Var1 * Var2這樣的方式表示兩個變數間互相的影響，會對目標變數造成什麼樣的效果。
DataRenewA <- SalesDataRenew %>% filter( Region %in% 'A')
DataRenewB <- SalesDataRenew %>% filter( Region %in% 'B')


Model.A.All <- lm( Sales ~ .+ Type * Weekday, data = DataRenewA[,-c(1,2)])
Model.B.All <- lm( Sales ~ .+ Type * Weekday , data = DataRenewB[,-c(1,2)])

#在這裡可以看到，加入交互作用後，區域B的平假日影響也變得顯著，更值得注意的是在兩個模型中，屬於BB的門市類型在遇到假日時，對於營收反而有顯著的負面影響。
summary(Model.A.All)
summary(Model.B.All)

#Region A
ggplot( data = DataRenewA) + geom_point( aes(x = c(1:730),
                                             y = Sales)) + 
  geom_line( aes( x = c(1:730),
                  y = Model.A.All$fitted.values,
                  colour = 'red'))

#Region B
ggplot( data = DataRenewB) + geom_point( aes(x = c(1:730),
                                             y = Sales)) + 
  geom_line( aes( x = c(1:730),
                  y = Model.B.All$fitted.values,
                  colour = 'red'))

#探討模型的準確度及誤差
#誤差：以RMSE衡量(Root-Mean-Square Error)
RMSE <- function( predict, actual){
  result <- sqrt(mean((predict - actual) ^ 2))
  return(result)
}

cat('RegionA模型的RMSE：\n',RMSE(Model.A.All$fitted.values, DataRenewA$Sales),'\n',sep = '')
## RegionA模型的RMSE：
## 4743.127
cat('RegionB模型的RMSE：\n',RMSE(Model.B.All$fitted.values, DataRenewB$Sales),'\n',sep ='')
## RegionB模型的RMSE：
## 2057.058

#誤差：以MAPE衡量(Mean Absolute Percentage Error)
MAPE <- function( predict, actual){
  result <- mean(abs((predict - actual)/actual)) %>% round(3) * 100
  return(result)
}

cat('RegionA模型的MAPE：\n',MAPE(Model.A.All$fitted.values, DataRenewA$Sales),'%','\n',sep='')
## RegionA模型的MAPE：
## 7.8%
cat('RegionB模型的MAPE：\n',MAPE(Model.B.All$fitted.values, DataRenewB$Sales),'%','\n',sep='')
## RegionB模型的MAPE：
## 7.3%


#營收分析：Region A
#從beta coefficient的數值中，我們可以得知，在區域A中：

#百貨門市(AA)的表現較一般門市(BB)來得優異
#在各月份中，7月、12月和1月是表現較好的月份，也許和暑假、聖誕、跨年和過年等有關，對營收的影響和國定假日差不多
#Store1的百貨特別活動對營收有正面影響，但僅和週末的影響差不多
#值得注意的是，一般門市在假日時營收會略為下滑，推論為假日時人潮集中至百貨門市



#營收分析：Region B
#從beta coefficient的數值中，我們可以得知，在區域B中：

#百貨門市(AA)的表現較一般門市(BB)來得優異
#在各月份中，7月月和1月是明顯的旺季，對營收的影響甚至超過國定假日
#Store2的百貨促銷活動對營收有正面的影響，建議可以加強此時段的促銷配合
#值得注意的是，一般門市在假日時營收會明顯下滑，推論為商業區的一般門市在假日時有較少的來客，應針對此點進行改善


#營業目標及展店的營收估計
#在下一個年度的訂定每日或每週的營業目標時，能參考模型的預測，並將預測的誤差當作容許的範圍，以店1的一月份為例：

January <- tibble( 'Day' = c(1:31),
                   'Sales_Upperbound' = Model.A.All$fitted.values[1:31] * 1.08,
                   'Sales_Lowerbound' = Model.A.All$fitted.values[1:31] * 0.92)

ggplot( data = January)  +
  geom_segment(aes(x=Day, xend=Day, 
                   y=Sales_Upperbound, yend=Sales_Lowerbound)) +
  geom_point(  aes( x = Day,
                    y = Sales_Upperbound,
                    colour = "Upper")) +
  geom_point( aes( x = Day, 
                   y = Sales_Lowerbound,
                   colour = 'Lower')) + 
  labs( x = 'Day in January',
        y = 'Prediction Interval',
        title = 'Predicted Sales in January')
