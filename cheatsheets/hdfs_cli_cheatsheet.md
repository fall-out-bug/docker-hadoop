# HDFS command cheatsheet
## Команды вывода списков
|Команда|Описание|
|---|---|
|`hdfs dfs -ls /`|Список всех файлов/каталогов в корневом каталоге HDFS|
|`hdfs dfs -ls -d /tmp`|Выводит каталоги как обычные файлы. В данном случае, эта команда перечислит подробную информацию папки tmp|
|`hdfs dfs -ls -h /hdfsDirectory`|Форматирует размеры файлов в директории HDFS в удобный для чтения вид|
|`hdfs dfs -ls -R /hdfsDirectory`|Рекурсивно перечисляет все файлы и директории в директории HDFS|
|`hdfs dfs -ls /hdfsDirectory/hdfsFile*`|Выводит все файлы, соответствующие шаблону. В этом случае выводит все файлы в HDFS-каталоге hdfsDirectory, которые начинаются с hdfsFile|

## Команды чтения и записи
|Команда|Описание|
|---|---|
|`hdfs dfs -text /hdfsDirectory/hdfsFile`|Эта команда принимает исходный файл и выводит файл в текстовом формате в stdout. Допустимыми форматами являются ZIP и TextRecordInputStream|
|`hdfs dfs -cat /hdfsDirectory/hdfsFile`|Выводит содержимое файла HDFS в stdout|
|`hdfs dfs -appendToFile localfsFile /tmp/hdfsFile`|Добавляет содержимое локального файла в файл HDFS|

## Команды скачивания и загрузки
|Команда|Описание|
|---|---|
|`hdfs dfs -put localfsFile /hdfsDirectory`|Копирует файл из локальной файловой системы в каталог HDFS|
|`hdfs dfs -put -f localfsFile /hdfsDirectory`|Копирует файл из локальной файловой системы в каталог HDFS, а в случае, если локальный файл уже существует в указанном пути назначения, использование опции -f с командой -put перезапишет его|
|`hdfs dfs -put -l localfsFile /hdfsDirectory`|Копирует файл из локальной файловой системы в каталог HDFS. Разрешает DataNode «лениво» сохранить файл на диск|
|`hdfs dfs -put -p localfsFile /hdfsDirectory`|Копирует файл из локальной файловой системы в каталог HDFS.Передача аргумента -p сохраняет доступ, модификации, право собственности и режим|
|`hdfs dfs -get hdfsFile /localfsDirectory`|Копирует файл из каталога HDFS в каталог локальной файловой системы|
|`hdfs dfs -get -p hdfsFile /localfsDirectory`|Копирует файл из каталога HDFS в каталог локальной файловой системы. Передача аргумента -p сохраняет доступ, модификации, право собственности и режим|
|`hdfs dfs -get /localfsDirectory/*.* /hdfsDirectory`|Копирует все файлы, соответствующие шаблону, из каталога локальной файловой системы в каталог HDFS|
|`hdfs dfs -copyFromLocal localfsFile /hdfsDirectory`|Работает аналогично команде put, за исключением того, что исходными данными для копирования должен быть локальный файл|
|`hdfs dfs -copyToLocal hdfsFile /localfsDirectory`|Работает аналогично команде put, за исключением того, что конечными данными для копирования должен быть локальный файл|
|`hdfs dfs -moveFromLocal localfsFile /hdfsDirectory`|Работает аналогично команде put, за исключением того, что исходные данные удаляются после копирования|

## Команды управления файлами
|Команда|Описание|
|---|---|
|`hdfs dfs -cp /hdfsDirectory1/hdfsFile1 /hdfsDirectory2`|Копирует файл из одного каталога HDFS в другой каталог HDFS|
|`hdfs dfs -cp -p /hdfsDirectory1/hdfsFile1 /hdfsDirectory2`|Копирует файл из одного каталога HDFS в другой каталог HDFS. Передача аргумента -p сохраняет доступ, модификации, право собственности и режим|
|`hdfs dfs -cp -f /hdfsDirectory1/hdfsFile1 /hdfsDirectory2`|Копирует файл из одного каталога HDFS в другой каталог HDFS. Передача -f перезаписывает файл назначения, если он уже существует|
|`hdfs dfs -mv /hdfsDirectory1/hdfsFile1 /hdfsDirectory2`|Перемещает файл из одного каталога HDFS в другой каталог HDFS|
|`hdfs dfs -rm /hdfsDirectory/hdfsFile` <br> `hdfs dfs -rm -r /hdfsDirectory` <br> `hdfs dfs -rm -R /hdfsDirectory` <br> `hdfs dfs -rmr /hdfsDirectory`|Рекурсивно удаляет все подкаталоги и файлы из каталога HDFS|
|`hdfs dfs -rm -skipTrash /hdfsDirectory`|Параметр -skipTrash удаляет один или несколько указанных файлов из каталога HDFS, минуя trash|
|`hdfs dfs -rm -f hdfsFile`|Не выводит предупреждение при выполнении команды, если файл не существует|
|`hdfs dfs -rmdir /hdfsDirectory`|Удаляет каталог HDFS|
|`hdfs dfs -mkdir /hdfsDirectory`|Создает каталог в указанном месте HDFS|
|`hdfs dfs -mkdir -f /hdfsDirectory1/hdfsDirectory2`|Создает каталог в указанной директории HDFS. Команда не вернет ошибку, даже если каталог уже существует|
|`hdfs dfs -touchz /hdfsDirectory/hdfsFile`|Создает файл нулевой длины по указанному пути с текущим временем в качестве временной метки этого пути|

## Команды прав владения и проверки
|Команда|Описание|
|---|---|
|`hdfs dfs -checksum /hdfsDirectory/hdfsFile`|Выводит информацию о контрольной сумме файла в stdout|
|`hdfs dfs -chmod 755 /hdfsDirectory/hdfsFile`|Изменяет права доступа к файлу|
|`hdfs dfs -chmod -R 755 /hdfsDirectory`|Рекурсивно изменяет права доступа к файлам|
|`hdfs dfs -chown owner:group /hdfsDirectory`|Изменяет владельца файла|
|`hdfs dfs -chown -R owner:group /hdfsDirectory`|Рекурсивно изменяет владельца файлов в каталоге|
|`hdfs dfs -chgrp group /hdfsDirectory`|Изменяет группы файлов|
|`hdfs dfs -chgrp -R group /hdfsDirectory`|Рекурсивно изменяет группы файлов|

## Команды файловой системы
|Команда|Описание|
|---|---|
|`hdfs dfs -df /`|Показывает общий объем, свободное и используемое пространство файловой системы|
|`hdfs dfs -df -h /`|Показывает общий объем, свободное и используемое пространство файловой системы. Ключ -h форматирует размеры файлов в удобный для чтения вид|
|`hdfs dfs -du /hdfsDirectory/hdfsFile`|Показывает объем пространства (в байтах), используемый файлами, которые соответствуют указанному шаблону файла|
|`hdfs dfs -du -s /hdfsDirectory/hdfsFile`|Вместо размера каждого файла, соответствующего шаблону, отображает общий (суммарный) размер|
|`hdfs dfs -du -h /hdfsDirectory/hdfsFile`|Показывает объем пространства (в байтах), используемый файлами, которые соответствуют указанному шаблону файла. Форматирует размеры файлов в удобный для чтения вид|