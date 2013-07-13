fmt_cell = (x) ->
    (if x > 0 then '&nbsp;' else '') + x.toFixed(2)

identity = (x, y) ->
    if x == y then 1 else 0

class Matrix
    constructor: (@width, @height, data = (() -> 0), sparse = false) ->
        if sparse
            @indicator = data
        else # sparse matrices don't use arrays, and are not mutable
            if typeof(data) == 'function'
                @data = []
                for i in [0 ... height]
                    @data[i] = []
                    for j in [0 ... width]
                        @data[i][j] = data(j, i)
            else
                @data = data

    indicator: (x, y) -> @data[y][x]
    set: (x, y, value) -> @data[y][x] = value
    html: () ->
        html = ['<table class="matrix">']
        for i in [0 ... @height]
            html.push('<tr>')
            for j in [0 ... @width]
                html.push("<td>#{fmt_cell(@data[i][j])}</td>")
            html.push('</tr>')
        html.push('</table>')
        html.join('')

    mult: (other) ->
        if @width != other.height
            console.log(this, other)
            throw "error: incompatible matrix sizes for multiplication"
        result = []
        for i in [0 ... @height]
            result[i] = []
            for j in [0 ... other.width]
                sum = 0
                for k in [0 ... @width]
                    sum += @indicator(k, i) * other.indicator(j, k)
                result[i][j] = sum
        new Matrix(other.width, @height, result)

window.matrix =
    'Matrix': Matrix,
    'identity': identity
