--- Сформировать запрос для получения числа в группе No 3100 отличников.

SELECT COUNT(*) FROM (
                         SELECT Н_ЛЮДИ.ИД,
                                SUM(CASE WHEN Н_ВЕДОМОСТИ.ОЦЕНКА = '5' THEN 1 ELSE 0 END) AS GOOD,
                                SUM(CASE WHEN Н_ВЕДОМОСТИ.ОЦЕНКА IN ('незачет', '3', '2', 'неявка') THEN 1 ELSE 0 END) AS BAD
                         FROM   Н_ЛЮДИ
                                    JOIN   Н_УЧЕНИКИ ON Н_ЛЮДИ.ИД = Н_УЧЕНИКИ.ЧЛВК_ИД
                                    JOIN   Н_ПЛАНЫ   ON Н_УЧЕНИКИ.ПЛАН_ИД = Н_ПЛАНЫ.ИД
                                    JOIN   Н_ОТДЕЛЫ  ON Н_ПЛАНЫ.ОТД_ИД = Н_ОТДЕЛЫ.ИД
                                    JOIN   Н_ВЕДОМОСТИ ON Н_ВЕДОМОСТИ.ЧЛВК_ИД = Н_ЛЮДИ.ИД
                         WHERE Н_УЧЕНИКИ.ГРУППА = '3100'
                         GROUP BY Н_ЛЮДИ.ИД
                     ) AS MARKS
WHERE MARKS.GOOD > 0 AND MARKS.BAD = 0