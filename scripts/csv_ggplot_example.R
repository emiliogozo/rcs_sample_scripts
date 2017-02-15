###########################################################
# Sample R script to read csv and plot using ggplot       #
#                                                         #
#                                                         #
# Required libraries:                                     #
#     dplyr and ggplot2                                   #
#                                                         #
#                                                         #
# Author:                                                 #
#     Emilio Gozo <emil.gozo@gmail.com>                   #
#                                                         #
#                                                         #
# Changelog:                                              #
#     15/02/2017  -  File created.                        #
###########################################################

library(dplyr)
library(ggplot2)

## open file ##
input_file <- 'input/aws/aws.csv'
aws <- read.csv(input_file)

## print column names ##
names(aws)

## get subset ##
## eg: all station ids thats starts with 'mo' ##
aws_subset <- aws[grep("mo", aws$StnID),]

## plot using ggplot2 ##
gg <- ggplot(aws_subset, aes(x=ISOdatetime(2016,8,Day,Hour,0,0), y=Rain, grp=StnID))
gg <- gg + geom_line(aes(col=StnID), lwd=0.25) # line plot
gg <- gg + labs(title="Rainfall Timeseries", x="Date", y="Rainfall [mm]", col="Stations") # labels
gg <- gg + theme_bw()
gg <- gg + theme(plot.title = element_text(hjust = 0.5)) # center the title

## save the plt ##
ggsave("img/rainfall_line.png", width=5, height=2.5)

## get daily accumulated rainfall ##
aws_subset.daily <- aws_subset %>%
    dplyr::select(StnID, Day, Rain) %>%      # select columns
    dplyr::group_by(StnID, Day) %>%          # group by station and day
    dplyr::summarize(Rain=sum(Rain,na.rm=T)) # get the sum per station per day

## plot ##
gg <- ggplot(aws_subset.daily, aes(x=Day, y=Rain, grp=StnID))
gg <- gg + geom_bar(aes(fill=StnID), stat='identity', position='dodge')
gg <- gg + labs(title="Daily Rainfall", x="Day", y="Rainfall [mm]", fill="Stations")
gg <- gg + theme_bw()
gg <- gg + theme(plot.title = element_text(hjust = 0.5))

## save plot as image ##
ggsave("img/rainfall_bar.png", width=5, height=2.5)
