Vec_N1 <- c(100, 200, 300, 400, 500)  # numeric vector
Vec_N2 <- c(10, 20, 30, 40, 50)  # numeric vector
Vec_CH <- c("a", "b", "c", "d", "e")  # character vector
Vec_Logic <- c(TRUE, FALSE, TRUE, TRUE, TRUE)  # logical vector
Vec_N3 <- c(1,2,3,4,5)
df = data.frame(Vec_N1, Vec_N2, Vec_CH)   # df is a data frame
# Print the summary.
print(summary(df))  
# Extract Specific columns.
result1 <- data.frame(df$Vec_N1)
print(result1)
# Extract first two rows.
result2 <- df[1:2,]
print(result2)
# Extract 2rd and 5th row with 2nd and 3th column.
result3 <- df[c(2,5),c(2,3)]
print(result3)

