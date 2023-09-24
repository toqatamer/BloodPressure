# BloodPressure
Rstudio
1- Descriptive statistics
After reading the data “RData” file using load (), use str () function to return to return a list of objects and their structure, use summary function () to summarize the data frame all of those are used for:
• Identifying and exploring the data
• Knowing more information about columns data types
•Summarizing the data: calculating mean, median, minimum, maximum, first and third quartile 
•changing the values from 0 , 1 in gender to male and female using factor() function.
• Then using table() function to calculate frequency of categorical data “gender” 
• Then calculating correlation coefficient process between (bp. reduction and dose)
▪ For calculating correlation coefficient, there are 3 methods:
• "Pearson"/ "Spearman"/“Kendall"
Using pearson “default test its assumes normality ,homoscedasticity and non presence of outliers 
• The correlation coefficient (bp. reduction and dose) "Output: positive correlation/ strong correlation/ higher than 0.5 equals (0.8583306)"
3- Graphics
Bar chart a categorical variable for the gender was plotted to know which gender with the highest frequency. 
 “Number of Males (gender 1)> Number of Females (gender2)
Bar chart graph represents the frequency is higher in males or females . And it was found that the frequency of males was higher than 20 while frequency of females  was less than 20.
 

Then using aggregate function to find the mean of blood pressure reduction in both male and females  aggregate (bp.reduction ~ gender, BloodPressure, mean) ,We found that the mean in male was 8.681818 > the mean in females was 6.333333.
A histogram of a continuous variable: is used to know the spread and the normality of these variables 
From the graphs we can state that dose histogram seems to be not normal and bp.reduction seems to be a little normally distributed “bell shaped”
 
 
A scatter plot between the two continuous values “bp.reduction” and “dose” using plot() function then we used points() and abline() functions to fit the two regressionlines with respect to the gender “positive relationship”

 
A boxplot between blood pressure reduction and the 4 different doses ,the variation of different doses varies from one dose to another but we can state that dose 0 has highest variation and dose two has least variation.


 


Outlier detection
 
Making 3 boxplots the first is between “dose and gender” , the second between “bp.reduction and gender” and the third between “bp.reduction and dose” and saved the output in 3 variables box1 ,box2 and box3 to easily detect the outliers and there was no found outliers

Testing normality

To test normality we have 3 ways (histogram - Q-Q plot - Shapiro test)
Applying those tests to bp.reduction:
Histogram: seems to be a little normally distributed using hist() function
 
QQ-plot: Using plot() and qqline () functions
The plotted data seems to be fitted on the line 
 
Shapiro’s test: using Shapiro.test()
p-value= 0.806 which is > 0.05 so we can state that the data is normally distributed as we don’t have enough evidence to reject the normality.
Applying those tests to dose: 
Histogram: using hist() function the data seems not normally distributed
 
QQ-plot: using plot() and qqline() functions the points are clustered and some points(doses) and not regularly fitted on the line so it seems not normal
 

Shapiro’s test: using Shapiro.test()
P-value = 2.494e-05< 0.05 so we have enough evidence to reject normality and state the data isn’t normally distributed.
Testing homoscedasticity :

Using boxplots: It allows us to see whether the variance is equal or no and we can see in the following graphs that non of them have equal variance.
   


Using levene’s test :it assumes independence and doesn’t assume normality , we used it using leveneTest() function to test homoscedasticity between continuous vs categorical variables 
The first was bp.reduction with gender :
the f-value equals 1.8101 and the p-value equals 0.1865 >0.05 so we the data is homoscedasticity as we don’t have enough evidence to reject null hypothesis.
The second was dose with gender:
The f-value equals 0.0516 and the p-value equals 0.8215> 0.05 so the data is homoscedasticity as we don’t have enough evidence to reject null hypothesis.


Using var.test: It assumes normality and independence. We used var.test() function to test variance between two continuous groups “bp.reduction and dose”
The variance = 0.2315027 which is not equal to 1 so we can reject null hypothesis and state that they are heteroscedastic. P-value =1.304e-05<0.05 so we can reject null hypothesis and state that data is heteroscedastic.


Bartlett’s: assumes that the data are independent and has equal sample size. We used bartlett.test() to test homoscedasticity between continuous data and categorical “bp.reduction and gender “ and the p-value equals 0.1492 >0.05 so the data is homoscedastic ,also we used it to  between “dose and gender” and the p-value equals 0.8978 >0.05  so data is homoscedastic.





Confidence interval:
First we made a variable “dose levels” that contains all unique values of doses (0,2,5,10) then we made a for loop that loops on dose levels variable and calculates at confidence intervals with different percentages (90%,95%,99%) using t.test() function.
As the percentage increase the confidence interval increase.
For example in dose 10 the confidence interval at 0.9 was 14.4539911333169 - 20.5460088666831 and in 0.99 was 12.099881055551 - 22.900118944449.

If we requested a confidence higher than 0.99 the confidence interval will increase till it covers all the possible values.

Hypothesis testing:
First hypothesis
To test hypothesis we have 5 steps 
The first step: is transfer the research question into statistical question
Research question: is there a difference in blood pressure reduction between male and female in the group that received dose 0?
Statistical question :is the mean blood pressure reduction in male different from that in female in the group that received dose 0?
 
Second step: state null hypothesis and alternative hypothesis
Null hypothesis: The blood pressure reduction in male is the same as in female in the group that received dose 0.
Alternative hypothesis: The blood pressure reduction differs in males and females in the group that received dose 0.

Third step: Test statistics use the appropriate test to test this hypothesis after assuming normality and homoscedasticity we will use two-sample t-test.
First, we subset the placebo dose from the whole data and saved it in variable named dose_sub then we performed the two sample t-test on the data.

Fourth step: estimate the p-value “0.01679”

Fifth step: draw conclusion p-value <0.05 there for we don’t have enough evidence to reject null hypothesis so we can state now that the blood pressure reduction in male is the same as in female in the group that received dose 0.




Confirming the assumptions “normality and homoscedasticity”
We used Shapiro test , qqplot and histogram to test normality and the data was normally distributed 

For homoscedasticity we used bartlett and levene and var tests that stated the gender and bp.reduction is homoscedastic 



Second hypothesis:
First step: transfer the research question into statistical question.
Research question: Blood pressure reduction is higher in the group received dose 10 than those who received placebo 
Statistical question: The mean of blood pressure for the group received dose 10 is higher than those who received placebo.

Second step:
Null hypothesis: The mean of blood pressure of both groups are the same.
Alternative hypothesis: There is a significant difference between the blood pressure in the two groups. In dose 10 higher than dose 0

Third step: Test statistics use the appropriate test to test this hypothesis after assuming heteroscedasticity we will use two sample welch t test.
We took a subset of dose 0 and saved it in a variable named dose_0 and took another subset and saved it in a variable named dose_10 then made a the two sample welch t-test with variance equal false and alternative(two make it one sided) equals greater .

Fourth step: estimate the p-value which is equals 7.017e-08


Fifth step: draw conclusion p-value<0.05 there for we have enough evidence to reject null hypothesis and state that the blood pressure reduction of people who took dose 10 is higher than who took dose 0.



Confirming the assumptions “normality and homoscedasticity”
We used Shapiro test , qqplot and histogram to test normality and the data was normal 

For homoscedasticity we used var test and boxplot that stated the dose 0,10 and bp.reduction is homoscedastic 


We reused two sample t test but this time with variance = True “two sample t-test” the hypothesis conclusion didn’t change but the p-value became a little more significant.

Third hypothesis:
First step: transfer the research question into statistical question.
Research question: Blood pressure reduction is different between different doses.
Statistical question: Mean blood pressure reduction is different between different doses.

Second step: 
Null hypothesis: There is no significant difference in blood pressure reduction between different doses.
Alternative hypothesis: There is a significant difference between different doses.

Third step:
First testing normality using qqplot , histogram and Shapiro test and the data seems normally distributed 
Then by using levene test to test homoscedasticity and we didn’t have enough evidence to reject homoscedasticity.
So, we will use anova test 

Fourth and fifth steps:
The p-value is 7.71e-11 *** which is very high significant so we can reject null hypothesis and now we can state that there is a difference in blood pressure reduction between different doses.

Performing post-hoc test:
Using tukey test and it took the previous anova test results to test the difference between each two variables.

 


From the previous results we can see that all of the p-values are less than 0.05 except that of doses 5 and 2 
So, we can now state that there is different between different doses and each other in blood pressure reduction 
And for dose 5 and 2 there is no significant difference in blood pressure reduction of the two doses.
Linear model:

In the first model by taking the same data frame that contains the subset dose “placebo” “sub_dose” and performed a linear model using lm() function and then saving this data on data frame named FirstHypothesis we will find the following:
 

R- squared = 0.5312 which is 53.12%
The p-value is significant <0.05
Intercept = 2.2 and sloope equals -6.2 
Y=2.2 -6.2X
We have degree of freedom 8 as the sampled data was 10 so we made 10-2 .
 

The 0.95 confidence interval for intercept “bp.reduction” is from -1.157593 to 5.557593 and for both gender receiving dose 0 from -10.948353 -1.451647.








In the second model by taking the sampled data of blood pressure reduction in dose 0n and took another one of dose 10 and performed a linear model using lm() function and then saving this data on data frame named SecondHypothesis we will find the following:
 
R- squared = 0.7977 which is 79.77%
The p-value is very significant 
Intercept = -0.9 and slope equals 1.84
Y= -0.9+ 1.84X
Degree of freedom equals 18 as 20-2
 

The 0.95 confidence interval of the intercept “bp.reduction” is -4.144925 to 2.344925 and for the dose is 1.381098 to 2.298902





In the third model by taking all the sampled data and performed a linear model using lm() function and then saving this data on data frame named ThirdHypothesis we will find the following:

 
R- squared = 0.7387 which is 73.87%
The p-value is very significant 
Intercept = 0.03304 and slope = 1.78634
Y=0.03304 + 1.78634X
Degree of freedom equals 38 as 40-2

 



The 0.95 confidence interval of the intercept “bp.reduction” is -1.948188 2.014267 and for dose is 1.437469 2.135218



Using the third linear model which contains regression model between bp.reduction and dose then made a new data frame containing the new dose that we want to predict its bp.reduction value 
Using predict() function which took two parameters the old model and the new data frame and predicted the value of bp.reduction at 
