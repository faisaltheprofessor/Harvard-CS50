def get_average_letters_per_100_words(s):
    total_words = 0
    total_letters = 0
    for char in s:
        if char.isalpha():
            total_letters += 1
        elif char.isspace():
            total_words += 1

    total_words += 1
    average_letters_per_word = total_letters / total_words
    average_letters_per_100_words = average_letters_per_word * 100
    return average_letters_per_100_words

def get_average_sentences_per_100_words(s):
    num_sentences = 0
    total_words = 0
    for char in s:
        if char in ['.', '?', '!']:
            num_sentences += 1
        elif char.isspace():
            total_words += 1

    total_words += 1
    average_sentences_per_100_words = (num_sentences / total_words) * 100
    return average_sentences_per_100_words

def calculate_readability_score(s):
    letters_per_100_words = get_average_letters_per_100_words(s)
    sentences_per_100_words = get_average_sentences_per_100_words(s)

    score = 0.0588 * letters_per_100_words - 0.296 * sentences_per_100_words - 15.8

    if score - int(score) >= 0.5:
        return int(score) + 1
    else:
        return int(score)

input_text = input("Enter the text: ")
score = calculate_readability_score(input_text)
if score < 1:
    print("Before Grade 1")
elif score >= 16:
    print("Grade 16+")
else:
    print(f"Grade {score}")
