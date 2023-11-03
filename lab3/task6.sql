--- Получить список студентов, отчисленных ровно первого сентября 2012 года с очной формы обучения (специальность: 230101). В результат включить:
--- номер группы;
--- номер, фамилию, имя и отчество студента;
--- номер пункта приказа;
--- Для реализации использовать соединение таблиц.


SELECT Н_УЧЕНИКИ.ГРУППА,
       CONCAT(Н_ЛЮДИ.ФАМИЛИЯ, ' ', Н_ЛЮДИ.ИМЯ, ' ', Н_ЛЮДИ.ОТЧЕСТВО) as ФИО,
       Н_УЧЕНИКИ.В_СВЯЗИ_С
FROM Н_ЛЮДИ
         JOIN Н_УЧЕНИКИ ON Н_ЛЮДИ.ИД = Н_УЧЕНИКИ.ЧЛВК_ИД
         JOIN Н_ПЛАНЫ ON Н_УЧЕНИКИ.ПЛАН_ИД = Н_ПЛАНЫ.ИД
         JOIN Н_ФОРМЫ_ОБУЧЕНИЯ ON Н_ПЛАНЫ.ФО_ИД = Н_ФОРМЫ_ОБУЧЕНИЯ.ИД
         JOIN Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ ON Н_ПЛАНЫ.НАПС_ИД = Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ.ИД
         JOIN Н_НАПР_СПЕЦ ON Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ.НС_ИД = Н_НАПР_СПЕЦ.ИД
WHERE Н_УЧЕНИКИ.ПРИЗНАК = 'отчисл'
  AND Н_УЧЕНИКИ.КОНЕЦ = '2012.09.01'
  AND Н_ФОРМЫ_ОБУЧЕНИЯ.НАИМЕНОВАНИЕ = 'Очная'
  AND Н_НАПР_СПЕЦ.КОД_НАПРСПЕЦ = '230101'