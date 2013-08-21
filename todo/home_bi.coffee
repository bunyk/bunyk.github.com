# REQUIRE jquery
# REQUIRE underscore
# REQUIRE backbone
# REQUIRE backbone_localstorage
#
$ = jQuery
$(() ->

    createTableWidget = (element, table_name, schema) ->
        ###
        #   Function creates backbone MVC with CRUD functionality
        #   for some relational table.
        #
        #   element - jquery element to put widget into
        #   table_name - for backend model storage
        #   schema - list of field names
        #   TODO: add field types and appropriate widgets
        ###
        
        empty_fields = {}
        for field in schema
            empty_fields[field] = ''

        ModelItem = Backbone.Model.extend()
        ItemList = Backbone.Collection.extend(
            model: ModelItem,
            localStorage: new Store(table_name)
        )
        Items = new ItemList

        getTableCell = (field_name) ->
            """<td>
            <span class="content"><%= #{field_name} %></span>
            <input class="input" name="#{field_name}" type="text" value="<%= #{field_name} %>"/>
            </td>
            """

        TableRowView = Backbone.View.extend(
            tagName: 'tr',
            template: _.template(
                _.map(schema, getTableCell).join('') + '''
                    <td><span class="edit">✎</span></td>
                    <td><span class="remove">✘</span></td>
                    <td><span class="save">Save</span></td>
                    '''
            )
            events:
                'click .edit': 'edit',
                'click .remove': 'remove',
                'keypress .input': 'updateOnEnter',
                'click .save': 'close'

            initialize: () ->
                _.bindAll(this, 'render', 'close', 'remove')

                @model.bind('change', @render)
                @model.bind('destroy', @remove)

            render: () ->
                console.log @model.toJSON()
                @$el.html(@template(@model.toJSON()))
                @input = []
                for field, i in schema
                    @input[i] = @$(".input[name=\"#{field}\"]")
                this

            edit: () ->
                $(@el).addClass('editing')
                @input[0].focus()

            close: () ->
                object = {}
                for field, i in schema
                    object[field] = @input[i].val()
                @model.save(object)
                $(@el).removeClass('editing')
                @trigger('data_saved')

            updateOnEnter: (e) ->
                if e.keyCode == 13
                    @close()

            remove: () ->
                $(@el).remove()

            destroy: () ->
                @model.destroy()
        )
        _.extend(TableRowView, Backbone.Events)

        TableView = Backbone.View.extend(
            el: element
            events: 
                'click .add-new': 'addNew',

            initialize: () ->
                _.bindAll(this, 'addOne', 'addAll', 'render')
                @render()
                Items.bind('add', @addOne)
                Items.bind('refresh', @addAll)
                Items.fetch()

                @adding_state = false

            render: () ->
                @$el.html('''
                    <table class="item-list"></table>
                    <button class="add-new">Add new</button>
                ''')
                this

            addOne: (item) ->
                view = new TableRowView(model: item)
                view.render()
                @$('.item-list').append(view.el)
                if @adding_state
                    view.edit()
                    view.on('data_saved', () => @adding_state = false)

            addAll: () ->
                Items.each(@addOne)

            addNew: () ->
                @adding_state = true
                Items.create(empty_fields)
        )
        TableWidget = new TableView

    createTableWidget($('#products')[0], 'products', ['name'])
    createTableWidget($('#vendors')[0], 'vendors', ['name', 'address'])
)
