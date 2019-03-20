rm(list=ls()) 
gc()
Vec_N1 <- c(100, 200, 300, 400, 500)  # numeric vector
Vec_N2 <- c(10, 20, 30, 40, 50)  # numeric vector
Vec_CH <- c("a", "b", "c", "d", "e")  # character vector
Vec_Logic <- c(TRUE, FALSE, TRUE, TRUE, TRUE)  # logical vector
list1 <- list(Vec_N1,Vec_N2)
# Give names to the elements in the list.
names(list1) <- c("Vector1", "Vector2")$
# Print the list.
print(list1)
print(list1[1])
print(list1[[1]])
# Access the list element using the name of the element.
print(list1$Vector1)
print(list1$Vector1[1])
list2 <- list(Vec_CH,Vec_Logic)
names(list2) <- c("Vector CH", "Vector Logic")
# Print the list.
print(list1)
print(list1[1])
print(list1[[1]])
print(list1[1][2])
#merge two lists:
list3 <- c(list1,list2)
print(list3)
# Convert the lists to vectors.
v3 <- unlist(list3)
print(v3)

