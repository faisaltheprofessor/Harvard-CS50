import csv
import sys
import os

SEQUENCES = ["AGAT", "AATG", "TATC"]

def main():

    # TODO: Check for command-line usage
    if (len(sys.argv) != 2 ):
        print("Missing argument FILE")
        sys.exit(1)

    # TODO: Read database file into a variable

    rows = []
    with open("databases/large.csv") as file:
        reader = csv.DictReader(file)
        for row in reader:
            rows.append(row)


    # TODO: Read DNA sequence file into a variable
    sequenceFile = "sequences/" + sys.argv[1]
    if os.path.exists(sequenceFile):

        with open(sequenceFile) as file:
            dna_sequence = file.read()
    else:
        print("File does not exist")
        sys.exit(2)

    # TODO: Find longest match of each STR in DNA sequence
    sequence_counts = {seq: longest_match(dna_sequence, seq) for seq in SEQUENCES}


    # TODO: Check database for matching profiles

    return


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


main()
