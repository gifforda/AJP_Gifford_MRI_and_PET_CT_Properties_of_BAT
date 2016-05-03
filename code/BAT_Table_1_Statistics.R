# ---------------------------------------------------------------------------------------------------------
# CODE FOR PERFORMING STATISTICAL TESTS FOR AJP BAT MANUSCRIPT
# This .R file contains the script to test for significant difference between the subject demographic data presented in Table 1.
# The script reads the necessary csv files from the ../tidy_data/ folder.
# ---------------------------------------------------------------------------------------------------------

# Load CSV file into a data frame
fullData = read.csv('../tidy_data/PET_Positive_BAT_tidy_data.csv')
# ---------------------------------------------------------------------------------------------------------

# Separate data into Low BMI and High BMI

rows_Lbmi  = fullData[,"BMI"]<25
LowB_Data  = fullData[rows_Lbmi ,]
rows_Hbmi  = fullData[,"BMI"]>=25
HighB_Data  = fullData[rows_Hbmi ,]
# ---------------------------------------------------------------------------------------------------------

# Create vectors of Low and High BMI data

Age_low  = LowB_Data[, "Age_yr"]
Age_high = HighB_Data[, "Age_yr"]

Height_low  = LowB_Data[, "Height_cm"]
Height_high = HighB_Data[, "Height_cm"]

Weight_low  = LowB_Data[, "Weight_kg"]
Weight_high = HighB_Data[, "Weight_kg"]

BMI_low  = LowB_Data[, "BMI"]
BMI_high = HighB_Data[, "BMI"]

Waist_low  = LowB_Data[, "Waist_cm"]
Waist_high = HighB_Data[, "Waist_cm"]
# ---------------------------------------------------------------------------------------------------------

# Mann-Whitney U Test (also known as the Wilcoxon Rank Sum Test)

wilcox.test(Age_low, Age_high, mu=0, alternative="two.sided",conf.int=T, conf.level=0.95, paired=FALSE, correct=T)

wilcox.test(Height_high, Height_low, mu=0, alternative="greater",conf.int=T, conf.level=0.95, paired=FALSE, exact=F, correct=T)

wilcox.test(Weight_high, Weight_low, mu=0, alternative="greater",conf.int=T, conf.level=0.95, paired=FALSE, exact=F, correct=T)

wilcox.test(BMI_high, BMI_low, mu=0, alternative="greater",conf.int=T, conf.level=0.95, paired=FALSE, exact=F, correct=T)

wilcox.test(Waist_high, Waist_low, mu=0, alternative="greater",conf.int=T, conf.level=0.95, paired=FALSE, exact=F, correct=T)

