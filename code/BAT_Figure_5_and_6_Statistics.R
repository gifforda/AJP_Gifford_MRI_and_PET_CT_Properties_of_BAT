# ---------------------------------------------------------------------------------------------------------
# CODE FOR PERFORMING STATISTICAL TESTS FOR AJP BAT MANUSCRIPT
# This .R file contains the script to test for significant difference between the values plotted in Figures 5 and 6.
# The script reads the necessary csv files from the ../tidy_data/ folder.
# ---------------------------------------------------------------------------------------------------------

# Load CSV file into a data frame
fullData = read.csv('../tidy_data/PET_Positive_BAT_tidy_data.csv')
watData = read.csv('../tidy_data/PET_Positive_WAT_tidy_data.csv')

# ---------------------------------------------------------------------------------------------------------
# Separate into CA and TN data

sub_CA = fullData[, "Scan_Temp"]=="CA"
CAData = fullData[sub_CA ,]

sub_TN = fullData[, "Scan_Temp"]=="TN"
TNData = fullData[sub_TN ,]

WAT_sub_CA = watData[, "Temp"]=="CA"
WAT_CAData = watData[WAT_sub_CA ,]

WAT_sub_TN = watData[, "Temp"]=="TN"
WAT_TNData = watData[WAT_sub_TN ,]

# ---------------------------------------------------------------------------------------------------------
# Separate into Low and High BMI data

rows_Lbmi_TN  = TNData[,"BMI"]<25
LowB_Data_TN  = TNData[rows_Lbmi_TN ,]
rows_Lbmi_CA  = CAData[,"BMI"]<25
LowB_Data_CA  = CAData[rows_Lbmi_CA ,]

rows_Hbmi_TN   = TNData[,"BMI"]>=25
HighB_Data_TN  = TNData[rows_Hbmi_TN ,]
rows_Hbmi_CA   = CAData[,"BMI"]>=25
HighB_Data_CA  = CAData[rows_Hbmi_CA ,]

# ---------------------------------------------------------------------------------------------------------
All_FSF_Mean = fullData[,"FSF_Mean"]
TN_FSF_Mean = TNData[,"FSF_Mean"]
CA_FSF_Mean = CAData[,"FSF_Mean"]
TN_FSF_Mean_lowB = LowB_Data_TN[, "FSF_Mean"]
CA_FSF_Mean_lowB = LowB_Data_CA[, "FSF_Mean"]
TN_FSF_Mean_highB = HighB_Data_TN[, "FSF_Mean"]
CA_FSF_Mean_highB = HighB_Data_CA[, "FSF_Mean"]

TN_WAT_FSF_Mean = WAT_TNData[,"FSF_Mean"]
CA_WAT_FSF_Mean = WAT_CAData[,"FSF_Mean"]

# ---------------------------------------------------------------------------------------------------------
All_CT_Mean = fullData[,"CT_Mean"]
TN_CT_Mean = TNData[,"CT_Mean"]
CA_CT_Mean = CAData[,"CT_Mean"]
TN_CT_Mean_lowB = LowB_Data_TN[, "CT_Mean"]
CA_CT_Mean_lowB = LowB_Data_CA[, "CT_Mean"]
TN_CT_Mean_highB = HighB_Data_TN[, "CT_Mean"]
CA_CT_Mean_highB = HighB_Data_CA[, "CT_Mean"]

TN_WAT_CT_Mean = WAT_TNData[,"CT_Mean"]
CA_WAT_CT_Mean = WAT_CAData[,"CT_Mean"]

# ---------------------------------------------------------------------------------------------------------
All_PET_Mean = fullData[,"PET_Mean"]
TN_PET_Mean = TNData[,"PET_Mean"]
CA_PET_Mean = CAData[,"PET_Mean"]
TN_PET_Mean_lowB = LowB_Data_TN[, "PET_Mean"]
CA_PET_Mean_lowB = LowB_Data_CA[, "PET_Mean"]
TN_PET_Mean_highB = HighB_Data_TN[, "PET_Mean"]
CA_PET_Mean_highB = HighB_Data_CA[, "PET_Mean"]

# ---------------------------------------------------------------------------------------------------------
All_R2s_Mean = fullData[, "R2s_Mean"]
TN_R2s_Mean = TNData[, "R2s_Mean"]
CA_R2s_Mean = CAData[, "R2s_Mean"]
TN_R2s_Mean_lowB = LowB_Data_TN[, "R2s_Mean"]
CA_R2s_Mean_lowB = LowB_Data_CA[, "R2s_Mean"]
TN_R2s_Mean_highB = HighB_Data_TN[, "R2s_Mean"]
CA_R2s_Mean_highB = HighB_Data_CA[, "R2s_Mean"]

TN_WAT_R2s_Mean = WAT_TNData[,"R2s_Mean"]
CA_WAT_R2s_Mean = WAT_CAData[,"R2s_Mean"]

# ---------------------------------------------------------------------------------------------------------
# Test for Normality first: - ALL Subjects

# TESTING - FSF
shapiro.test(TN_FSF_Mean)
qqnorm(TN_FSF_Mean)
hist(TN_FSF_Mean)

shapiro.test(CA_FSF_Mean)
qqnorm(CA_FSF_Mean)
hist(CA_FSF_Mean)

# TESTING - R2*
shapiro.test(TN_R2s_Mean)
qqnorm(TN_R2s_Mean)
hist(TN_R2s_Mean)

shapiro.test(CA_R2s_Mean)
qqnorm(CA_R2s_Mean)
hist(CA_R2s_Mean)

# TESTING - HU
shapiro.test(TN_CT_Mean)
qqnorm(TN_CT_Mean)
hist(TN_CT_Mean)

shapiro.test(CA_CT_Mean)
qqnorm(CA_CT_Mean)
hist(CA_CT_Mean)

# TESTING - SUV
shapiro.test(TN_PET_Mean)
qqnorm(TN_PET_Mean)
hist(TN_PET_Mean)

shapiro.test(CA_PET_Mean)
qqnorm(CA_PET_Mean)
hist(CA_PET_Mean)


# ---------------------------------------------------------------------------------------------------------
# Wilcoxon Signed Rank Test:

# BAT - Thermoneutral vs. Cold -
# HU / SUV / FSF / R2* for:
# All Subjects:
wilcox.test(TN_CT_Mean, CA_CT_Mean, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
wilcox.test(TN_PET_Mean, CA_PET_Mean, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
wilcox.test(TN_FSF_Mean, CA_FSF_Mean, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
wilcox.test(TN_R2s_Mean, CA_R2s_Mean, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
# Low BMI
wilcox.test(TN_CT_Mean_lowB, CA_CT_Mean_lowB, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
wilcox.test(TN_PET_Mean_lowB, CA_PET_Mean_lowB, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
wilcox.test(TN_FSF_Mean_lowB, CA_FSF_Mean_lowB, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
wilcox.test(TN_R2s_Mean_lowB, CA_R2s_Mean_lowB, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
# High BMI
wilcox.test(TN_CT_Mean_highB, CA_CT_Mean_highB, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
wilcox.test(TN_PET_Mean_highB, CA_PET_Mean_highB, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
wilcox.test(TN_FSF_Mean_highB, CA_FSF_Mean_highB, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)
wilcox.test(TN_R2s_Mean_highB, CA_R2s_Mean_highB, mu=0, alt="two.sided", paired=T, conf.int=T, conf.level=0.95)

# WAT vs BAT - Wilcoxon RANK SUM test - unpaired data
# All Subjects -- WARM 
wilcox.test(TN_CT_Mean, TN_WAT_CT_Mean, mu=0, alt="two.sided", paired=F, conf.int=T, conf.level=0.95, exact=T)
wilcox.test(TN_FSF_Mean, TN_WAT_FSF_Mean, mu=0, alt="two.sided", paired=F, conf.int=T, conf.level=0.95, exact=T)
wilcox.test(TN_R2s_Mean, TN_WAT_R2s_Mean, mu=0, alt="two.sided", paired=F, conf.int=T, conf.level=0.95, exact=T)
# All Subjects -- COLD
wilcox.test(CA_CT_Mean, CA_WAT_CT_Mean, mu=0, alt="two.sided", paired=F, conf.int=T, conf.level=0.95, exact=T)
wilcox.test(CA_FSF_Mean, CA_WAT_FSF_Mean, mu=0, alt="two.sided", paired=F, conf.int=T, conf.level=0.95, exact=T)
wilcox.test(CA_R2s_Mean, CA_WAT_R2s_Mean, mu=0, alt="two.sided", paired=F, conf.int=T, conf.level=0.95, exact=T)
