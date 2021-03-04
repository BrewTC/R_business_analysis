# Create Data Frame
df <- data.frame(
  a = rnorm(10), # Generate 10 standard normal random numbers
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

# Normalize the Data
#$選取
#na.rm = TRUE 排除缺失值
df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
# [1] 0.44245611 0.35521766 0.78000939 0.61096247 0.21800199 0.78881907 1.00000000 0.05514996 0.17447668 0.00000000
df$b <- (df$b - min(df$b, na.rm = TRUE)) / 
  (max(df$b, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$c <- (df$c - min(df$c, na.rm = TRUE)) / 
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))
df$d <- (df$d - min(df$d, na.rm = TRUE)) / 
  (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))


# Create Data Frame
df <- data.frame(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

# Create User-defined Function
#自訂義函式
#range(向量)，會回傳c(向量最小值,向量最大值)
RescaleByRange <- function(x){
  rng <- range(x, na.rm = TRUE)
  return((x - rng[1]) / (rng[2] - rng[1]))
}

(df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))

RescaleByRange(df$a)
#[1] 0.44245611 0.35521766 0.78000939 0.61096247 0.21800199 0.78881907 1.00000000 0.05514996 0.17447668 0.00000000

# Exercise
SummarizeData <- function(x){
  # Computes the summary statistics of a vector.
  #
  # Args:
  #   x: the vector you want whose summary statistics is calculated.
  #
  # Returns:
  #   A data frame with the mean, variance, maximum, minumum, and median of x.
  summary.df <- data.frame(x_mean = mean(x, na.rm = TRUE),
                           x_var = var(x, na.rm = TRUE),
                           x_max = max(x, na.rm = TRUE),
                           x_min = min(x, na.rm = TRUE),
                           x_median = median(x, na.rm = TRUE))
  return(summary.df)
}

SummarizeData(rnorm(10))