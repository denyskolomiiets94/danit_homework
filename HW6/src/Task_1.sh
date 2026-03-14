#!/bin/bash

#Task_6

number=$((RANDOM % 100 + 1))
attempt=1

echo "Guess a number from 1 to 100"
echo "You have 5 attempts."

while [ $attempt -le 5 ]
do
    echo "Attempt $attempt:"
    read guess

    if [ "$guess" -eq "$number" ]; then
        echo "Congratulations! You guessed the correct number"
        exit
    fi

    if [ "$guess" -gt "$number" ]; then
        echo "Too high"
    else
        echo "Too low"
    fi

    attempt=$((attempt + 1))
done

echo "Sorry, you're out of attempts. The correct number was $number"
