1 - для запуску проекта, треба склонувати сам проект через команду git clone і вставити посилання на директорію 

2 - залогінитись через браузер в косоль aws 

3 - перейти в IDE і там де склонований проект і виконати команду aws login, потім перекине в браузер, де треба натиснути "підтвердити"

4 - перейти в папку step_project_3 далі в папку envr і виконати ряд команд:
    terraform init
    terrafotm plan
    terraform apply

5 -  Для доступу до EC2 instances використовується SSH key pair main-keypair-1.
Публічний SSH-ключ " ~/.ssh/main-keypair-1.pub " передається на EC2 instances під час їх створення через Terraform.
Приватний SSH-ключ "~/.ssh/main-keypair-1.pem" залишається на локальному комп'ютері та використовується для SSH-аутентифікації.
Шлях до приватного ключа використовується в Ansible inventory: ansible_ssh_private_key_file=/home/denys/.ssh/main-keypair-1.pem

6 - далі налаштовуємо jenkins worker:
  Після створення EC2 instances Terraform автоматично створює Ansible inventory "envr/inventory.ini"
Worker знаходиться у приватній підмережі та не має публічної IP-адреси.
Для доступу до Worker використовується ProxyJump через Jenkins Master "ansible_ssh_common_args='-o ProxyJump=ubuntu@<JENKINS_MASTER_PUBLIC_IP>'"
За допомогою Ansible на Worker створюємо користувача jenkins та налаштовуємо SSH-доступ.
  Публічний ключ додається до " /home/jenkins/.ssh/authorized_keys"
Таким чином, Ansible підключається до приватного Worker через Jenkins Master, а Worker не потребує публічної IP-адреси.

7 - перевіряємо доступ до серверів за допомогою команди : " ansible all -m ping "

8 - Налаштувати Jenkins Master і Jenkins Worker. 
переходимо в папку ansible і запускаємо дві команди, спочатку "ansible-playbook jenkins-master.yml" і потім 
"ansible-playbook jenkins-master.yml". Після виконання playbook Jenkins Master та Jenkins Worker будуть налаштовані.

9 - налаштовуємо Jenkins, переходимо на публічну машинку, IP можна дізнатись в aws - ec2 - instances - і обрати Jenkins-Master.
коли перейшли на публічну адресу Jenkins-Master треба буде виконати активацію jenkins за вказаною інструкцією і потім інсталювати його. 

10 - створюємо Credentials:
 Credentials для Docker Hub, треба перейти налаштування Jenkins → Credentials → System → Global credentials → Add Credentials
     і заповнити поля : 
     Kind: Username with password
     Username: твій Docker Hub username
     Password: той токен ( його треба створи на docker hub )
     ID: dockerhub_step3
     Description можна: Docker Hub 
     Натискаєш Create
 Credentials для  Jenkins Worker - налаштування Jenkins → Credentials → System → Global credentials → Add Credentials
   обрати :
     Kind: SSH Username with private key
     Username: jenkins
     Private Key: Enter directly
     У Private Key вставляєш вміст що видає команда " cat ~/.ssh/jenkins_worker_key "

11 -  Додати Jenkins Worker як Node з label: worker1


  заповнюємо поля: 

  Name: worker1

  Remote root directory: /home/jenkins

  Labels: worker1

  Launch method:

  Launch agents via SSH

  Host: вставляємо приватну IP 

 Credentials: jenkins

12 -  Запуск Pipeline

  Tреба створити нову jobу 
  На головній Jenkins  > New Item > Назва, наприклад: Step_project_3 > Обираєш Pipeline
  
  Далі налаштовуємо Pipeline 
  
  У секції Pipeline > Definition > Pipeline script from SCM > SCM > Git і вставляємо репозіторій з посиланням на минулий тестовий проект.
  
Оскільки репозиторій у public, Credentials поки залишаємо - None -.

далі Branch Specifier пишемо */main
Script Path пишемо де лежить Jenkinsfile
Зберігаємо і натискаємо Build Now.

13 - в самому кінці треба перейти в папку envr і виконати команду terraform destroy
