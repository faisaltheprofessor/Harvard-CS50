import csv
import sys
import os


def main():

    # Check for command-line usage
    if len(sys.argv) < 3:
        print("Usage: python dna.py databases/*.csv sequences/*.txt")
        sys.exit(1)

    # Read database file into a variable
    database = read_csv_to_list(sys.argv[1])

    # Read DNA sequence file into a variable
    dna_sequence = read_text_file(sys.argv[2])

    # List of subsequences to check
    subsequences = list(database[0].keys())[1:]

    # Find longest match of each STR in DNA sequence
    result = {
        subsequence: longest_match(dna_sequence, subsequence)
        for subsequence in subsequences
    }

    # Check database for matching profiles
    match_person = check_matching_profiles(database, subsequences, result)

    if match_person:
        print(match_person["name"])
    else:
        print("No match")


def longest_match(sequence, subsequence):
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


def read_csv_to_list(file_path):
    if file_exists(file_path):
        with open(file_path, "r") as file:
            return list(csv.DictReader(file))
    else:
        print(f"file {file_path} not found")
        sys.exit(2)


def read_text_file(file_path):
    if os.path.exists(file_path):
        with open(file_path, "r") as file:
            return file.read()
    else:
        print(f"file {file_path} not found")
        sys.exit(2)


def check_matching_profiles(database, subsequences, result):
    for person in database:
        if all(
            int(person[subsequence]) == result[subsequence]
            for subsequence in subsequences
        ):
            return person
    return None


def file_exists(file_path):
    return os.path.exists(file_path)


main()
