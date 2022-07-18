#!/usr/bin/env python
import argparse
import pandas as pd


# Create the parser
my_parser = argparse.ArgumentParser(
    description="Read a CSV file and create sentences with data")

# Add the arguments
my_parser.add_argument('-d', '--data',
                       dest="input",
                       help="csv input file",
                       type=str, required=True)

# Execute the parse_args() method
args = my_parser.parse_args()

input_path = args.input
# input_path = "/ahg/regevdata/projects/lungCancerBueno/Results/10x_nsclc_41421/data/PRIV_GITHUB/csvData.csv"

########################################

# Read in csv file

data = pd.read_csv(input_path)[1:5]

print('hello world')
print('input_path')


for index, row in data.iterrows():
    file = "/ahg/regevdata/projects/lungCancerBueno/Results/10x_nsclc_41421/data/PRIV_GITHUB/" + \
        row['country'].replace(' ', '_') + '.txt'
    with open(file, 'w') as f:
        f.write("%s has a population of %s and an average IQ of %s.\n" %
                (row['country'], row['pop2021'], row['finalIq']))
        f.close()


# linux command
# touch test.txt | cat South_Korea.txt Japan.txt Hong_Kong.txt China.txt >> test.txt
###
