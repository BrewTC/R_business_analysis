# For-loop Intro
#cat()輸出結果
for (i in 1:5) {
  cat(i)
}
#12345

for (str in c("R", "Business", "Analiytics")) {
  cat(paste(str, "is super interesting!\n"))
}
#R is super interesting!
#Business is super interesting!
#Analiytics is super interesting!

# For loop for vector updating
n <- 10
sum.vec <- rep(1, n)

for (i in 2:n) {
  sum.vec[i] <- sum.vec[i - 1] + i
}

sum.vec
#[1]  1  3  6 10 15 21 28 36 45 55

# Break out a for loop
n <- 10
sum.vec <- rep(1, n)

for (i in 2:n) {
  sum.vec[i] <- sum.vec[i - 1] + i
  if (sum.vec[i] > 10) {
    cat("I'm outta here. I don't like numbers bigger than 10\n")
    break
  }
}

sum.vec

# Nested for loop
#巢狀for迴圈
for (i in 1:4) {
  for (j in 1:4) {
    cat(paste("(", i, ",", j, ")  "))
  }
  cat("\n")
}

for (i in 1:4) {
  for (j in 1:i^2) {
    cat(paste(j,""))
  }
  cat("\n")
}

# While loop
i <- 1

while(i < 5) {
  i <- i + 1
  cat(paste(i, "\n"))
}

# Repeated loop
repeat {
  ans = readline("Who is the most handsome guy? ")
  if (ans == "David") {
    cat("Yes! You get an 'A'.")
    break
  }
  else {
    cat("Wrong answer!\n")
  } 
}
