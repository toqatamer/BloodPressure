#Data Reading


install.packages("car")


load("BloodPressure.RData")


str(BloodPressure)



#Descriptive Statistics


summary (BloodPressure)


#mean, median, minimum, maximum, first and third quartile  for  dose


mean(BloodPressure$dose ,na.rm=TRUE)


median(BloodPressure$dose ,na.rm=TRUE)




min(BloodPressure$dose ,na.rm=TRUE)


max(BloodPressure$dose ,na.rm=TRUE)

quantile(BloodPressure$dose ,na.rm=TRUE,c(0.25,0.75))


#mean, median, minimum, maximum, first and third quartile  for  bp.reduction


mean(BloodPressure$bp.reduction ,na.rm=TRUE)


median(BloodPressure$bp.reduction ,na.rm=TRUE)


min(BloodPressure$bp.reduction ,na.rm=TRUE)


max(BloodPressure$bp.reduction ,na.rm=TRUE)

quantile(BloodPressure$bp.reduction ,na.rm=TRUE,c(0.25,0.75))


#calculate a frequency table 

BloodPressure$gender<-factor(BloodPressure$gender,labels=c("male","female"))
table(BloodPressure$gender)
#BloodPressure$dose<-factor(BloodPressure$dose ,labels=c('0','2','5','10'))

#Calculate the correlation 

cor(BloodPressure$dose, BloodPressure$bp.reduction, use = "complete.obs")



#graphs


#Generate a bar chart of a categorical variable for the gender.

barplot(table(BloodPressure$gender), xlab="gender",ylab="Frequency", col = c("blue","pink"),main = "Barchart")
mean_bp.reduction <- aggregate(bp.reduction ~ gender, BloodPressure, mean)
#Generate a bar chart graph with mean bp.reduction in  males and females
barplot(mean_bp.reduction$bp.reduction,  xlab = "gender", ylab = "Mean bp.reduction",main = "Bar chart of Mean bp.reduction by gender", col = c("blue", "pink"))
#Make a histogram of a continuous variable “Dose”, “bp.reduction”.

hist(BloodPressure$dose , xlab = "dose", ylab = "Frequency",main = "Histogram of dose ",col= "violet" )
hist(BloodPressure$bp.reduction,  xlab = "bp.reduction", ylab = "Frequency",main = "Histogram of bp.reduction " ,col = c("pink"))
#Make a scatterplot of 2 continuous variables Dose and bp.reduction, and add the regression lines for each gender
# Separate the dataset by gender
plot(BloodPressure$dose,BloodPressure$ bp.reduction , main = "Scatter Plot",xlab = "dose", ylab = "bp.reduction", frame = FALSE) 

points(BloodPressure$dose[BloodPressure$gender=="female"],BloodPressure$bp.reduction[BloodPressure$gender=="female"],col=2)
points(BloodPressure$dose[BloodPressure$gender=="male"],BloodPressure$bp.reduction[BloodPressure$gender=="male"],col=4)
#Regression Lines
abline(lm(BloodPressure$dose[BloodPressure$gender=="female"] ~ BloodPressure$bp.reduction[BloodPressure$gender=="female"]),col=2)
abline(lm(BloodPressure$dose[BloodPressure$gender=="male"] ~ BloodPressure$bp.reduction[BloodPressure$gender=="male"]),col=4)

# Make a box-plot of age and a separate box-plots
boxplot(bp.reduction~dose,data=BloodPressure,main="Boxplot per doses" , col = c("beige"))
#checking for outliers:
box1=boxplot(dose~gender,data=BloodPressure,main="Boxplot per gender", col = c("blue","pink"))
box1$out

box2=boxplot(bp.reduction~gender,data=BloodPressure,main="Boxplot per gender", col = c("blue","pink"))
box2$out

box3=boxplot(bp.reduction~dose,data=BloodPressure,main="Boxplot per dose",col= c("beige"))
box3$out
#there is no found outliers
# check for the normality using two methods:

# we have several tests that can check for normality(histogram - Q-Q plot - Shapiro test)

#first test:histogram

hist(BloodPressure$bp.reduction, main="Histogram of bp.reduction",col =("pink"))
#second test(Q-Q plot)

qqnorm(BloodPressure$bp.reduction, main="QQ plot of bp.reduction",col=("red"))

qqline(BloodPressure$bp.reduction,col=("blue"))
#third test(shapiro)

shapiro.test(BloodPressure$bp.reduction)

#checking normallity of dose

hist(BloodPressure$dose, main="Histogram of dose",col =("violet"))
#second test(Q-Q plot)

qqnorm(BloodPressure$dose, main="QQ plot of dose",col=("red"))

qqline(BloodPressure$dose,col=("blue"))
#third test(shapiro)

shapiro.test(BloodPressure$dose)

#checking for Homoscedasticity :



#Bartlett's test:

bartlett.test(BloodPressure$bp.reduction ~ BloodPressure$gender)
bartlett.test(BloodPressure$dose ~ BloodPressure$gender)


#ftest by var.test
var.test(BloodPressure$dose,BloodPressure$bp.reduction)
#check by boxplot
boxplot(dose~gender,data=BloodPressure,main="Boxplot per gender", col = c("blue","pink"))
boxplot(bp.reduction~gender,data=BloodPressure,main="Boxplot per gender", col = c("blue","pink"))
boxplot(bp.reduction~dose,data=BloodPressure,main="Boxplot per dose",col= c("beige"))


#levene's test
library(car)
leveneTest(bp.reduction ~ gender ,BloodPressure)
leveneTest(dose ~ gender ,BloodPressure)
# Calculate the confidence intervals for bp.reduction means per each Dose

dose_levels <- unique(BloodPressure$dose) # Get unique levels of Dose variable
for (dose in dose_levels) {bp_reductions <- BloodPressure$bp.reduction[BloodPressure$dose == dose] 
# Subset bp.reduction values for current dose level


cat(paste0("Dose ", dose, ":\n"))


cat(paste0("Mean: ", mean(bp_reductions), "\n"))

cat(paste0("90% CI: ", t.test(bp_reductions, conf.level = 0.9)$conf.int[1], " - ", t.test(bp_reductions, conf.level = 0.9)$conf.int[2], "\n"))

cat(paste0("95% CI: ", t.test(bp_reductions, conf.level = 0.95)$conf.int[1], " - ", t.test(bp_reductions, conf.level = 0.95)$conf.int[2], "\n"))


cat(paste0("99% CI: ", t.test(bp_reductions, conf.level = 0.99)$conf.int[1], " - ", t.test(bp_reductions, conf.level = 0.99)$conf.int[2], "\n\n"))


}

t.test(BloodPressure$bp.reduction[BloodPressure$dose == "0"], conf.level = 0.9)
t.test(BloodPressure$bp.reduction[BloodPressure$dose == "0"], conf.level = 0.95)
t.test(BloodPressure$bp.reduction[BloodPressure$dose == "0"], conf.level = 0.99)

t.test(BloodPressure$bp.reduction[BloodPressure$dose == "2"], conf.level = 0.9)
t.test(BloodPressure$bp.reduction[BloodPressure$dose == "2"], conf.level = 0.95)
t.test(BloodPressure$bp.reduction[BloodPressure$dose == "2"], conf.level = 0.99)

t.test(BloodPressure$bp.reduction[BloodPressure$dose == "5"], conf.level = 0.9)
t.test(BloodPressure$bp.reduction[BloodPressure$dose == "5"], conf.level = 0.95)
t.test(BloodPressure$bp.reduction[BloodPressure$dose == "5"], conf.level = 0.99)

t.test(BloodPressure$bp.reduction[BloodPressure$dose == "10"], conf.level = 0.9)
t.test(BloodPressure$bp.reduction[BloodPressure$dose == "10"], conf.level = 0.95)
t.test(BloodPressure$bp.reduction[BloodPressure$dose == "10"], conf.level = 0.99)
dose10<- BloodPressure$bp.reduction[BloodPressure$dose == "10"]
dose10<- lm(bp.reduction ~ dose == "10", data = BloodPressure)

confint(dose10,level=0.9)
confint(dose10,level=0.95)
confint(dose10,level=0.99)
dose5<- lm(bp.reduction ~ dose == "5", data = BloodPressure)
confint(dose5,level=0.9)
confint(dose5,level=0.95)
confint(dose5,level=0.99)
dose0<- lm(bp.reduction ~ dose == "0", data = BloodPressure)
confint(dose0,level=0.9)
confint(dose0,level=0.95)
confint(dose0,level=0.99)
dose2<- lm(bp.reduction ~ dose == "2", data = BloodPressure)
confint(dose2,level=0.9)
confint(dose2,level=0.95)
confint(dose2,level=0.99)
#####################

dose_sub <- subset(BloodPressure, dose == "0")
t.test(bp.reduction ~ gender, data = dose_sub, var.equal = TRUE)

#p-value<0.05 that means we have significant differance and we can reject null hypothesis so there is a differnce between males and females in bp.reduction

#test the assumption for first hypothesis
qqnorm(dose_sub[dose_sub$gender == "male",]$bp.reduction, main='male bp.reduction',col = "blue")
qqline(dose_sub[dose_sub$gender == "male",]$bp.reduction , col ="red")
shapiro.test(dose_sub[dose_sub$gender == "male",]$bp.reduction)
hist(dose_sub[dose_sub$gender == "male",]$bp.reduction,col="blue")
#after checking normality between male and bp.reduction for those who recieved dose 0 data seems to be normally distibuted

qqnorm(dose_sub[dose_sub$gender == "female",]$bp.reduction, main='female bp.reduction',col= "blue")
qqline(dose_sub[dose_sub$gender == "female",]$bp.reduction, col= "red")
shapiro.test(dose_sub[dose_sub$gender == "female",]$bp.reduction)
hist(dose_sub[dose_sub$gender == "female",]$bp.reduction,col = "pink")
#after checking normality between female and bp.reduction for those who recieved dose 0 data seems to be normally distibuted

leveneTest(bp.reduction ~gender , dose_sub)
bartlett.test(bp.reduction ~gender  , dose_sub)
var.test(bp.reduction ~gender , dose_sub)
# bartlett and levene and var tests stated that the gender and bp.reduction is homoscedastic as we cant rejcect null hypothesis
boxplot(bp.reduction ~ gender , dose_sub, col = c("blue", "pink"))
#after visualising the data with boxplot we are able to state its homoscedastic


#second hypothesis 
dose2_subset<- subset(BloodPressure, dose == 10)
dose0_10<- rbind(dose_sub , dose2_subset)
t.test(bp.reduction ~ dose, data = dose0_10, var.equal = FALSE,  alternative = "less")

dose_0 <- BloodPressure$bp.reduction[BloodPressure$dose == "0"]
dose_10 <- BloodPressure$bp.reduction[BloodPressure$dose == "10"]
t.test(dose_10 , dose_0, var.equal = FALSE,alternative = "greater")

#p-value<0.05 there is a significant diferrence so we can reject null hypothesis and there is a diferrence between dose 0 and 10


#testing assumption

qqnorm(dose_0, main='dose 0 bp.reduction',col="blue")
qqline(dose_0, col = "red")#seems normal
shapiro.test(dose_0)#cant reject normality
hist(dose_0, col ="white")


qqnorm(dose_10, main='dose 10 bp.reduction',col="blue")
qqline(dose_10, col="red")
shapiro.test(dose_10)#cant reject normality
hist(dose_10,col = "grey")#seems normal
#data is normally distributed for dose 0 and 10
boxplot(dose_10,dose_0, col = c("grey","white"))
var.test(dose_10,dose_0)#p-value >0.05 so we dont have enough evidence to reject null hypothesis
#according to the varTest data is homoscedastic

t.test(dose_10 ,dose_0 ,var.equal = T ,  alternative = "greater")
#p-value is still smaller than 0.05 so its still significant but it's value decreased after assuming its homoscedasticty 

#Third hypothesis
#QQPLOT for dose0
qqnorm(BloodPressure[BloodPressure$dose == "0",]$bp.reduction, main='0 bp.reduction', col="blue")
qqline(BloodPressure[BloodPressure$dose == "0",]$bp.reduction,col= "red")
#near to the line 

#QQPLOT for dose 2
qqnorm(BloodPressure[BloodPressure$dose == "2",]$bp.reduction, main='2 bp.reduction', col="blue")
qqline(BloodPressure[BloodPressure$dose == "2",]$bp.reduction,col="red")
#containig one very far residual from the line but the other are fitted
#QQPLOT for dose 5
qqnorm(BloodPressure[BloodPressure$dose == "5",]$bp.reduction, main='5 bp.reduction',col= "blue")
qqline(BloodPressure[BloodPressure$dose == "5",]$bp.reduction,col="red")
#almost near to the line

#QQPLOT for dose 10
qqnorm(BloodPressure[BloodPressure$dose == "10",]$bp.reduction, main='10 bp.reduction',col="blue")
qqline(BloodPressure[BloodPressure$dose == "10",]$bp.reduction, col= "red")
#contains many far residuals 

hist(BloodPressure[BloodPressure$dose == "0",]$bp.reduction, main='dose 0', col= "white")#Biomodal
hist(BloodPressure[BloodPressure$dose == "2",]$bp.reduction, main='dose 2', col="beige")#seems not normally ditributed
hist(BloodPressure[BloodPressure$dose == "5",]$bp.reduction, main='dose 5', col= "light blue")#seems not normally distributed
hist(BloodPressure[BloodPressure$dose == "10",]$bp.reduction, main='dose 10', col = "grey")#seems normal

# shapiro test for dose 0
shapiro.test(BloodPressure[BloodPressure$dose == "0",]$bp.reduction) 
#p value = 0.6143 >0.05 so we dont have enough evidence to reject null hypothesis

# shapiro test for dose 2
shapiro.test(BloodPressure[BloodPressure$dose == "2",]$bp.reduction) 
#p value = 0.7578> 0.05 so we dont have enough evidence to reject null hypothesis

# shapiro test for dose 5
shapiro.test(BloodPressure[BloodPressure$dose == "5",]$bp.reduction) 
#p value = 0.7623> 0.05 so we dont have enough evidence to reject null hypothesis

# shapiro test for dose 10
shapiro.test(BloodPressure[BloodPressure$dose == "10",]$bp.reduction) 
#p value = 0.7763> 0.05 so we dont have enough evidence to reject null hypothesis

library(car)
leveneTest(bp.reduction~factor(dose), data = BloodPressure)
#p-value equals 0.426 >0.05 so we dont have enough evidence to reject homoscedasticity

model <- aov(bp.reduction ~ as.factor(dose), data = BloodPressure)
summary(model)
#p-value<0.05 and is very signifcant so we can reject null hypothesis and bp.reduction is diferent between diferrent doses

TukeyHSD(model)


#linear regression
FirstHypothsis <- lm(bp.reduction ~ gender , data = dose_sub)
dose_sub$gender<- as.numeric(dose_sub$gender)
summary(FirstHypothsis)
anova(FirstHypothsis)
confint(FirstHypothsis, level = 0.95)
plot( dose_sub$gender, dose_sub$bp.reduction,col= "blue")
abline(FirstHypothsis, lwd=5, col="red")
str(dose_sub)

dose2_subset<- subset(BloodPressure, dose == 10)
dose0_10<- rbind(dose_sub , dose2_subset)
SecondHypothsis <- lm(bp.reduction ~ dose, data = dose0_10)
summary(SecondHypothsis)
anova(SecondHypothsis)
confint(SecondHypothsis, level = 0.95)
plot(dose0_10$dose, dose0_10$bp.reduction,col= "blue")
abline(SecondHypothsis, lwd=5, col="red")

ThirdHypothsis <- lm(bp.reduction ~ dose, data = BloodPressure)
summary(ThirdHypothsis)
anova(ThirdHypothsis)
confint(ThirdHypothsis, level = 0.95)

plot(BloodPressure$dose, BloodPressure$bp.reduction,col= "blue")
abline(ThirdHypothsis, lwd=5, col="red")

str(BloodPressure)

# Predict the average blood pressure reduction for a dose of 3mg/day
newdata <- data.frame(dose = 3)
pred <- predict(ThirdHypothsis, newdata)

# Print the estimated average blood pressure reduction
cat("The estimated average blood pressure reduction for a dose of 3mg/day is", pred)
pred

