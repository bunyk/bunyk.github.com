###
cal = (() ->
    month_names = [
        'Січень',
        'Лютий',
        'Березень',
        'Квітень',
        'Травень',
        'Червень',
        'Липень',
        'Серпень',
        'Вересень',
        'Жовтень',
        'Листопад',
        'Грудень'
    ]
    days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    week_days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Нд']

    month_calendar_table = (year, month) ->
        first_day = (new Date(year, month, 1)).getDay()
        first_day = 6 if first_day == 0 else first_day - 1
        table = []
        current_day = 1
        row = 
        table.push(week_days)

    month_calendar_text = (year, month) ->
        tbl = month_calendar_table(year, month)
        month_names[month] + ' ' + yeart + '\n' + bl.map((row) -> row.join(' ')).join('\n')

    return {
        month_calendar_table: month_calendar_table,
    }
)()
###
