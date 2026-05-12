from flask import Flask, request, jsonify
import csv
import os

app = Flask(__name__)

FILE_NAME = "students.csv"
FIELDS = ["id", "name", "surname", "age"]


# --- допоміжні функції ---

def read_students():
    students = []
    if not os.path.exists(FILE_NAME):
        return students

    with open(FILE_NAME, "r", newline="") as file:
        reader = csv.DictReader(file)
        for row in reader:
            students.append(row)
    return students


def write_students(students):
    with open(FILE_NAME, "w", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=FIELDS)
        writer.writeheader()
        writer.writerows(students)


def generate_id(students):
    if not students:
        return 1
    return max(int(s["id"]) for s in students) + 1


# --- GET ---

@app.route("/students", methods=["GET"])
def get_all_students():
    students = read_students()
    return jsonify(students)


@app.route("/students/id/<int:student_id>", methods=["GET"])
def get_student_by_id(student_id):
    students = read_students()

    for s in students:
        if int(s["id"]) == student_id:
            return jsonify(s)

    return jsonify({"error": "Student not found"}), 404


@app.route("/students/surname/<surname>", methods=["GET"])
def get_student_by_surname(surname):
    students = read_students()
    result = [s for s in students if s["surname"] == surname]

    if not result:
        return jsonify({"error": "Student not found"}), 404

    return jsonify(result)


# --- POST ---

@app.route("/students", methods=["POST"])
def create_student():
    data = request.json

    if not data:
        return jsonify({"error": "Empty body"}), 400

    if set(data.keys()) != {"name", "surname", "age"}:
        return jsonify({"error": "Invalid fields"}), 400

    students = read_students()
    new_id = generate_id(students)

    new_student = {
        "id": str(new_id),
        "name": data["name"],
        "surname": data["surname"],
        "age": str(data["age"])
    }

    students.append(new_student)
    write_students(students)

    return jsonify(new_student), 201


# --- PUT ---

@app.route("/students/<int:student_id>", methods=["PUT"])
def update_student(student_id):
    data = request.json

    if not data:
        return jsonify({"error": "Empty body"}), 400

    if set(data.keys()) != {"name", "surname", "age"}:
        return jsonify({"error": "Invalid fields"}), 400

    students = read_students()

    for s in students:
        if int(s["id"]) == student_id:
            s["name"] = data["name"]
            s["surname"] = data["surname"]
            s["age"] = str(data["age"])

            write_students(students)
            return jsonify(s)

    return jsonify({"error": "Student not found"}), 404


# --- PATCH ---

@app.route("/students/<int:student_id>", methods=["PATCH"])
def patch_student(student_id):
    data = request.json

    if not data:
        return jsonify({"error": "Empty body"}), 400

    if set(data.keys()) != {"age"}:
        return jsonify({"error": "Only age allowed"}), 400

    students = read_students()

    for s in students:
        if int(s["id"]) == student_id:
            s["age"] = str(data["age"])

            write_students(students)
            return jsonify(s)

    return jsonify({"error": "Student not found"}), 404


# --- DELETE ---

@app.route("/students/<int:student_id>", methods=["DELETE"])
def delete_student(student_id):
    students = read_students()

    for s in students:
        if int(s["id"]) == student_id:
            students.remove(s)
            write_students(students)
            return jsonify({"message": "Student deleted"})

    return jsonify({"error": "Student not found"}), 404


if __name__ == "__main__":
    app.run(debug=True)