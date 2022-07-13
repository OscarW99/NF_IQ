#! /usr/bin/env python
import argparse
import pandas as pd


def run(args):
    filename = args.input  # these match the "dest": dest="input"
    output_filename = args.output  # from dest="output"
    qual = args.quality_score  # default is I

    # Do stuff


def main():
    parser = argparse.ArgumentParser(
        description="Read a CSV file and create sentences with data")
    parser.add_argument("-d", help="csv input file",
                        dest="input", type=str, required=True)
    parser.set_defaults(func=run)
    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()


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


########################################

# Read in csv file

data = pd.read_csv(input_path)


for index, row in data.iterrows():
    with open(row['country'] + '.txt', 'w') as f:
        f.write(f''row[''], row['c2'])
