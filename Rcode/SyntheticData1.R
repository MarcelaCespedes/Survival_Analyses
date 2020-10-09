##########################################################
# In a similar manner as 
# textbook (Applied survival Analysis Using R pg 77 Chapter 6) the code below generates synthetic 
# survival data for: 
#   N = 400 participants
#   event: is age to AD dementia
#   Age: between 60 to 95. As age increases so does the log-rate
#   simulated factor which affects time to AD is APOE (0 denote non-e4 allele carrier, 1 denotes e4 allele carrier)
#   Approximately 80% of the data is censored
#   
# Tuesday 6 October 2020
# Marcela Cespedes


rm(list = ls())
library(survival)
library(survminer)
library(dplyr)

set.seed(4456)

N <- 400
Age<- runif(n = N, min = 70, max = 95)

# APOE e4 allele carriers denoted by APOE == 1, non-carriers denoted by
# APOE == 0
APOE<- factor(c(rep(0, 200), rep(1, 200)), levels = c("0", "1"))
table(APOE) # This is 60% are APOE e4 allele non-carriers
            # and 40% are carriers


# survival variables will be exponentially distributed 
# with a rate parameter dependent on APOE 
#
# Set the log-rate parameter to be -4.5  (try -3)
# and set APOE e4 carriers log-rate parameter to be 2

log.rate.vec<- -3 + c(rep(0, 240), # non-carriers
                        rep(1.2, 160)) + # carriers
                        Age*0.05 

# put all together
dat<- data.frame(Age = Age,
                 APOE = APOE,
                 log.rate.vec = log.rate.vec)

# Now define exponential survival variables (times)
tt<- rexp(n = N, rate = exp(log.rate.vec))
#head(tt) 

dat<- mutate(dat, SurvivalTime = tt, 
        Age.start = Age, # age at time they commenced the study
        Age.end = tt + Age) # age at last follow-up

# randomise rows
dat<- dat[sample(1:dim(dat)[1], replace=FALSE),]


# simulate events, 80% censored 
dat<- mutate(dat, event.cens = sample(c(0,1), size = dim(dat)[1], 
                                      prob = c(0.8, 0.2),
                                      replace=TRUE))

table(dat$event.cens)

table(dat$event.cens, dat$APOE)


####  ------------------------------
####
#### Analyses
#### 
####  ------------------------------













### ----------------------------------------------
### Visualise data

# what is the age range?
summary(dat$Age.start) # all participant ages are > 59

summary(subset(dat, event.cens == 1)$Age) # events didn't start till
# age > 70

##
## Full data
km.op<- surv_fit(Surv(time = dat$Age.start,
                      time2 = dat$Age.end,
                      event = dat$event.cens,
                      type = "counting") ~ 1,
                 start.time = 59, data = dat)


x11()
ggsurvplot(km.op, data = dat, risk.table = TRUE, 
           xlim=c(70, 100),
           break.time.by=10) +
  xlab("Participant Age in years") + 
  ggtitle("Simulated data: Conditional on participants 
          being AD free to age 59")



##
## APOE status

km.apoe<- surv_fit(Surv(time = dat$Age.start,
                      time2 = dat$Age.end,
                      event = dat$event.cens,
                      type = "counting") ~ APOE,
                 start.time = 59, data = dat)


x11()
ggsurvplot(km.apoe, data = dat, risk.table = TRUE, 
           xlim=c(70, 100),
           break.time.by=10) +
  xlab("Participant Age in years") + 
  ggtitle("Simulated data: stratified by APOE status")







###
### Fit model

mdl1<- coxph(Surv(time = dat$Age.start,
                     time2 = dat$Age.end,
                     event = dat$event.cens,
                     type = "counting") ~ 
                  dat$APOE + dat$Age)
summary(mdl1)

# APOE e4 allele carriers are 1.8 times more likely to develope AD
# compared to non-carriers










