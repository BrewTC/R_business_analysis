# 1.1 R Data Types

# 1. Vectors

# Create a numeric vector
a <- c(1,2,5.3,6,-2,4)
print(a)

a <- 2:9
a

# Refer to elements of a vector using subscripts.
a[c(2,4)]

# Create a character vector
b <- c("one", "two", "three") 
b == "one"

b[b == "one"]


# 2. Matrices

# Create a matrix
M <- matrix(c('a','a','b','c','b','a'), nrow = 2, ncol = 3)
print(M)

# Create a matrix and fill in by row
M <- matrix( c('a','a','b','c','b','a'), nrow = 2, ncol = 3, byrow = TRUE)
print(M)

# Create an array
a <- array(c('green', 'yellow'), dim = c(3, 3, 2))
print(a)

# Matrix Manipulation
A <- matrix(c(1,2,3,4), nrow = 2, ncol = 2)
B <- matrix(c(1,1,2,2), nrow = 2, ncol = 2)

A
#      [,1] [,2]
# [1,]    1    3
# [2,]    2    4

B
#      [,1] [,2]
# [1,]    1    2
# [2,]    1    2

A * B
#矩陣相乘
A %*% B
#      [,1] [,2]
# [1,]    4    8
# [2,]    6   12

#矩陣轉置
t(A)
#      [,1] [,2]
# [1,]    1    2
# [2,]    3    4

#回傳反矩陣
solve(A)
#      [,1] [,2]
# [1,]   -2  1.5
# [2,]    1 -0.5


b <- c(1,1)
solve(A, b)
solve(A) %*% b #[1] -0.5  0.5


# 3. Lists

# Create a list.
list1 <- list(c(2,5,3), 21.3, sin)

# Print the list.
print(list1)
# [[1]]
# [1] 2 5 3

# [[2]]
# [1] 21.3

# [[3]]
# function (x)  .Primitive("sin")


# Create list and asign variable names.創建列表並查詢變數名稱
list2  <- list(vector = c(2,5,3),
numeric = 21.3,
func = sin)

# Print names of list and list itself.
#查詢變數名稱
names(list2) #"vector"  "numeric" "func"  
print(list2) 
# $vector
# [1] 2 5 3

# $numeric
# [1] 21.3

# $func
# function (x)  .Primitive("sin")



# 4. Factros

# Create a vector.
apple_colors <- c('green','green','yellow','red','red','red','green')

# Create a factor object.
factor_apple <- factor(apple_colors)

# Print the factor.
print(factor_apple) 
#[1] green  green  yellow red    red    red    green 
#Levels: green red yellow

print(nlevels(factor_apple)) #3


# 5. Data Frames

name <- c("David", "Hsi", "Jessie")
age <- c("24", "25", "36")
gender <- c("Male", "Male", "Female")

# Create by variables
data1 <- data.frame(name, age, gender)
data1
#     name age gender
# 1  David  24   Male
# 2    Hsi  25   Male
# 3 Jessie  36 Female


data2 <- data.frame(
  name = c("David", "Hsi", "Jessie"),
  age = c("24", "25", "36"),
  gender = c("Male", "Male", "Female")
)
data2
#     name age gender
# 1  David  24   Male
# 2    Hsi  25   Male
# 3 Jessie  36 Female

head(data2)
#     name age gender
# 1  David  24   Male
# 2    Hsi  25   Male
# 3 Jessie  36 Female

colnames(data2) <- c("Var_1", "Var_2","Var_3")
rownames(data2) <- c("1", "2", "3")
data2
#    Var_1 Var_2  Var_3
# 1  David    24   Male
# 2    Hsi    25   Male
# 3 Jessie    36 Female

summary(data2)
#     Var_1              Var_2              Var_3          
#  Length:3           Length:3           Length:3          
#  Class :character   Class :character   Class :character  
#  Mode  :character   Mode  :character   Mode  :character  