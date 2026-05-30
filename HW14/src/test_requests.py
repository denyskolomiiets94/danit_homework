import requests

BASE_URL = "http://127.0.0.1:5000/students"
RESULT_FILE = "results.txt"


def log(text):
    print(text)
    with open(RESULT_FILE, "a", encoding="utf-8") as f:
        f.write(text + "\n")


# очистка файлу перед запуском
open(RESULT_FILE, "w").close()


# 1. GET всі студенти
log("\n1. GET всі студенти")
r = requests.get(BASE_URL)
log(str(r.json()))

# 2. POST створити 3 студентів
log("\n2. POST створення студентів")

students_data = [
    {"name": "Denys", "surname": "Ivanov", "age": 25},
    {"name": "Oleh", "surname": "Petrov", "age": 22},
    {"name": "Anna", "surname": "Sydorenko", "age": 20}
]

created_students = []

for s in students_data:
    r = requests.post(BASE_URL, json=s)
    log(str(r.json()))
    created_students.append(r.json())

# 3. GET всі студенти
log("\n3. GET всі студенти після створення")
r = requests.get(BASE_URL)
log(str(r.json()))

# беремо ID
id1 = created_students[0]["id"]
id2 = created_students[1]["id"]
id3 = created_students[2]["id"]

# 4. PATCH другий студент (оновити вік)
log("\n4. PATCH другий студент (вік)")
r = requests.patch(f"{BASE_URL}/{id2}", json={"age": 30})
log(str(r.json()))

# 5. GET другий студент
log("\n5. GET другий студент")
r = requests.get(f"{BASE_URL}/id/{id2}")
log(str(r.json()))

# 6. PUT третій студент (повне оновлення)
log("\n6. PUT третій студент")
r = requests.put(f"{BASE_URL}/{id3}", json={
    "name": "AnnaUpdated",
    "surname": "NewSurname",
    "age": 28
})
log(str(r.json()))

# 7. GET третій студент
log("\n7. GET третій студент")
r = requests.get(f"{BASE_URL}/id/{id3}")
log(str(r.json()))

# 8. GET всі
log("\n8. GET всі студенти")
r = requests.get(BASE_URL)
log(str(r.json()))

# 9. DELETE перший студент
log("\n9. DELETE перший студент")
r = requests.delete(f"{BASE_URL}/{id1}")
log(str(r.json()))

# 10. GET всі
log("\n10. GET всі студенти після видалення")
r = requests.get(BASE_URL)
log(str(r.json()))