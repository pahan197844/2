refine_original=read.csv("refine.csv")
summary(refine_original)
library(dplyr)

#Clean up brand names
as.data.frame(refine_original)
refine_original$company
refine_original$company[refine_original$company=="Phillips"] <- "philips"
refine_original$company[refine_original$company=="fillips"] <- "philips"
refine_original$company[refine_original$company=="philips"] <- "philips"
refine_original$company[refine_original$company=="phllips"] <- "philips"
refine_original$company[refine_original$company=="phillipS"] <- "philips"
refine_original$company[refine_original$company=="phillps"] <- "philips"
refine_original$company[refine_original$company=="phlips"] <- "philips"
refine_original$company[refine_original$company=="Akzo"] <- "akzo"
refine_original$company[refine_original$company=="akz0"] <- "akzo"
refine_original$company[refine_original$company=="ak zo"] <- "akzo"
refine_original$company[refine_original$company=="AKZO"] <- "akzo"
refine_original$company[refine_original$company=="Van Houten"] <- "van houten"
refine_original$company[refine_original$company=="van Houten"] <- "van houten"
refine_original$company[refine_original$company=="unilver"] <- "unilever"
refine_original$company[refine_original$company=="Unilever"] <- "unilever"

#Separate the product code and product number into separate columns i.e. 
#add two new columns called product_code and product_number, 
#containing the product code and number respectively
library(tidyr)
refine = separate(refine_original, Product.code...number, c("product_code","product_number", sep="-"))

#Add product categories
names = c("Smartphone","TV","Laptop","Tablet")
refine$product_code[refine$product_code=="p"] <- names[1]
refine$product_code[refine$product_code=="v"] <- names[2]
refine$product_code[refine$product_code=="x"] <- names[3]
refine$product_code[refine$product_code=="q"] <- names[4]

#Add full address for geocoding
full_address <- as.character(paste(refine$address, 
                                   refine$city, refine$country, sep = ","))
refine$full_address <- full_address

refine$company_philips <-    as.numeric(refine$company == "philips")
refine$company_akzo <-       as.numeric(refine$company == "akzo")
refine$company_van_houten <- as.numeric(refine$company == "van houten")
refine$company_unilever <-   as.numeric(refine$company == "unilever")
refine$product_smartphone <- as.numeric(refine$product_code == "Smartphone")
refine$product_tv <-         as.numeric(refine$product_code == "TV")
refine$product_laptop <-     as.numeric(refine$product_code == "Laptop")
refine$product_tablet <-     as.numeric(refine$product_code == "Tablet")

#saving data
refine_clean <- refine
write.csv(refine_clean, "refine_clean.csv")
