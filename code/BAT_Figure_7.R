# ---------------------------------------------------------------------------------------------------------
# CODE FOR PERFORMING STATISTICAL TESTS FOR AJP BAT MANUSCRIPT
# This .R file contains the script to plot Figure 7 and perform the multiple linear regression statistics.
# The script reads the necessary csv files from the ../tidy_data/ folder.
# ---------------------------------------------------------------------------------------------------------

# # Need ggplot2 and plyr
require(ggplot2)
require(plyr)

# Load CSV file into a data frame
fullData = read.csv('../tidy_data/PET_Positive_BAT_tidy_data.csv')

# ---------------------------------------------------------------------------------------------------------
# Pull out the Sex, BMI, Waist Circumference, Age, and BAT volume 
# for all the subjects, only keeping one value per subject

sub_CA = fullData[, "Scan_Temp"]=="CA"
CAData = fullData[sub_CA ,]


Sex = CAData[, "Sex"]
BMI = CAData[, "BMI"]
WaistCirc = CAData[, "Waist_cm"]
Age = CAData[, "Age_yr"]
BAT_vol = CAData[, "BAT_volume_cm3"]

# ---------------------------------------------------------------------------------------------------------
# Plot Figure 7 in two plots:

# BAT Volume vs. Age
g0 = ggplot(CAData, aes(x=Age, y=BAT_vol, shape=Sex)) +
  geom_point(alpha=0.5,size=20) + 
  theme(axis.text=element_text(colour="black", size=40,face="bold"),axis.title=element_text(size=20),
        axis.line = element_line(colour = "black"),
        panel.grid.major = element_line(linetype = 3, colour = "gray", size = 2),
        panel.grid.minor = element_blank(),
        panel.background = element_blank())

g0.labs <- g0 + labs(title = "", x = "Age [years]", y = "BAT Volume [cm3]")
g1 = g0.labs
plot(g1)

# Copy plot to a PNG file
dev.copy(png, file='../figures/Figure_7_Volume_v_Age.png', width=850, height=750)
# Don't forget to close the PNG device!
dev.off()

# BAT Volume vs. BMI
g2 = ggplot(CAData, aes(x=BMI, y=BAT_vol, shape=Sex)) +
  geom_point(alpha=0.5,size=20) + 
  theme(axis.text=element_text(colour="black", size=40,face="bold"),axis.title=element_text(size=20),
        axis.line = element_line(colour = "black"),
        panel.grid.major = element_line(linetype = 3, colour = "gray", size = 2),
        panel.grid.minor = element_blank(),
        panel.background = element_blank())

g2.labs <- g2 + labs(title = "", x = "BMI [kg/m2]", y = "BAT Volume [cm3]")
g3 = g2.labs
plot(g3)

# Copy plot to a PNG file
dev.copy(png, file='../figures/Figure_7_Volume_v_BMI.png', width=850, height=750)
# Don't forget to close the PNG device!
dev.off()


# ---------------------------------------------------------------------------------------------------------
# Display the statistics (R-squared, p-value and confidence interval)

model_BAT <- lm(BAT_vol ~ WaistCirc + BMI + Age + Sex)

print("Figure 7) statistics (R-squared, p-value and confidence interval)")
print(summary(model_BAT))
print(confint(model_BAT, conf.level=0.95))
# ---------------------------------------------------------------------------------------------------------
