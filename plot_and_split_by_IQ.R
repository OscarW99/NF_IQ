#!/usr/bin/env Rscript

library(argparse)
library(ggplot2)
library(ggrepel)

parser <- ArgumentParser(description='An executible R script to read in IQ data, plot a scatter plot and then split and save data into low vs int vs high csv files.')

parser$add_argument("-data", "--d", type="character", dest="IQ_data_path", help="Provide the full path to the IQ data .csv file.")

args <- parser$parse_args()
IQ_data_path <- args$IQ_data_path

IQ_data_path <- "/ahg/regevdata/projects/lungCancerBueno/Results/10x_nsclc_41421/data/PRIV_GITHUB/csvData.csv"

data <- read.csv(file=IQ_data_path)
data <- as.data.frame(data)
data$log_pop <- log(data$pop2021)

while (!is.null(dev.list())) dev.off()
ggplot(data, aes(log_pop,finalIq)) +
    geom_point() +
    geom_text_repel(aes(label = country))
ggsave("IQ_scatter_plot.png", width = 10, height = 8, type = "cairo")
dev.off()

data$rank <- data[['X...rank']]
data[['X...rank']] <- NULL
# Split data into high mid low and save each.

low <- data[data$finalIq < 80,]
mid <- data[data$finalIq >= 80 & data$finalIq < 100,]
high <- data[data$finalIq >= 100,]


write.csv(low,"low_IQ.csv", row.names = FALSE)
write.csv(mid,"mid_IQ.csv", row.names = FALSE)
write.csv(high,"high_IQ.csv", row.names = FALSE)