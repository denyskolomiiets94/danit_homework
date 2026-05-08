# Батьківський клас
class Alphabet:
    def __init__(self, lang, letters):
        self.lang = lang          # мова
        self.letters = letters    # список літер

    # вивести всі літери
    def print(self):
        print(self.letters)

    # порахувати кількість
    def letters_num(self):
        return len(self.letters)


# Дочірній клас
class EngAlphabet(Alphabet):

    def __init__(self):
        # викликаємо батьківський конструктор
        super().__init__("En", "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    # перевірка літери
    def s_en_letter(self, letter):
        return letter.upper() in self.letters

    # статичний метод
    @staticmethod
    def example():
        return "Hello, today was a sunny day."

# 🔹 Тести (main)
eng = EngAlphabet()

eng.print()  # всі літери

print("Кількість літер:", eng.letters_num())
print("F належить?:", eng.s_en_letter('F'))
print("Щ належить?:", eng.s_en_letter('Щ'))
print("Приклад:", EngAlphabet.example())