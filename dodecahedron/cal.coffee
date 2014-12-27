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
    # which day of week is first day of month ?
    first_day = (new Date(year, month, 1)).getDay()
    if first_day == 0
        first_day = 6
    else
        first_day = first_day - 1

    table = [week_days]
    row = []
    for i in [0 ... first_day]
        row.push(' ')
    for current_day in [1 .. days_in_month[month]]
        row.push(current_day)
        if i == 6
            i = 0
            table.push(row)
            row = []
        else
            i = i + 1
    if i > 0
        while i < 7
            row.push(' ')
            i++
        table.push(row)
    table


month_calendar_text = (year, month) ->
    tbl = month_calendar_table(year, month)
    render_row = (row) ->
        row.map((x) -> 
            s = x.toString()
            if s.length < 2
                s = ' ' + s
            s
        ).join(' ')

    month_names[month] + ' ' + year + '\n' + tbl.map(render_row).join('\n')

window.cal = {
    table: month_calendar_table,
    text: month_calendar_text,
}
