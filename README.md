# Animated background
### Анимированный бэкграунд (окно боя и главный экран) для RPG Maker VX ACE.

### Как подключить.
- Вставить batch.rb в скрипты проекта.
- ИЛИ подключить как гем при помощи https://github.com/godsent/rpg-maker-side-script-loader

### Как испльзовать.
Анимировать можно как верхний, так и нижний слой бэка. Делаете тайл вашего анмированного БГ, помещая кадры друг над другом в одном большом файле. Высота и ширина каждого кадра может быть произвольной, они выравниваются по левому верхнему углу. Скрипт будет их переключать сверху вниз. Вся настройка делается при помощи имени этого файла. Имя должно быть вида animated_title_12_12.png 
- Имя обязательно должно начинаться со строки animated - это флаг того, что этот бэк анимированн.
- В конце имени файла идут два числа, отделенные нижними подчеркиваниями. Первое из них - это количество кадров в бэке.
- Второе число - это скорость переключения кадров (во фреймах).
