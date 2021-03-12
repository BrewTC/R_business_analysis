# Boolean Operator
3 > 5
#[1] FALSE
6 > 5
#[1] TRUE

# And
#&每一個元素個別做比較
#&&只要有一個不滿足就會輸出FALSE
set.seed(0)
x <- runif(8, -1, 1)
x
0 <= x & x <= 0.5 # Elementwise AND
0 <= x && x <= 0.5 # Lazy AND
x[0 <= x & x <= 0.5] <- 999 # Elementwise AND
x

# Or
#|每一個元素個別做比較
#||只要有一個滿足就會輸出TRUE
x <- runif(8, -1, 1)
x

-0.5 >= x | x >= 0.5 # Elementwise OR
-0.5 >= x || x >= 0.5 # Lazy AND
x[-0.5 >= x | x >= 0.5] <- 999 # Elementwise AND
x

# If and Else
x <- 1
if (x > 0) {
  y <- 5
} else {
  y <- 10
}
y 
#[1] 5

# ifelse function
#ifelse(x > 0, if, else)
y <- ifelse(x > 0, 5, 10)
y 
#[1] 5

# Switch
switch("first", first = 1 + 1, second = 1 + 2, third = 1 + 3)
#[1] 2
switch("second", first = 1 + 1, second = 1 + 2, third = 1 + 3)
#[1] 3
switch("third", first = 1 + 1, second = 1 + 2, third = 1 + 3)
#[1] 4
