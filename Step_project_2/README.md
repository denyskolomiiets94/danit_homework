1 - Створити пусту папку "app" і клонувати застосунок "Step2" з GitHub 

2 - Створти у себе на GitHub пустий прект і туди запушити папку "app" яка вже буде містити в собі Dockerfile, index.js, 
    package.json і папку tests з кодом app.test.js

3 - Створити користувача на Docker Hub і створити токен. 

4 - Відкрити Git Bash і створити папку проєкту, наприклад StepProject2

5 - Клонувати проєкт з GitHub за посиланням:
    https://github.com/denyskolomiiets94/danit_homework/tree/main/Step_project_2

6 - Структура має бути така:

    Папка StepProject2 містить Vagrantfile - який створює дві віртуальні машини, також має бути папка src
    В папці src має бути два скріпта master.sh, worker.sh які додатково налаштовують дві віртуальні машини 
    master (додатково встанолює: openjdk-21-jdk, curl, wget, net-tools) і worker (додатково встанолює: docker.io, 
    openjdk-21-jdk)

7 - Перейти в папку проєкту де знаходиться Vagrantfile і виконати команду "vagrant up" і дочекатися створення двох VM:
    Jenkins Master і Jenkins Worker

8 - Налаштувати jenkins-master і jenkins-worker

    1. Підключитись vagrant ssh jenkins-master
    2. Перевирити статус Jenkins (sudo systemctl status jenkins)
    3. Створити ssh ключ і закинути публічний ключ на другу віртуальну машину jenkins-worker
    4. Відкрити браузер і перейти за посиланням http://192.168.56.10:8080/
    5. Підключитись vagrant ssh jenkins-worker
    6. Перевірити, що користувач jenkins був створений автоматично скриптом worker.sh (grep jenkins /etc/passwd)
    7. На jenkins-master створити SSH-ключ для користувача jenkins
    8. Скопіювати публічний ключ на jenkins-worker у файл ~/.ssh/authorized_keys користувача jenkins.
    9. Перевірити SSH-підключення з master до worker.
    10. В браузері де відкрився Jenkins перейти в налаштувааня та обрати Credentials > Global > Add Credentials
       і заповнити поля: 
       - поле Kind обрати SSH Username with private key
       - поле Username написати jenkins
       - поле Private Key обрати Enter directly > Add і вставити приватиний ssh ключ який створили на віртульці 
       jenkins-master і зберегти
    11. На стартовій сторінці Jenkins обираємо Build Executor Status там обрати New Node:
       - назва worker1 і обираємо тип Permanent Agent
       - поле Remote root directory пишемо шлях: /home/jenkins
       - поле Labels пишемо worker1
       - поле Usage обираємо Use this node as much as possible  
       - поле Launch method обираємо Launch agents via SSH
       - поле Host прописуємо 192.168.56.11 
       - поле Credentials обираємо jenkins який ми створили далі зберігаємо
       - поле Host Key Verification Strategy обрати Non Verification Strategy далі зберігаємо
       - перевіряємо чи агент запустився і пише в логах Agent successfully connected and online
         
9 - Добавити токен від Docker Hub який був раніше створений:

    1. перейти в налаштування та обрати Credentials > Global > Add Credentials
    2. поле Kind обрати Username with password
    3. поле Username твій Docker Hub логін
    4. поле Password закидуємо Docker Hub Token
    5 поле ID пишемо dockerhub
10 - Створити рipeline для Pipeline Job:

    1. створити Jenkinsfile який буде виконувати завдання такі як:
        - завантажувати код проєкту з GitHub
        - збирати Docker image із Node.js застосунком
        - запускати тести всередині Docker контейнера
        - якщо тести пройшли успішно — виконує авторизацію в Docker Hub
        - завантажувати (push) Docker image у Docker Hub з тегами latest та номером збірки
        - завершувати Pipeline зі статусом Success або Failed
    2. Запушити його у репозиторій GitHub
11 - Налаштувати Pipeline

    1. У Jenkins обрати New Item з назвою nodejs-pipeline тип Pipeline і натиснути ок. 
    2. Прокрути вниз до секції Pipeline, обрати Definition: Pipeline script from SCM > SCM > Git і вставити репозіторій 
    створенного git проекту де лежить "app" має бути за прикладом: https://github.com/denyskolomiiets94/app.git
    далі в полі Branch написати */main , наступне поле Script Path: обрати Jenkinsfile і зберегти.

12 - Запустити Build Now, після запуску docker image буде запушен в docker hub 