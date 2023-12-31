--- Сделать запрос для получения атрибутов из указанных таблиц, применив фильтры по указанным условиям:
--- Таблицы: Н_ЛЮДИ, Н_ВЕДОМОСТИ.
--- Вывести атрибуты: Н_ЛЮДИ.ИД, Н_ВЕДОМОСТИ.ИД.
--- Фильтры (AND):
--- a) Н_ЛЮДИ.ФАМИЛИЯ = Соколов.
--- b) Н_ВЕДОМОСТИ.ИД > 1490007.
--- Вид соединения: LEFT JOIN.

SELECT Н_ЛЮДИ.ИМЯ, Н_ВЕДОМОСТИ.ИД
FROM Н_ЛЮДИ LEFT JOIN Н_ВЕДОМОСТИ
                 ON Н_ЛЮДИ.ИД = Н_ВЕДОМОСТИ.ЧЛВК_ИД
WHERE Н_ЛЮДИ.ФАМИЛИЯ = 'Соколов'
  AND Н_ВЕДОМОСТИ.ИД > 1490007;