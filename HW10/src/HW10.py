import random

def random_chyslo():
    chyslo = random.randint(1,100)

    print("Спробуй вгадати число від 1 до 100. В тебе 5 спроб")

    # Спроба 1
    user = int(input("Перша спроба!\nВаше число: "))
    if user == chyslo:
        print("Вітаємо! Ви вгадали правильне число!")
        return
    elif user > chyslo:
        print("Занадто високо!")
    else:
       print("Занадто низько!")

    # Спроба 2
    user = int(input("Друга спроба!\nВаше число: "))
    if user == chyslo:
       print("Вітаємо! Ви вгадали правильне число!")
       return
    elif user > chyslo:
        print("Занадто високо!")
    else:
        print("Занадто низько!")
    # Спроба 3
    user = int(input("Третя спроба!\nВаше число: "))
    if user == chyslo:
        print("Вітаємо! Ви вгадали правильне число!")
        return
    elif user > chyslo:
        print("Занадто високо!")
    else:
        print("Занадто низько!")

    # Спроба 4
    user = int(input("Четверта спроба!\nВаше число: "))
    if user == chyslo:
        print("Вітаємо! Ви вгадали правильне число!")
        return
    elif user > chyslo:
        print("Занадто високо!")
    else:
        print("Занадто низько!")

    # Спроба 5
    user = int(input("П'ята спроба!\nВаше число: "))
    if user == chyslo:
        print("Вітаємо! Ви вгадали правильне число!")
        return
    elif user > chyslo:
        print("Занадто високо!")
    else:
        print("Занадто низько!")

    print(f"Вибачте, у вас закінчилися спроби. Число було: {chyslo}")

while True:
    random_chyslo()

    restart =input("Продовжити? (1 - так, 2 - ні): ")
    if restart == "2":
        break
